clc; clear all; close all;

use_preloaded = true;

if use_preloaded
    
    
    load('background_data.mat');
    load('Color_output.mat');
    load('change_percentage.mat');
    load('template_response.mat');
    
end

or_images = getORimages();

total_prob_map = cell(length(or_images), 1);

for idx = 1:length(or_images)
    
    current_image = or_images{idx};
    
    if use_preloaded
        current_background = background{idx};
        color_probability_map = double(Color_output{idx})/max(max(double(Color_output{idx})));
        templates_probability_map = template_response{idx}/max(max(template_response{idx}));
        texture_probability_map = zeros(720, 1280);
        last_position_probability_map = zeros(720, 1280);
    else
        current_background = getBackgorundLocation(current_image, 31, 30, 50);
        color_probability_map = getColorProbability(current_image, current_background);
        texture_probability_map = getTextureProbability(current_image, current_background);
        templates_probability_map = getTemplateProbability(current_image, current_background);
        if idx == 1
            BGsubtraction(current_image, zeros(720, 1280));
        else
            BGsubtraction(current_image,or_images{idx-1});
        end
    end

    c_w = 1;
    tmp_w = 5;
    tex_w = 0;
    last_w = 0;
    
    total_prob_map{idx} = c_w*color_probability_map + tmp_w * templates_probability_map + tex_w * texture_probability_map + last_w * last_position_probability_map;
    total_prob_map{idx} = total_prob_map{idx}/(c_w+tmp_w+tex_w+last_w);
    
    %figure();
    %imshow(total_prob_map{idx}); colormap summer;
    
    sprintf('image number %d', idx)
end

