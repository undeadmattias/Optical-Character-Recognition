function y = features2class(x, classification_data)
    bestImage = -1;
    bestImageDist = intmax('int64');
    
    trainSet = classification_data{1};
    groundTruth = classification_data{2};
    
    for i = 1:size(trainSet, 2)
        V = x - trainSet(:, i);
        dist = sqrt(V'*V);
 
        if dist < bestImageDist
            bestImageDist = dist;
            bestImage = i;
        end
    end
    y = groundTruth(bestImage); 
end