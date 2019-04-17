        feature_all = np.array([])
        label_all = []
        for batch_idx, data in enumerate(self.dataset_test):
            img = data['T']
            label = data['T_label']
            # print(label)
            img, label = img.cuda(), label.long().cuda()
            img, label = Variable(img, volatile=True), Variable(label)
            feat = self.G(img)
            print('feature.shape:{}'.format(feat.shape))
            # for t-SNE plot
            if batch_idx == 0:
            	label_all = label.data.cpu().numpy().tolist()
            	
            	feature_all = feat.data.cpu().numpy()
            else:
            	feature_all = np.ma.row_stack((feature_all, feat.data.cpu().numpy()))
            	feature_all = feature_all.data
            	label_all = label_all + label.data.cpu().numpy().tolist()

            	#print(label_all)
            	#label_all = np.ma.row_stack((label_all, label.data.cpu().numpy()))
            	#label_all = label_all.data
          np.savez('result_plot_sv_t', feature_all, label_all )
          
import numpy as np
from sklearn.manifold import TSNE
from matplotlib import pyplot as plt
# import prettyplotlib as ppl
tsne = TSNE(n_components=2, random_state=0)

len_ =500
data = np.load('result_plot_sv_t_85.npz')
feature = data['arr_0'][:len_]
print(feature.shape)
labels = data['arr_1'][:len_]
print(labels.shape)

X_2d = tsne.fit_transform(feature)
plt.figure(figsize=(2,2))

font = {'family' : 'normal',
        'size'   : 7}

plt.rc('font', **font)

target_ids = range(10)
colors = '#FF0000', '#0066FF', '#FF0096', '#00FFFF', '#00FF64', '#C8FF00', '#33FF00', '#3300FF', '#C800FF', '#FF9600'
makers = 'o', 'v','>','<','*','+','^','x','D',','
#makers = 'o','o','o','o','o','o','o','o','o','o'
for i, c, m in zip(target_ids,colors, makers):
    plt.scatter(X_2d[labels == i, 0], X_2d[labels == i, 1], edgecolors='none', marker=m, s=15,facecolors=c)
plt.tight_layout()
plt.show()
