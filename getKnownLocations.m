function [ locations ] = getKnownLocations(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
locations = struct;



[image_number,p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y] = importKnownFacesFile();



for img_id = 1:length(image_number)
    
    img_nr = image_number(img_id);
    image_string = sprintf('picture_%1.2d', img_nr);
    
    locations.(image_string) = struct;
    % TODO: get variable by name inside for loop

    if ~isnan(p1x(img_nr))
        person_string = sprintf('person_%d', 1);
        locations.(image_string).(person_string).x = p1x(img_nr);
        locations.(image_string).(person_string).y = p1y(img_nr);
        if ~isnan(p2x(img_nr))
            person_string = sprintf('person_%d', 2);
            locations.(image_string).(person_string).x = p2x(img_nr);
            locations.(image_string).(person_string).y = p2y(img_nr);
            if ~isnan(p3x(img_nr))
                person_string = sprintf('person_%d', 3);
                locations.(image_string).(person_string).x = p3x(img_nr);
                locations.(image_string).(person_string).y = p3y(img_nr);
                if ~isnan(p4x(img_nr))
                    person_string = sprintf('person_%d', 4);
                    locations.(image_string).(person_string).x = p4x(img_nr);
                    locations.(image_string).(person_string).y = p4y(img_nr);
                end
            end
        end
    end
end

end

