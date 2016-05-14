function [ y_coor,x_coor, score ] = getCorrelationLocationAndScore( normal_correlation )
%GETCORRELATIONLOCATIONANDSCORE Summary of this function goes here
%   Detailed explanation goes here

[maxes,maxes_i] =  max(normal_correlation);
[~, x_coor] = max(maxes);
y_coor = maxes_i(x_coor);

mmm = mean(mean(normal_correlation));

if mmm > 0.1
    score = 0;
elseif mmm > 0.05
    score = 0.5;
else
    score = 1;
end
   

end

