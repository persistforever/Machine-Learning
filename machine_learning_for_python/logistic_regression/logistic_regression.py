"""
perceptron algorithm
"""
import numpy as np
import string
import random as rd
import math

def import_data(name) :
    # import data from source file and store into dataSet
    # input : name - name of file
    # output : dataSet - attributes set of examples
    #          label - label of examples
    
    fo = open(name)
    tmpData = [listr.strip().split('\t') for listr in fo.readlines()]
    dataSet = [tmp[0:-1] for tmp in tmpData]
    label = [tmp[-1] for tmp in tmpData]
    for i in range(len(dataSet)) :
        for j in range(len(dataSet[0])) :
            dataSet[i][j] = string.atof(dataSet[i][j])
    for i in range(len(label)) :
        label[i] = string.atof(label[i])

    dataSet = np.matrix(dataSet)
    label = np.transpose(np.matrix(label))

    return [dataSet, label]
# --- end of import_data ---

def sigmoid(x) :
    # function of sigmoid
    # input : x - indenpendent varibles
    # output : y - dependent variable

    y = x ;
    for i in range(x.shape[0]) :
        y[i] = 1/(1+math.exp(-x[i]))

    return y
# --- end of sigmoid ---

def lr_training(trainData, trainLabel) :
    # logistic regression training algorithm
    # input : trainData - attributes set of examples
    #          trainLabel - label of examples
    # output : w - w in wx+b
    #          b - b in wx+b

    # step 1 : initialize w and b
    alpha = 0.000001
    w = np.matrix([[0]]*trainData.shape[1])
    b = 0
    numIter = 100
    type = 1 

    # step 2 : iterative w and b
    for i in range(numIter) :
        if type == 1 :
            # Batch gradient descent
            w_new = w + alpha * np.transpose(trainData)*(trainLabel - sigmoid(trainData*w+b))
            b_new = b + alpha * sum(trainLabel - sigmoid(trainData*w+b))
            w = w_new
            b = b_new
        elif type == 2 :        
            # Stochastic gradient descent
            pos = round(rd.random()*trainData.shape[0] - 0.5)
            w_new = w + alpha * np.transpose(trainData[pos])*(trainLabel[pos] - sigmoid(trainData[pos]*w+b))
            b_new = b + alpha * (trainLabel[pos] - sigmoid(trainData[pos]*w+b))
            w = w_new
            b = b_new
    
    return [w, b]
# --- end of lr_training ---

def lr_classifying(testData, w, b) :
    # logistic regression classifying
    # input : testData - attributes set of examples
    #         w - w in wx+b
    #         b - b in wx+b
    # output : classify_label - labels that classifier gives

    classify_label = np.matrix([[0]]*testData.shape[0])
    tmp = sigmoid(testData*w+b)
    for i in range(testData.shape[0]) :
        if tmp[i] >= 0.5 :
            classify_label[i] = 1.0
        else :
            classify_label[i] = 0.0

    return classify_label
# --- end of lr_classifying ---

[trainData, trainLabel] = import_data('horseColicTraining.txt')
[testData, testLabel] = import_data('horseColicTest.txt')
wrong = 0
times = 10
for i in range(times) :
    [w, b] = lr_training(trainData, trainLabel)
    classify_label = lr_classifying(testData, w, b)
    wrong_num = sum([1 for k in range(testLabel.shape[0]) if classify_label[k] != testLabel[k]])
    wrong += wrong_num
    print 'the wrong rate is', 1.0*wrong_num/testLabel.shape[0]
print 'the average wrong rate is', 1.0*wrong/(times*testLabel.shape[0])

