% Settings for assignments.

testingIterations = 100;
MethodSelection = 1; % 1 = our method, 2 = regression tree, 3 = support vector,
% 4 = nearest neighbour matlab
AssignmentSelection = 1; % Select which assignment. 1 = assign 2, 2 = assign 3.
 
switch AssignmentSelection
  case 1 % assign 2
      load FaceNonFace
      totalFeatureVectors = 200; 
  case 2 % assign 3
      assign3; % running assignment 3 script file. 
      totalFeatureVectors = 30; % there are 30 O's and C's in total
end

% NOTE: 3 takes a really long time. Use low iteration values. 

correctionRates = []; % Stores all rates for each iterations

for times = 1:testingIterations
    % Create test set and training set (randomly)
    
    part= cvpartition(totalFeatureVectors,'HoldOut',0.20); % 80 % of indexes for classifcation 20 % of indexes for testing the method on. 
    train_set = part.training; % One at every index used for training (random selection)
    test_set = part.test;  % One at every index used for testing (random selection)

    train_set_indexes = find(train_set == 1); % gets indexs for all random training sets
    test_set_indexes = find(test_set == 1); % get index for all random test set. 
    
    train_set_values = X(:, train_set_indexes'); % Gets all the testing columns for X. 361 x 160
    test_set_values = X(:, test_set_indexes'); % 361 x 40
    
    train_set_size = size(train_set_values, 2); % How many training and test image we got
    test_set_size = size(test_set_values, 2);
    
    
    
    switch MethodSelection %Selects which method to use for training
        case 1 % our own method (assn 2)
            [classification_data] = class_train(train_set_values, Y(:, train_set_indexes')); 
            % sends into the train function which just returns the values. 
            % Sends in just truth table (Y) for the training set.
            % Why? Because of how the code was written and testing set truth table
            % is used only outside the function in assign2.m
            
        case 2 % Matlab training classes below.
            % Our training values and truth table needs to be transposed 
            % To work with matlabs functions.
            tree = fitctree(train_set_values', Y(:, train_set_indexes')');
        case 3 % SVM (support Vector Machine.
            SVMModel = fitcsvm(train_set_values', Y(:, train_set_indexes')'); %fitcsvm(X,Y) doesn't work for more than 2 classes
        case 4 % nearest neightbour
            mdl = fitcknn(train_set_values', Y(:, train_set_indexes')');
    end
        
    
    
    
    
    % Run testing
    
    correctClassifications = 0; % Amount of correct classifcations
    
    
    % Test all test images for correct classification. 1 to 40 
    
    for testIndex = 1:test_set_size
        x = test_set_values(:, testIndex); % extract test value at index i.
        xIndexInY = test_set_indexes(testIndex); % The index of the X.
        
        correctY = Y(xIndexInY); % the correct Y
        switch MethodSelection %Selects which method to use for training
            case 1 % our own method (assn 2)
                y = classify(x, classification_data); % -1 = not face. 1 = face 
            case 2 % Matlabs classify functions below. Uses .predict to classify
                y = tree.predict(x');
            case 3 % Matlab nearest neightbour. Creates prediction tree
                y = SVMModel.predict(x');
            case 4
                y = mdl.predict(x');
                
        end       
        
        
        isCorrect = (correctY == y); 
        % If the returned value from classifier is same as truth table

        if isCorrect == 1
            correctClassifications = correctClassifications + 1;
        end
    end
   
    correctionRates = [correctionRates correctClassifications/test_set_size];
    % Correct classifications divided on how many things was
    % classified.
end
meanTruth = mean(correctionRates)
meanError = 1 - mean(correctionRates)

% Takes the mean of all the rates for all iterations to get a mean
% error/truth