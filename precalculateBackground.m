% precalculate_background

or_images = getORimages();
background = cell(length(or_images), 1);

filter_bank_size = 21;
x_resolution = 30;
y_resolution = 20;

for idx = 1:length(or_images)
    % precalculate background locations
    background{idx} = getBackgorundLocation(or_images{idx}, filter_bank_size, x_resolution, y_resolution);
    sprintf('image number %d', idx)
end



