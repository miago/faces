function [ face_templates ] = getFaceTemplates()
%GETFACETEMPLATES Summary of this function goes here
%   Detailed explanation goes here
% usage: 
%            faces = getFaceTemplates();
%            face1 = cell2mat(faces{1});

lst = dir(strcat('face_templates/','*.png'));

nr_pictures = size(lst, 1);

face_templates = cell(nr_pictures, 1);

for a = 1:nr_pictures
    tmp_image = imread(strcat('face_templates/', lst(a).name));
   	face_templates{a} = tmp_image;   
end

end

