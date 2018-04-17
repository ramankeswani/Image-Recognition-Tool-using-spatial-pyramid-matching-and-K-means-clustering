function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.
 dInput = [];
 
filterBank  = createFilterBank();

for i= 1 : size(imPaths)
    img = imread(imPaths{i});
    filterResponse = extractFilterResponses(img, filterBank);
    imgRe = reshape(filterResponse,[],60);
    ImSize = size(imgRe);
    randRow = randperm(ImSize(1),100);
    imgRe = imgRe(randRow,:);   
    dInput = cat(1,dInput,imgRe);
end

  [~, dictionary] = kmeans(dInput, 150, 'EmptyAction','drop');
end
