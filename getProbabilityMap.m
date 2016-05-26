function [ probability_map ] = getProbabilityMap( locations, picture_size, sigma)

probability_map = zeros(picture_size(1), picture_size(2));

region_size = 401;
x=1:region_size;
y=(1:region_size)';               
[X,Y]=meshgrid(x,y);

z=exp(-((X-region_size/2).^2+(Y-region_size/2).^2)/(2*pi*sigma^2))/(2*pi*sigma^2);

for person = fieldnames(locations)'
    x_coor = locations.(person{1}).x;
    y_coor = locations.(person{1}).y;
    
    if isfield(locations, 'score') == 1
        score = locations.(person{1}).score;
    else
        score = 1;
    end
    
    cropped_exp = score * z(max(1,(region_size+1)/2-y_coor+1):min(region_size, picture_size(1)-y_coor+(region_size+1)/2),max(1,(region_size+1)/2-x_coor+1):min(region_size, picture_size(2)-x_coor+(region_size+1)/2));
    
    x_start = max(1,x_coor-(region_size-1)/2);
    x_stop = min(picture_size(2),x_coor+(region_size-1)/2);
    y_start = max(1,y_coor-(region_size-1)/2);
    y_stop = min(picture_size(1),y_coor+(region_size-1)/2);
   
    probability_map(y_start:y_stop, x_start:x_stop) = ...
        probability_map(y_start:y_stop, x_start:x_stop) + cropped_exp;  
end

figure();

surf(1:picture_size(2),1:picture_size(1),probability_map);shading interp

end

