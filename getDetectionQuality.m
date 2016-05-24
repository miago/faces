function [nr_right_id_faces, nr_FP, nr_FN ] = getDetectionQuality(true_face_locations, my_detections, tollerance_radius)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

nr_FN = 0;
nr_FP = 0;
nr_right_id_faces = 0;

for picture_id = fieldnames(true_face_locations)'
    for person_id = fieldnames(true_face_locations.(picture_id{1}))'
        
        true_x = true_face_locations.(picture_id{1}).(person_id{1}).x;
        true_y = true_face_locations.(picture_id{1}).(person_id{1}).y;
        
        person_found = false;
        
        if numel(fieldnames(my_detections.(picture_id{1}))) > 0
            for my_person_id = fieldnames(my_detections.(picture_id{1}))'
                my_x = my_detections.(picture_id{1}).(my_person_id{1}).x;
                my_y = my_detections.(picture_id{1}).(my_person_id{1}).y;

                distance = sqrt( (true_x - my_x)^2 + (true_y - my_y)^2 );

                if distance <= tollerance_radius

                    my_detections.(picture_id{1}).(my_person_id{1}).x = -1e6;
                    my_detections.(picture_id{1}).(my_person_id{1}).y = -1e6;
                    % make sure this poin will never ever ever used to detect
                    % another face. Also used to detect the false positives
                    person_found = true;
                    break;
                end
            end
        end
        % breaks until here
        
        if person_found == true
            nr_right_id_faces = nr_right_id_faces + 1;
        else
            nr_FN = nr_FN + 1;
        end
    end
end
for picture_id = fieldnames(my_detections)'
    if numel(fieldnames(my_detections.(picture_id{1}))) > 0
        for person_id = fieldnames(my_detections.(picture_id{1}))'  
            if my_detections.(picture_id{1}).(person_id{1}).x >= 0
                nr_FP = nr_FP + 1;
            end
        end
    end
end

end

