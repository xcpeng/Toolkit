import matplotlib.pyplot as plt
import torch
# from PIL import Image
from torchvision.utils import make_grid
from torchvision import models

from basenet import *

# G = ResBase('resnet101', pret=False)
# G.load_state_dict(torch.load('mcd_lr0.001_101_88.7_G_7.pth'))
# G.eval()

# C = ResClassifier(num_classes=215)
# C.load_state_dict(torch.load('mcd_lr0.001_101_88.7_F_7.pth'))
# C.eval()


model_ft = models.resnet101(pretrained=True)

kernels = model_ft.conv1.weight.detach().clone()
kernels = kernels - kernels.min()
kernels = kernels / kernels.max()

img = make_grid(kernels)
img = img.permute(1, 2, 0)
# print(img)
fig= plt.figure()
plt.imshow(img)
fig.savefig('image_net_conv1.png')

# img = Image(img)
# im1 = im1.save('conv1.png')
# plt.imshow(img.permute(1, 2, 0))
