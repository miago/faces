function [ correlation_response ] = getFilterResponseCorrelation( response_1, response_2 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
correlation_response = sqrt(sum((response_1-response_2).^2));

end

