function [ filterResponse ] = calculateFilterBankResponse( image , filterBankSize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
F   = makeLMfilters(filterBankSize);

MAP = [];
CC  = 12;
RR  = 4;
for r=0:(RR-1)
    ROW = [];
    for c=0:(CC-1)
        ix  = (r*CC)+c+1;
        ROW = [ROW F(:,:, ix )];
    end
    MAP = [MAP ; ROW];
end


for f=1:48
    R(:,:,f) = conv2(double(image),double(F(:,:,f)),'same');
end
II{1} = R;

nbFeat = size(II{1},3);
nbRows = size(II{1},1);
nbCols = size(II{1},2);

BB      = abs(II{1});
C{1}   = reshape(BB,[nbRows*nbCols,48]);
H(1,:) = sum(C{1});
H(1,:) = H(1,:)./sum(H(1,:));

filterResponse = H(1,:)';


end

