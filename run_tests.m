close all;
clear all
clc;

import matlab.unittest.TestSuite
suiteFolder = TestSuite.fromFolder(pwd, 'IncludingSubfolders', false);

result = run(suiteFolder);