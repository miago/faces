classdef getKnownLocationsTest < matlab.unittest.TestCase
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Test)
        function testFirstPerson(testCase)
            locations = getKnownLocations();
            
            testCase.assertEqual(locations.picture_01.person_1.x, 652);
            testCase.assertEqual(locations.picture_01.person_1.y, 454);
        end
        
        function testPictureWithFourPersons(testCase)
            locations = getKnownLocations();
            
            % 23 496 211 668 427 866 375 952 312 
            testCase.assertEqual(locations.picture_23.person_1.x, 496);
            testCase.assertEqual(locations.picture_23.person_1.y, 211);
            testCase.assertEqual(locations.picture_23.person_2.x, 668);
            testCase.assertEqual(locations.picture_23.person_2.y, 427);
            testCase.assertEqual(locations.picture_23.person_3.x, 866);
            testCase.assertEqual(locations.picture_23.person_3.y, 375);
            testCase.assertEqual(locations.picture_23.person_4.x, 952);
            testCase.assertEqual(locations.picture_23.person_4.y, 312);
        end
        
        function testNoPersonInImage(testCase)
            
            locations = getKnownLocations();
            
            testCase.assertEqual(numel(fieldnames(locations.picture_36)), 0);
        end
    end
    
end

