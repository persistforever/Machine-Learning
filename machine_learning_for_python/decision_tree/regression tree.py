"""
regression tree model and algorithm
"""
import numpy as np
import string

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
    dataSet = np.array(dataSet)
    label = np.array(label)

    return [dataSet, label]
# --- end of import_data ---

def plot_data(dataSet, label) :
    # plot data in dataSet
    # output : dataSet - attributes set of examples
    #          label - label of examples

    import matplotlib
    import matplotlib.pyplot as plt
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.plot(dataSet, label, 'ro')
    plt.show()
    
    return 
# --- end of plot_data ---

def bisplit_data(dataSet, label, attr_pos, value_pos) :
    # split data into 2 sets
    # input : dataSet - attributes set of examples
    #         label - label of examples
    #         attr_pos - position of which attr to split
    #         value_pos - position of value of attr to split
    # output : splitedData - splited dataSet
    #          splitedLabel - splited label

    value = dataSet[value_pos, attr_pos]
    left_data = np.array([dataSet[k][attr_pos] for k in range(int(dataSet.shape[0])) if dataSet[k][attr_pos] < value])
    left_label = np.array([label[k] for k in range(int(dataSet.shape[0])) if dataSet[k][attr_pos] < value])
    right_data = np.array([dataSet[k][attr_pos] for k in range(int(dataSet.shape[0])) if dataSet[k][attr_pos] >= value])
    right_label = np.array([label[k] for k in range(int(dataSet.shape[0])) if dataSet[k][attr_pos] >= value])
    splitedData = [left_data,right_data]
    splitedLabel = [left_label, right_label]

    return [splitedData, splitedLabel]

# --- end of bisplit_data ---

def CART_tree(dataSet, label) :
    # create CART tree recursively
    # input : dataSet - attributes set of examples
    #         label - label of examples

    # recursion exit
    if len(set(label)) <= 1 :
        return label[0]
    # recursion body
    attr_error = [0]*int(dataSet.shape[1])
    attr_pos = [0]*int(dataSet.shape[1])
    for i in range(int(dataSet.shape[1])) :
        value_error = [0]*int(dataSet.shape[0])
        for j in range(int(dataSet.shape[0])) :
            left = np.array([[dataSet[k,i], label[k]] for k in range(int(dataSet.shape[0])) if dataSet[k,i] < dataSet[j,i]])
            right = np.array([[dataSet[k,i], label[k]] for k in range(int(dataSet.shape[0])) if dataSet[k,i] >= dataSet[j,i]])
            if len(left) > 0 :
                avg = sum(left[:,1])/len(left[:,1])
                value_error[j] += sum((left[:,1] - [avg]*len(left[:,1]))**2)
            if len(right) > 0 :
                avg = sum(right[:,1])/len(right[:,1])
                value_error[j] += sum((right[:,1] - [avg]*len(right[:,1]))**2)
        attr_error[i] = min(value_error)
        attr_pos[i] = value_error.index(min(value_error))
    pos = attr_error.index(min(attr_error))
    print pos
    # binary_split dataSet
    [splitedData, splitedLabel] = bisplit_data(dataSet, label, pos, attr_pos[pos])
    tree = {}
    tree['<'] = CART_tree(np.array([tmp[0] for tmp in splitedData]), np.array([tmp[0] for tmp in splitedLabel]))
    tree['>='] = CART_tree(np.array([tmp[1] for tmp in splitedData]), np.array([tmp[1] for tmp in splitedLabel]))
    return { [pos,attr_pos[pos]] : tree }

[dataSet, label] = import_data('section_constent.txt')
print CART_tree(dataSet, label)
# plot_data(dataSet, label)
