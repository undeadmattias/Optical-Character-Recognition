function y = classify(x, classification_data)
    bestImage = -1; % default best image index.
    bestImageDist = intmax('int64'); % Default really high distance.
    
    train_set = classification_data{1}; % X vector part only for training (160) 
    truthTableX = classification_data{2}; % Truth table for trainign data (160)
    
    for i = 1:size(train_set, 2) % Loops through columns of training set.
        V = x - train_set(:, i); % Takes distance to train_set at index i to test data x.
        dist = sqrt(V'*V); % calculates distance
 
        if dist < bestImageDist % finds training image index with lowest distance to x. 
            bestImageDist = dist;
            bestImage = i;
        end
    end
    y = truthTableX(bestImage); 
    % returns 1 if face, 0 if not face.
    %
 
end