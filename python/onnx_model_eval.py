import numpy as np
import onnxruntime as ort
from tqdm import tqdm
import cv2
from pathlib import Path
from prettytable import PrettyTable
import torch

def get_top(scores):
    top_score = -10000
    top_idx = -1

    for idx, value in enumerate(scores):
        if value > top_score:
            top_score = value
            top_idx = idx

    return (top_idx, top_score)

def format_float_list(floats):
    return ["{:.3E}".format(val) for val in floats]

def format_percent_list(percents):
    return ["{:.1f}%".format(val) for val in percents]

session_opts = ort.SessionOptions()
session_opts.graph_optimization_level = ort.GraphOptimizationLevel.ORT_ENABLE_ALL
session_opts.intra_op_num_threads = 12
session_opts.log_severity_level = 3 # squelch the graph optimization warnings
session = ort.InferenceSession("test_fl_mtl.onnx", session_opts)

pytorch_model = torch.load("test_fl.pth")
pytorch_model.eval()

labels = [ "Annie", "Armin", "Connie", "Eren", "Erwin", "Hange", "Historia", "Levi", "Mikasa", "Reiner", "Sasha" ]

# create dict of images, indexed by the integer in the file name (e.g. 1.jpg)
imgs = {int(img_file.stem) : img_file for img_file in Path("vis_imgs/").iterdir()}
n_imgs = len(imgs)

# generate vis scores by running onnx model
vis_scores = []
vis_top = []
for i in tqdm(range(n_imgs)):
    bbox = np.float32([[0, 0, 0, 1, 1]])
    disable_preproc = np.bool8([False])
    disable_base_model = np.bool8([False])

    img_file = imgs[i]
    img = np.expand_dims(cv2.imread(str(img_file)), 0).astype(np.float32)
    outputs = session.run(["output"], {"disable_preprocess": disable_preproc, "disable_base_model": disable_base_model, "image": img, "bbox": bbox})

    vis_scores.append(outputs[0][0])

    top_idx, top_score = get_top(vis_scores[-1])
    vis_top.append({"label": labels[top_idx], "score": top_score})

# # read in pytorch scores from csv
# pytorch_scores = []
# pytorch_top = []
# with open("validation_10_result_flattened.csv") as f:
#     for line in f:
#         line = line.strip()

#         pytorch_scores.append([float(score) for score in line.split(',')])
        
#         top_idx, top_score = get_top(pytorch_scores[-1])
#         pytorch_top.append({"label": labels[top_idx], "score": top_score})

# generate scores using onnx preprocessing and pytorch model
pytorch_scores = []
pytorch_top = []
for i in tqdm(range(n_imgs)):
    bbox = np.float32([[0, 0, 0, 1, 1]])
    disable_preproc = np.bool8([False])
    disable_base_model = np.bool8([True])

    img_file = imgs[i]
    img = np.expand_dims(cv2.imread(str(img_file)), 0).astype(np.float32)
    preprocessed_image = session.run(["processed_image"], {"disable_preprocess": disable_preproc, "disable_base_model": disable_base_model, "image": img, "bbox": bbox})[0]

    pytorch_results = pytorch_model(torch.tensor(preprocessed_image))
    pytorch_scores.append(outputs[0][0])

    top_idx, top_score = get_top(pytorch_scores[-1])
    pytorch_top.append({"label": labels[top_idx], "score": top_score})

# build tables and print
with open("comparison.txt",'w') as f:
    for i in range(n_imgs):
        f.writelines(f"IMAGE: {i}.jpg\n")

        top_scores_table = PrettyTable(["name", "top_label", "top_score"])
        top_scores_table.add_row(["vis", vis_top[i]["label"], vis_top[i]["score"]])
        top_scores_table.add_row(["pytorch", pytorch_top[i]["label"], pytorch_top[i]["score"]])
        f.writelines(str(top_scores_table) + "\n")

        scores_diff_abs = abs(vis_scores[i] - pytorch_scores[i])
        scores_diff_percent = (scores_diff_abs / pytorch_scores[i]) * 100

        full_scores_table = PrettyTable(["name"] + labels)
        full_scores_table.add_row(["vis"] + format_float_list(vis_scores[i]))
        full_scores_table.add_row(["pytorch"] + format_float_list(pytorch_scores[i]))
        full_scores_table.add_row(["diff"] + format_float_list(scores_diff_abs))
        full_scores_table.add_row(["diff (relative to torch)"] + format_percent_list(scores_diff_percent))
        f.writelines(str(full_scores_table) + "\n\n")
