function [ probability_map ] = correlateWithTemplate( image, background)
%CORRELATE_WITH_TEMPLATE Summary of this function goes here
%   Detailed explanation goes here
% //////////////////////////////////
faces = getFaceTemplates();

locations = struct;

for idx=1:length(faces)
    
    this_face = faces{idx};
    
    clear correlation_response;
    
    correlation_response(:,:,1) = normxcorr2(this_face(:,:,1), image(:,:,1));
    correlation_response(:,:,2) = normxcorr2(this_face(:,:,2), image(:,:,2));
    correlation_response(:,:,3) = normxcorr2(this_face(:,:,3), image(:,:,3));

    %correlation_response(:,:,1) = correlation_response(:,:,1) / max(max(correlation_response(:,:,1)));
    %correlation_response(:,:,2) = correlation_response(:,:,2) / max(max(correlation_response(:,:,2)));
    %correlation_response(:,:,3) = correlation_response(:,:,3) / max(max(correlation_response(:,:,3)));
    

    resp = rgb2gray(correlation_response);
    
    [y,x, score] = getCorrelationLocationAndScore(resp);
    
    if background(y,x) == 1
        person_name = sprintf('person_%d',idx);
        locations.(person_name).x = max(1,x - floor(size(this_face,2)/2));
        locations.(person_name).y = max(1,y - floor(size(this_face,1)/2));
        locations.(person_name).score = score;
    end
end


probability_map = getProbabilityMap(locations, [720 1280], 40);

end

