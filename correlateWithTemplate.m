function [ resp ] = correlateWithTemplate( image, template_image )
%CORRELATE_WITH_TEMPLATE Summary of this function goes here
%   Detailed explanation goes here
% //////////////////////////////////
if iscell(template_image)
    resp = cell(length(template_image), 1);
end

for i=1:length(template_image)
    
    if iscell(template_image)
        tmp_image = cell2mat(template_image{i});
    else
        tmp_image = template_image;
    end
    
    clear correlation_response;

    correlation_response(:,:,1) = normxcorr2(tmp_image(:,:,1), image(:,:,1));
    correlation_response(:,:,2) = normxcorr2(tmp_image(:,:,2), image(:,:,2));
    correlation_response(:,:,3) = normxcorr2(tmp_image(:,:,3), image(:,:,3));

    correlation_response(:,:,1) = correlation_response(:,:,1) / max(max(correlation_response(:,:,1)));
    correlation_response(:,:,2) = correlation_response(:,:,2) / max(max(correlation_response(:,:,2)));
    correlation_response(:,:,3) = correlation_response(:,:,3) / max(max(correlation_response(:,:,3)));
    
    if iscell(template_image)
        resp{i} = mat2cell(rgb2gray(correlation_response), size(correlation_response,1), size(correlation_response,2));
    else
        resp = rgb2gray(correlation_response);
    end


end

end

