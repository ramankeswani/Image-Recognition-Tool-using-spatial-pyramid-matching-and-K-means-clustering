function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix
load('vision.mat');
load('../data/traintest.mat');
disp(mapping);
% % TODO Implement your code here

interval = 1;
test_imagenames = test_imagenames(1:interval:end);
interval_label = 1;
test_labels = test_labels(1:interval_label:end);

test_imagenames =  strcat('../data/',test_imagenames);
% guessedImage = [];
C = zeros(8,8);
for i = 1 : size(test_imagenames)
    abc = guessImage(test_imagenames{i});
    k = find(strcmp(mapping,abc));
    orgIndex = test_labels(i);
    if(k == orgIndex)
        C(k,k) = C(k,k) +1 ;
    else
        C(orgIndex,k) = C(orgIndex,k) +1;
    end
end
save('c.mat');
load('../code/c.mat');
disp(C);

effeciency = (trace(C) / sum(C(:)))*100;
disp(effeciency);
end