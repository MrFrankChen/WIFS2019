# from keras.datasets import mnist

# (X_train, X_test), (Y_train, Y_test) = mnist.load_data()

# print(X_train[0])


import numpy as np
import pandas as pd

E = {121, 144, 161, 169, 170, 188, 195}

for i in range(1, 198):

    if i in E:
        continue
    else:
        name = "Dataset/BigDataset/NormTrainForGAN/NormHuman" + str(i) + ".csv"
        data = pd.read_csv(name, header=None)

        result = np.asarray(data.loc[0:0])

        for j in range(1, len(data)+1):
            temp = np.asarray(data.loc[j:j])
            result = np.append(result, temp)

        # print(result.shape)
        # print(result)

        # print(len(data))

        result.resize((len(data)+1,1,29))

        # print(result.shape)
        # print(result)

        name = "Dataset/BigDataset/Converted/Human" + str(i) + ".npy"
        np.save(name, result)



