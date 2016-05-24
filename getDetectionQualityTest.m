classdef getDetectionQualityTest < matlab.unittest.TestCase
    %  Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
       
    methods (Test)
        function banalOnePointTesting(testCase)
            true_detections = struct;
            true_detections.picture_01.person_01.x = 60;
            true_detections.picture_01.person_01.y = 23;

            my_detections.picture_01.person_01.x = 60;
            my_detections.picture_01.person_01.y = 23;
            
            [nr_right_id_faces, nr_FP, nr_FN ] = getDetectionQuality(true_detections, my_detections, 1);
            
            testCase.assertEqual(nr_right_id_faces, 1);
            testCase.assertEqual(nr_FN, 0);
            testCase.assertEqual(nr_FP, 0);
        end

        
        function testTwoFaces(testCase)
            true_detections.picture_01.person_01.x = 60;
            true_detections.picture_01.person_01.y = 23;
            true_detections.picture_01.person_02.x = 400;
            true_detections.picture_01.person_02.y = 400;
            
            my_detections.picture_01.person_01.x = 62;
            my_detections.picture_01.person_01.y = 22;
            my_detections.picture_01.person_02.x = 403;
            my_detections.picture_01.person_02.y = 399;            
            
            [nr_right_id_faces, nr_FP, nr_FN ] = getDetectionQuality(true_detections, my_detections, 5);
            
            testCase.assertEqual(nr_FP, 0);
            testCase.assertEqual(nr_FN, 0);
            testCase.assertEqual(nr_right_id_faces, 2);
            
        end
        
        function testFalseNegatives(testCase)
            true_detections.picture_01.person_01.x = 60;
            true_detections.picture_01.person_01.y = 23;
            true_detections.picture_01.person_02.x = 400;
            true_detections.picture_01.person_02.y = 400;
            
            my_detections.picture_01.person_01.x = 0;
            my_detections.picture_01.person_01.y = 0;
            my_detections.picture_01.person_02.x = 1000;
            my_detections.picture_01.person_02.y = 1000;            
            
            [nr_right_id_faces, nr_FP, nr_FN ] = getDetectionQuality(true_detections, my_detections, 5);
            
            testCase.assertEqual(nr_right_id_faces, 0);
            testCase.assertEqual(nr_FN, 2);
            testCase.assertEqual(nr_FP, 2);
        end
        
        function testAllInOne(testCase)
            true_detections.picture_01.person_01.x = 60;
            true_detections.picture_01.person_01.y = 23;
            true_detections.picture_01.person_02.x = 400;
            true_detections.picture_01.person_02.y = 400;
            true_detections.picture_02.person_01.x = 100;
            true_detections.picture_02.person_01.y = 2000;
            true_detections.picture_02.person_02.x = 400;
            true_detections.picture_02.person_02.y = 460;
            
            my_detections.picture_01.person_02.x = 60;
            my_detections.picture_01.person_02.y = 23;
            my_detections.picture_01.person_01.x = 123123;
            my_detections.picture_01.person_01.y = 234234;
            
            my_detections.picture_02 = struct;
            
            [nr_right_id_faces, nr_FP, nr_FN ] = getDetectionQuality(true_detections, my_detections, 5);
            
            testCase.assertEqual(nr_right_id_faces, 1);
            testCase.assertEqual(nr_FP, 1);
            testCase.assertEqual(nr_FN, 3);
          
        end
    end
    
end

