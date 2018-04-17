function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

load('dictionary.mat');
load('../data/traintest.mat');

interval= 1;
interval_label = 1;
% TODO create train_features

train_imagenames = train_imagenames(1:interval:end);
train_imagenames_word_map = erase(train_imagenames(:),".jpg");
wordmaps  = strcat('../data/',train_imagenames_word_map,'.mat');

dictionarySize = size(dictionary);

%  this is for hitograms/train_feautes start
train_features = [];
wm = [];
for i=1 : size(train_imagenames)
    wm = load(wordmaps{i});
    wm = wm.wordMap; 
    [h] = getImageFeaturesSPM(2,wm, dictionarySize(2));   
    train_features = cat(2,h,train_features);  
end

filterBank = createFilterBank();
train_labels = train_labels(1:interval_label:end);

save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end