function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

% TODO Implement your code
myWordMap = wordMap;
imagesc(myWordMap);
imgSize = size(myWordMap);
rows = imgSize(1);
cols = imgSize(2);
twoL = layerNum*2;

histo2 = [];
histo1 = [];
histo0 = [];

%for layer 2
for i = 1 : twoL
    y1 = round(1 + (i-1)*rows/twoL);
    y2 = round(i * rows/twoL);
    for j = 1: twoL
        x1 = round(1 + (j-1)*cols/twoL);
        x2 = round(j * cols/twoL);
     
        t1 = myWordMap(y1:y2,x1:x2,:);
       
        htemp2 = histogram(t1,dictionarySize);
        htemp2 = htemp2.Values;
        htemp2 = htemp2 ./2;
        htemp2 = htemp2 ./ sum(htemp2(:));
        histo2 =  cat(1,histo2,htemp2);
    end
end

%  for layer 1 now
for i = 1 : 2
    y1 = round(1 + (i-1)*rows/2);
    y2 = round(i * rows/2);
    for j = 1 : 2
        x1 = round(1 + (j-1)*cols/2);
        x2 = round(j * cols/2);
        
        t = myWordMap(y1:y2,x1:x2,:);
       
        htemp1 = histogram(t,dictionarySize);
        htemp1 = htemp1.Values;
        htemp1 = htemp1 ./4;
        htemp1 = htemp1 ./ sum(htemp1(:));
        
        histo1 =  cat(1,histo1,htemp1);
    end
end

% for layer 0
histo0 = histogram (myWordMap,dictionarySize);
histo0 = histo0.Values;
histo0 = histo0 ./ 4;
histo0 = histo0 ./ sum(histo0(:));

finalHist = cat(1,histo2,histo1,histo0);
finalHist = reshape(finalHist,1,21*dictionarySize);
finalHist = transpose(finalHist);

h = finalHist;
% plot(finalHist)
end