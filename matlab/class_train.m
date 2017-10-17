function [classification_data] = class_train(X,Y)
    classification_data = cell(2);
    classification_data{1} = X;
    classification_data{2} = Y;
end
