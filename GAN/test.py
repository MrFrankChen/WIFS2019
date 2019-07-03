import numpy as np

name = "Dataset/BigDataset/Converted/Human" + str(1) + ".npy"
X_train = np.load(name)
a = X_train.shape[0]
print(a)