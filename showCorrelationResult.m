%% get the data
clc; clear variables; close all;

faces = getFaceTemplates();
ORimages = getORimages();

corr_result = correlateWithTemplate(cell2mat(ORimages{1}), faces);

%%

% this is for Tiffany
figure();
subplot(3,4,1)
imagesc(cell2mat(faces{1}));
subplot(3,4,2);
imagesc(cell2mat(corr_result{1}));
subplot(3,4,3)
surf(cell2mat(corr_result{1}));
subplot(3,4,4)
imagesc(cell2mat(ORimages{1}));
hold on;
[x,y,score] = getCorrelationLocationAndScore(cell2mat(corr_result{1}));
if score > 0.4
    plot(x,y, 'o')
end

subplot(3,4,5)
imagesc(cell2mat(faces{2}));
subplot(3,4,6);
imagesc(cell2mat(corr_result{2}));
subplot(3,4,7)
surf(cell2mat(corr_result{2}));
subplot(3,4,8)
imagesc(cell2mat(ORimages{2}));
hold on;
[x,y,score] = getCorrelationLocationAndScore(cell2mat(corr_result{2}));
if score > 0.4
    plot(x,y, 'o')
end

subplot(3,4,9)
imagesc(cell2mat(faces{3}));
subplot(3,4,10);
imagesc(cell2mat(corr_result{3}));
subplot(3,4,11)
surf(cell2mat(corr_result{3}));
subplot(3,4,12)
imagesc(cell2mat(ORimages{3}));
hold on;
[x,y,score] = getCorrelationLocationAndScore(cell2mat(corr_result{1}));
if score > 0.4
    plot(x,y, 'o')
end