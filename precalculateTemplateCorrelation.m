
close all;
clear all;
clc;

or_images = getORimages();
load('background_data.mat');

template_response = cell(length(or_images),1);

for idx = 1:length(or_images)
    idx
    current_or_image = or_images{idx};
    template_response{idx} = correlateWithTemplate(current_or_image, background{idx});
    
end

