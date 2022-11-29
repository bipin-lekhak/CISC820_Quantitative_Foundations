#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# import packages
import numpy as np
import matplotlib.pyplot as plt
import sklearn
import os
from PIL import Image 


# In[ ]:


# load 400 images 
folder_pth = '/Users/wangjiamian/Desktop/RIT/820/project4/att_faces'


# In[ ]:


# functions 

def read_img(folder_pth, img_num=400):
    '''
    img_num: imgs in the output tensor. 
             If 400, then all imgs, 
             If <400, randomly taken from 400 no matter of classes
    '''
    img_set = []
    for i in range(1,41):
        img_Si_pth = folder_pth + '/s%d'%i
        for j in range(1,11):
            img_Si_j_pth = img_Si_pth + '/%d.pgm'%j
            img = np.array(Image.open(img_Si_j_pth), dtype=np.float32) # (112,92)
            # print(img.shape)
            # plt.imshow(img, cmap='gray')
            # plt.show()
            img_set.append(img)
            
    img_set = np.array(img_set)
    if img_num <400:
        index_ls = np.random.choice(400, size=img_num, replace=False)
        img_set = img_set[index_ls, :,:]
    print(img_set.shape)
    return img_set

img_set = read_img(folder_pth)


# In[ ]:


# use PCA to extract eigenfaces on all 400 images
def eigen_face(data):
    N, H, W = data.shape
    data = data.reshape(N, H*W)
    print(data.shape)
    
    # compute mean
    mean = np.mean(data, axis=0)
    print(mean.shape)
    data_normed = data - mean
    print(data_normed.shape)
    
    # compute Cov
    Cov = np.cov(data_normed, rowvar=0)
    print(Cov.shape)
    
    # compute eigenvec 
    eigen_val, eigen_vec = np.linalg.eig(Cov)
    print(eigen_val.shape)
    print(eigen_vec.shape)
    
    return eigen_val, eigen_vec
    
    
# test
eigen_val, eigen_vec = eigen_face(img_set) 
np.save('./eigen.npy', {'eigen_val':eigen_val, 'eigen_vec': eigen_vec})


# # Please start from this block once have eigen_vec and eigen_val saved.
# # For the sake of the efficiency

# In[ ]:


subset_img_num = 10 # randomly choose 10 images out of 400 for reconstruction
eigen_vec_num_vis = 30 # the number of the principle components for reconstruction results visualization


# In[ ]:


# choose eigen vectors
def eigenface_determine(eigen_val, eigen_vec, percent=.95):
    
    eigen_vec = np.array(eigen_vec, dtype=np.float32)
    eigen_val = np.array(eigen_val, dtype=np.float32)
    
    sort_idx = np.argsort(eigen_val) # from small to large
    sort_idx = sort_idx[-1::-1]
    eigen_vec = eigen_vec[:, sort_idx] # all sorted eigen_vec
    print('sort finished')
    
    # use percentage to determine the indexes
    energy = np.sum(eigen_val)
    energy_recurradd = 0
    
    for idxidx, idx in enumerate(sort_idx):
        
        energy_recurradd = eigen_val[idx] + energy_recurradd
        print('%d, current percent=%f'%(idxidx, energy_recurradd/energy))
        
        if energy_recurradd >= energy*percent:
            print('Found. Percent: %f, # eigen vectors: %d'%(percent, idxidx))
            eigen_vec = eigen_vec[:, :idxidx]
            eigen_val = eigen_val[:idxidx]
            break 
            
    print(eigen_val.shape)
    print(eigen_vec.shape)
    return eigen_val, eigen_vec 
    
eigen_info = np.load('./eigen.npy', allow_pickle=True).item()
eigen_val = eigen_info['eigen_val']
eigen_vec = eigen_info['eigen_vec']
print(eigen_val.shape)
print(eigen_vec.shape)
    
eigen_val, eigen_vec = eigenface_determine(eigen_val, eigen_vec, percent=.99)

eigen_val_num99 = len(eigen_val)


# In[ ]:


# plot the eigen value curve

fig = plt.figure(figsize=(12, 8),
                edgecolor='black')
lg_font_mine = {'family': 'Times New Roman', 'weight': 'medium', 'size': 15,}
total_len = len(eigen_val)

plt.xlim(0, total_len)
plt.xticks(np.arange(0, total_len, 10))
plt.xlabel("Eigenvalue index",
          fontsize=20,
           family='Times New Roman',
           weight='medium')
ax1 = fig.add_subplot(111)

x_plot = np.arange(total_len)

ori_curve = ax1.plot(x_plot, 
                     eigen_val, 
                     color='r',lw=1.7,alpha=0.8)

# plt.yticks(np.arange(0, eigen_val.max()+1, 100))

ax1.set_ylabel("Eigenvale",
              fontsize=20,
           family='Times New Roman',
           weight='medium')


ax1.grid(alpha=0.6)
plt.show()


# In[ ]:


# plot the eigen value curve (energy)

total_energy = np.sum(eigen_val)

fig = plt.figure(figsize=(12, 8),
                edgecolor='black')
lg_font_mine = {'family': 'Times New Roman', 'weight': 'medium', 'size': 15,}
total_len = len(eigen_val)

plt.xlim(0, total_len)
plt.xticks(np.arange(0, total_len, 10))
plt.xlabel("Eigenvalue index",
          fontsize=20,
           family='Times New Roman',
           weight='medium')
ax1 = fig.add_subplot(111)

x_plot = np.arange(total_len)

ori_curve = ax1.plot(x_plot, 
                     eigen_val/total_energy, 
                     color='g',lw=1.7,alpha=0.8)

plt.yticks(np.arange(0, .2, 0.01))

ax1.set_ylabel("Importance (energy percent,%)",
              fontsize=20,
           family='Times New Roman',
           weight='medium')


ax1.grid(alpha=0.6)
plt.show()


# In[ ]:


# eigen vec visualization
def eigenface_visal(eigen_vec):
    H, W = 112,92
    N = eigen_vec.shape[-1]
    eigen_vec = eigen_vec.reshape(H, W, N)
    print(eigen_vec.shape)
    print(eigen_vec)
    
    for i in range(N):
        figure = plt.figure(figsize=(4,6))
        plt.imshow(eigen_vec[:,:,i], cmap='gray')
        plt.axis('off')
        plt.show()

print(type(eigen_vec))
eigenface_visal(eigen_vec)


# In[ ]:


# reconstructe function

def reconstruct(subset, eigen_vec, eigen_vec_num):
    '''
    folder_pth: folder path of the image data
    subset_num: num of imgs in the subset
    eigen_vec: all of the eigen_vec
    eigen_vec_num: choose the number of priciple componenets
    
    [out]
    gt: ground truth of the images
    pred: predictions by PCA 
    '''
        
    N, H, W = subset.shape
    subset = subset.reshape(N, H*W)
    print(subset.shape)
    
    
    # normlize by mean
    subset_mean = np.mean(subset, axis=0)
    subset = subset - subset_mean
    print(subset_mean.shape)
    
    # determine the subset of principle components
    assert eigen_vec_num < eigen_vec.shape[-1], 'ERROR: should choose a subset of the eigenvecs'
    subset_eigen_vec = eigen_vec[:, :eigen_vec_num]
    print(subset_eigen_vec.shape)
    
    # reconstruction
    pred = np.matmul(np.matmul(subset, subset_eigen_vec), subset_eigen_vec.T) + subset_mean
    print(pred.shape)
    
    return subset, pred
    
    
    
subset = read_img(folder_pth=folder_pth, img_num=subset_img_num)
subset, pred = reconstruct(subset=subset, eigen_vec=eigen_vec, eigen_vec_num=eigen_vec_num_vis)


# In[ ]:


# prediction visualization

def visualize_gt_pred(gt, pred):
    
    H, W = 112, 92
    N=gt.shape[0]
    gt = gt.reshape(N, 112, 92)
    pred = pred.reshape(N, 112, 92)
    
    for idx in range(N):
        plt.figure(figsize=(5,8))
        plt.subplot(2,1,1)
        plt.title('gt img %d'%idx)
        plt.imshow(gt[idx], cmap='gray')
        plt.axis('off')
        
        plt.subplot(2,1,2)
        plt.title('pred img %d'%idx)
        plt.imshow(pred[idx], cmap='gray')
        plt.axis('off')
        
        plt.show()

visualize_gt_pred(gt=subset, pred=pred)


# In[ ]:


# plot the MAE curve upon different eigen_vec_num
def MAE(gt, pred):
    return np.mean(np.abs(pred-gt))

eigen_vec_subset_ls = np.arange(10, eigen_val_num99, 10)
eigen_vec_subset_ls = eigen_vec_subset_ls[-1::-1]
print(eigen_vec_subset_ls)

MAE_ls = []
subset = read_img(folder_pth=folder_pth, img_num=10)

for eigen_vec_subset_val in eigen_vec_subset_ls:

    gt, pred = reconstruct(subset=subset, eigen_vec=eigen_vec, eigen_vec_num=eigen_vec_subset_val)
    val = MAE(gt,pred)
    MAE_ls.append(val)

print(MAE_ls)
    

fig = plt.figure(figsize=(8, 6),
                edgecolor='black')
lg_font_mine = {'family': 'Times New Roman', 'weight': 'medium', 'size': 15,}

plt.xlim(0, eigen_val_num99)
# plt.xticks(np.arange(0, eigen_vec_subset_ls))
plt.xlabel("# principle components",
           fontsize=20,
           family='Times New Roman',
           weight='medium')
ax1 = fig.add_subplot(111)

ori_curve = ax1.plot(eigen_vec_subset_ls, 
                     MAE_ls, 
                     color='b',lw=1.7,alpha=0.8)

# plt.yticks(np.arange(0, .2, 0.01))

ax1.set_ylabel("Mean absolute error",
              fontsize=20,
           family='Times New Roman',
           weight='medium')


ax1.grid(alpha=0.6)
plt.show()


# In[ ]:


# 

