function [ location ] = getBackgorundLocation( image, filterBankSize,y_res, x_res)
%GETBACKGORUNDLOCATION Summary of this function goes here
%   Detailed explanation goes here

response = [];
for ii=0:3
    I = double(rgb2gray(imread(sprintf('tile_textures/tile%02d.png',ii))));
    response{ii+1} = calculateFilterBankResponse(I(:,:), filterBankSize);
end

texture_size_x = size(I, 2);
texture_size_y = size(I, 1);

% convolve the image with the filter bank and look at its response

% don't convolve at every position.

% size is:   720        1280

total = y_res * x_res;

y_positions = floor(linspace(texture_size_y/2+1, 720-texture_size_y/2-1, y_res));
x_positions = floor(linspace(texture_size_x/2+1, 1280-texture_size_x/2-1, x_res));


this_picture = rgb2gray(image);
for y_idx = 1:length(y_positions)
    for x_idx = 1:length(x_positions)
        y_position = y_positions(y_idx);
        x_position = x_positions(x_idx);
        image_patch = this_picture(y_position-texture_size_y/2+1:y_position+texture_size_y/2, x_position-texture_size_x/2+1:x_position+texture_size_x/2);

        resp = calculateFilterBankResponse(image_patch, filterBankSize);
        r1 = getFilterResponseCorrelation(resp, response{1});
        
        resp_with_image(y_idx, x_idx) = r1;
    end 
    
    sprintf('%f %% Done', y_idx/y_res*100)
end

figure(); imagesc(resp_with_image); colorbar;
picture_scaled = imresize(resp_with_image, [720, 1280]);



ab=reshape(picture_scaled,1280*720,1);
[idx, center] = kmeans(ab, 2);
final_background=reshape(idx,720,1280);
figure(); imshow(final_background, []);

total_2 = 0;
cnt_2 = 0;
total_1 = 0;
cnt_1 = 0;
for cnt = 1:length(idx)
    if idx(cnt) == 2
        total_2 = total_2 + ab(cnt);
        cnt_2 = cnt_2 + 1;
    else
        total_1 = total_1 + ab(cnt);
        cnt_1 = cnt_1 + 1;
    end
end

mean_2 = total_2 / cnt_2;
mean_1 = total_1 / cnt_1;



if mean_2 > mean_1
    % 1s represent the background
    final_background = final_background - 1;
    
else
    % 2s represent the background
    final_background = -1.*(final_background - 2);
end
se = strel('disk', 100);
closed_image = imclose(final_background, se);
figure(); imshow(closed_image, []);

background_subtracted_image_r = double(closed_image).*double(image(:,:,1));
background_subtracted_image_g = double(closed_image).*double(image(:,:,2));
background_subtracted_image_b = double(closed_image).*double(image(:,:,3));
background_subtracted_image(:,:,1) = background_subtracted_image_r;
background_subtracted_image(:,:,2) = background_subtracted_image_g;
background_subtracted_image(:,:,3) = background_subtracted_image_b;
figure();imshow(uint8(background_subtracted_image))

end

