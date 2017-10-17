load FaceNonFace
numberOfVectors = 200;
iterations = 10;

correctionRates = [];

for times = 1:iterations
    % Prepare the data for testing
    part = cvpartition(numberOfVectors,'HoldOut',0.20);

    % Change the ones to an index number
    trainSetIndexes = find(part.training == 1);
    testSetIndexes = find(part.test == 1);
    testSetValues = X(:, testSetIndexes');
 
    % Nearest neighbour is used and therefore the classification data is
    % the same as the truth table.
    [classification_data] = class_train(X(:, trainSetIndexes'), Y(:, trainSetIndexes')); 
    
    correctClassifications = 0;
    
    % Test
    for testIndex = 1:test_set_size
        x = testSetValues(:, testIndex);
        xIndexInY = testSetIndexes(testIndex);
        
        correctY = Y(xIndexInY);
        y = classify(x, classification_data);

        isCorrect = (correctY == y); 
        if isCorrect == 1
            correctClassifications = correctClassifications + 1;
        end
    end
   
    correctionRates = [correctionRates correctClassifications/size(testSetValues, 2)];
end
meanTruth = mean(correctionRates)
meanError = 1 - mean(correctionRates)

imageExample = [X(1:19,1)];

for i = 1:17
    
    imageExample = [imageExample X(i*19 + 1:(i+1)*19,1)];
end
    
    
    
    
    
