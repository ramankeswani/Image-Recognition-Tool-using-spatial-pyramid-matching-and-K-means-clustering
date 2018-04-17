function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs:
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses
% TODO Implement your code here


[~,~,chan] = size(img);

if chan == 1
    img = repmat(img,[1 1 3]);
end

imgLAB = RGB2Lab(img);
[filterBank] = createFilterBank();
fBankSize = size(filterBank);
outImg = [];

for i=1 : fBankSize(1)
    %     outImg =  cat(4,outImg,imfilter(imgLAB,filterBank{i}));
    outImg =  cat(3,outImg,imfilter(imgLAB,filterBank{i}));
end

%  montage(outImg,'size',[4 5]);
filterResponses = outImg;

end