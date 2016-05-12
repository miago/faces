function [ face_templates ] = getFaceTemplates()
%GETFACETEMPLATES Summary of this function goes here
%   Detailed explanation goes here

lst = dir(strcat('face_templates/','*.png'));

nr_pictures = size(lst, 1);

face_templates = cell(nr_pictures, 1);

for a = 1:nr_pictures
    tmp_image = imread(strcat('face_templates/', lst(a).name));
   	face_templates{a} = mat2cell(tmp_image, size(tmp_image,1), size(tmp_image,2), 3);   
end

end
