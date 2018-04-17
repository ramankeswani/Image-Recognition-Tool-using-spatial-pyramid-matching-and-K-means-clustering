function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

% TODO Implement your code here

imgSize = size(img);
rowsNum = imgSize(1);
colNum = imgSize(2);
D = [];
filterResp = extractFilterResponses(img,filterBank);
img  = [];
for i=1 : rowsNum
    for j=1 : colNum
        myResp = filterResp(i,j,:);
        myResp = reshape(myResp,[],60);
        D = pdist2(myResp,transpose(dictionary),'euclidean');
        [~, index] = min(D);
        img(i,j) = index;
    end
end
wordMap = img;
end
