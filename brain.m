clc; clear all; close all;

load('background_data.mat');

or_images = getORimages();



for idx = 1:length(or_images)
    
    current_background = background{idx};
    current_image = or_images{idx};
    
    c_w = 4.5;
    tmp_w = 5;
    tex_w = 5;
    last_w = 6;
    
    color_probability_map = getColorProbability(current_image, current_background);
    %color_probability_map = colorProbMap{idx};
    templates_probabolity_map = getTemplateProbability(current_image, current_background);
    texture_probability_map = getTextureProbability(current_image, current_background);
    if idx == 1
        BGsubtraction(current_image, zeros(720, 1280));
    else
        BGsubtraction(current_image,or_images{idx-1});
    end
    last_position_probability_map = getLastPositionProbability(old_locations, scene_change);
    
    total_prob_map = c_w*color_probability_map + tmp_w * templates_probabolity_map + tex_w * texture_probability_map + last_w * last_position_probability_map;
    total_prob_map = total_prob_map/(c_w+tmp_w+tex_w+last_w);
    
    sprintf('image number %d', idx)
end

