'''
Created on Dec 16, 2017

@author: xpeng
'''

import numpy as np
import matplotlib.pyplot as plt
from analyze_toolbox import _parse_from_file_start_end, _parse_from_file_start

'''
Created on Dec 16, 2017

@author: xpeng
'''


import numpy as np
import matplotlib.pyplot as plt

def _parse_from_file_start(file_name, key_sentence):
    train_loss_re = []
    with open(file_name) as f:
        content = f.readlines()
        for line in content:
            if key_sentence in line:
                start_point = line.find(key_sentence)
                loss = line[start_point+len(key_sentence):]
                train_loss_re.append(float(loss))
    return train_loss_re

# parse log where both the starting point and ending point are need to be 
# defined, e.g. "fc8_mmd_loss = -5.05682 (* 1 = -5.05682 loss)"
#  We need to key sentence to find the starting point and the end key to find the end

def _parse_from_file_start_end(file_name, key_sentence, end_key_sentence):
    test_loss_re = []
    with open(file_name) as f:
        content = f.readlines()
        for line in content:
            if key_sentence in line:
                start_point =line.find(key_sentence)
                end_point = line.find(end_key_sentence)
                loss = line[start_point + len(key_sentence):end_point]
                test_loss_re.append(float(loss))
    return test_loss_re





file_list = []
labels  = ['baseline', 'mmd_on_image']
softmax_loss_key = 'Train net output #2: softmax_loss = '
accuracy_key = 'Test net output #0: lp_accuracy = '

softmax_loss = []
accuracy = []

for i in range(0, len(file_list)):
    softmax_loss_of_i = _parse_from_file_start_end(file_list[i], softmax_loss_key, '(*')
    softmax_loss.append(softmax_loss_of_i) 
    accuracy_of_i = _parse_from_file_start(file_list[i], accuracy_key)
    accuracy.append(accuracy_of_i)
    

#plot training loss

plt.figure("training loss")
for i in range(0, len(file_list)):
    plt.plot(np.arange(len(softmax_loss[i])), softmax_loss[i], label=labels[i])
plt.xlabel("Training Iterations (x20)")
plt.ylabel("Training Loss")
plt.legend()
plt.tight_layout()
plt.show()

plt.figure("accuracy")
for i in range(0, len(file_list)):
    plt.plot(np.arange(len(accuracy[i])), accuracy[i], label=labels[i])
plt.xlabel("Training Iterations (x20)")
plt.ylabel("Accuracy")
plt.legend()
plt.tight_layout()
plt.show()



file_list = []
labels  = ['baseline', 'mmd_on_image']
softmax_loss_key = 'Train net output #2: softmax_loss = '
accuracy_key = 'Test net output #0: lp_accuracy = '

softmax_loss = []
accuracy = []

for i in range(0, len(file_list)):
    softmax_loss_of_i = _parse_from_file_start_end(file_list[i], softmax_loss_key, '(*')
    softmax_loss.append(softmax_loss_of_i) 
    accuracy_of_i = _parse_from_file_start(file_list[i], accuracy_key)
    accuracy.append(accuracy_of_i)
    

#plot training loss

plt.figure("training loss")
for i in range(0, len(file_list)):
    plt.plot(np.arange(len(softmax_loss[i])), softmax_loss[i], label=labels[i])
plt.xlabel("Training Iterations (x20)")
plt.ylabel("Training Loss")
plt.legend()
plt.tight_layout()
plt.show()

plt.figure("accuracy")
for i in range(0, len(file_list)):
    plt.plot(np.arange(len(accuracy[i])), accuracy[i], label=labels[i])
plt.xlabel("Training Iterations (x20)")
plt.ylabel("Accuracy")
plt.legend()
plt.tight_layout()
plt.show()
