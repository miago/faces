function [ correlation_response ] = correlateWithTemplate( image, template_image )
%CORRELATE_WITH_TEMPLATE Summary of this function goes here
%   Detailed explanation goes here

correlation_response(:,:,1) = normxcorr2(template_image(:,:,1), image(:,:,1));
correlation_response(:,:,2) = normxcorr2(template_image(:,:,2), image(:,:,2));
correlation_response(:,:,3) = normxcorr2(template_image(:,:,3), image(:,:,3));

correlation_response(:,:,1) = correlation_response(:,:,1) / max(max(correlation_response(:,:,1)));
correlation_response(:,:,2) = correlation_response(:,:,2) / max(max(correlation_response(:,:,2)));
correlation_response(:,:,3) = correlation_response(:,:,3) / max(max(correlation_response(:,:,3)));


correlation_response = rgb2gray(correlation_response);

end

