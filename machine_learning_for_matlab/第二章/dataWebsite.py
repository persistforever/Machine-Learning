def file2Matrix(filename) :
    fr = open(filename)
    arrayOnlines = fr.readlines()
    numberOfLines = len(arrayOnlines)
    returnMatrix = zeros((numberOfLines,3))
    classLabel = []

    index = 0
    for line in arrayOnlines :
        line = line.strip() 
        listFromLine = line.split('\t')
        returnMatrix[index,:] = listFromLine[0:3]
        classLabel.append(int(listFromLine[-1]))
        index += 1
    return returnMat, classLabel
