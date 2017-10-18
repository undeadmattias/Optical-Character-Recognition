load ocrfeaturestrain

% 1 regression tree
% 2 support vector
% 3 nearest neighbour
method = 2;

% Take out the letters C and O from the data set
indexYOfCO = (Y == 3 | Y == 15);
X = X(:, indexYOfCO);
Y = Y(:, indexYOfCO);

numberOfVectors = 30;
correctionRates = [];
trainingCorrectionRates = [];

for times = 1:100
    % Create test set and training set
    correctClassifications = 0;
    part= cvpartition(numberOfVectors,'HoldOut',0.20);

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
    
    % Training error
    correctTrainingClassifications = 0;
    for trainingIndex = 1:size(trainSetValues, 2)
        trainingX = trainSetValues(:, trainingIndex);
        
        correctTrainingY = Y(trainSet(trainingIndex));
        switch method
            case 1
                trainingY = RegressionTree.predict(trainingX');
            case 2
                trainingY = SupportVectorMachine.predict(trainingX');
            case 3
                trainingY = NearestNeighbour.predict(trainingX');
        end       

        if (correctTrainingY == trainingY) == 1
            correctTrainingClassifications = correctTrainingClassifications + 1;
        end
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
    trainingCorrectionRates = [trainingCorrectionRates correctTrainingClassifications/size(trainSetValues, 2)];
end
meanTruth = mean(correctionRates)
meanError = 1 - mean(correctionRates)
meanTrainingTruth = mean(trainingCorrectionRates)
