"""
perceptron algorithm
"""
import numpy as np
import string
import random as rd

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
        if label[i] == 0 :
            label[i] = -1.0

    dataSet = np.array(dataSet)
    label = np.array(label)

    return [dataSet, label]
# --- end of import_data ---

def plot_data(dataSet) :
    # plot data in dataSet
    # output : dataSet - data set of examples

    import matplotlib
    import matplotlib.pyplot as plt
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.plot(range(len(dataSet)), dataSet, 'ro-')
    plt.show()
    
    return 
# --- end of plot_data ---

def error_distance_sum(dataSet, label, w, b) :
    # calculate the distance of all the wrong points
    # input : dataSet - attributes set of examples
    #         label - label of examples
    #         w - w in wx+b
    #         b - b in wx+b
    # output : dist - distance of all the wrong points

    each_dist = []
    dist = 0
    for i in range(len(dataSet)) :
        t = (np.matrix(w) * np.transpose(np.matrix(dataSet)[i,:]) + b)[0,0]
        each_dist.append(t * label[i])
    wrong_dist = [tmp for tmp in each_dist if tmp < 0]
    dist = abs(1.0 * sum(wrong_dist) / (np.matrix(w) * np.transpose(np.matrix(w)))[0,0])
                                    
    return dist
# --- end of error_distance_sum ---

def perceptron_train(dataSet, label) :
    # training perceptron with dataSet
    # input : dataSet - attributes set of examples
    #         label - label of examples
    # output : w - w in wx+b
    #          b - b in wx+b

    # step 1 : initialize
    numIter = 100 # iteration
    m = len(dataSet) # number of examples
    n = len(dataSet[0]) # number of attributes
    alpha = 0.1 # learning factor
    w = [0] * n
    b = 0
    
    # step 2 : iterative
    for i in range(numIter) :
        trainLabel = []
        for j in range(m) :
            t = (np.matrix(w) * np.transpose(np.matrix(dataSet)[j,:]) + b)[0,0]
            if t > 0 :
                trainLabel.append(1.0)
            else :
                trainLabel.append(-1.0)
        errorSet = [dataSet[k,:] for k in range(m) if trainLabel[k] * label[k] <= 0]
        errorLabel = [label[k] for k in range(m) if trainLabel[k] * label[k] <= 0]
        if len(errorSet) <= 0 :
            break ;
        pos = int(round(rd.random() * (len(errorSet)) - 0.5))
        
        # update w and b(Stochastic gradient descent method)
        for j in range(n) :
            w[j] = w[j] + alpha * errorSet[pos][j] * errorLabel[pos]
        b = b + alpha * errorLabel[pos]
        """
        # if you want to use Batch gradient descent method, please release these code
        # update w and b(Batch gradient descent method)
        for j in range(n) :
            w[j] = w[j] + alpha * (1.0 * np.matrix(errorLabel) * np.matrix(errorSet)[:,j] / len(errorSet))[0,0]
        b = b + alpha * sum(errorLabel)
        """
    
    return [w, b]
# --- end of perceptron_train ---

def perceptron_classify(testData, w, b) :
    # training perceptron with dataSet
    # input : testData - attributes set of examples for test
    #         w - w in wx+b
    #         b - b in wx+b
    # output : testLabel - use trainer training label for test

    testLabel = [] 
    for i in range(len(testData)) :
        t = (np.matrix(w) * np.transpose(np.matrix(testData)[i,:]) + b)[0,0]
        if t > 0 :
            testLabel.append(1.0)
        else :
            testLabel.append(-1.0)

    return testLabel
# --- end of perceptron classify ---


"""
main function of algorithm
"""
def main() :
    [trainData, trainLabel] = import_data('horseColicTraining.txt')
    [testData, testLabel] = import_data('horseColicTraining.txt')
    [w, b] = perceptron_train(trainData, trainLabel)
    # print error_distance_sum(trainData, trainLabel, w, b)
    label = perceptron_classify(testData, w, b)
    wrong_rate = 1.0*(sum([1 for k in range(len(testLabel)) if label[k]*testLabel[k] < 0]))/len(testLabel)
    print 'wrong rate is', wrong_rate
# --- end of main ---
main()
