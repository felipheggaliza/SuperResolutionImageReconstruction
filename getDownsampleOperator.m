function  D = getDownsampleOperator(numRows, numColumns, factor)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%D = abs(downsample(tensor,factor) / tensor); 

D = zeros(numRows, numColumns);

%D(1,1) = 1;

for i=1:1:numRows
    D(i, i*factor - 1) = 1;
end

