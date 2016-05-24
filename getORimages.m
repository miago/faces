function [ or_images ] = getORimages(  )
%GET_OR_IMAGES Summary of this function goes here
%   Detailed explanation goes here

lst = dir(strcat('project_train_data/','*.png'));
    
nr_pictures = size(lst, 1);

or_images = cell(nr_pictures, 1);

for a = 1:nr_pictures
    tmp_image = imread(strcat('project_train_data/', lst(a).name));
    
   	or_images{a} = tmp_image;   
end

end

