load ocrfeaturestrain

% 1 regression tree
% 2 support vector
% 3 nearest neighbour
method = 3;

% Take out the letters C and O from the data set
indexYOfCO = (Y == 3 | Y == 15);
X = X(:, indexYOfCO);
Y = Y(:, indexYOfCO);

numberOfVectors = 30;
correctionRates = [];

for times = 1:100
    % Create test set and training set
    correctClassifications = 0;
    part= cvpartition(numberOfVectors,'HoldOut',0.80);

    trainSet = find(part.training == 1);
    testSet = find(part.test == 1);

    trainSetValues = X(:, trainSet');
    testSetValues = X(:, testSet');

    % Machine Learning Training for the different methods
    switch method
        case 1
            RegressionTree = fitctree(trainSetValues', Y(:, trainSet')');
        case 2
            SupportVectorMachine = fitcsvm(trainSetValues', Y(:, trainSet')');
        case 3
            NearestNeighbour = fitcknn(trainSetValues', Y(:, trainSet')');
    end

    % Testing
    for testIndex = 1:size(testSetValues, 2)
        x = testSetValues(:, testIndex);
        
        correctY = Y(testSet(testIndex));
        switch method
            case 1
                y = RegressionTree.predict(x');
            case 2
                y = SupportVectorMachine.predict(x');
            case 3
                y = NearestNeighbour.predict(x');
        end       

        if (correctY == y) == 1
            correctClassifications = correctClassifications + 1;
        end
    end
    correctionRates = [correctionRates correctClassifications/size(testSetValues, 2)];
end
meanTruth = mean(correctionRates)
meanError = 1 - mean(correctionRates)
