% Project_BGsubtraction
function [output,change_per,series_I]=BGsubtraction(ALL_I)
% ALL_I=getORimages( );
for i=1:length(ALL_I)-1
I_Sub{i}=ALL_I{i+1}-ALL_I{i};
end
% for i=1:39
% subplot(5,3,i);imshow(uint8(I_Sub{i}))
% end
si_I=size(I_Sub{i});
mask2={};
for i=1:39
tmp=I_Sub{i};
tmp=abs(reshape(tmp,si_I(1)*si_I(2),3));
tmp_S{i}=tmp(:,1)+tmp(:,2)+tmp(:,3);
% hist(tmp_S{i})
mask=ones(si_I(1)*si_I(2),1);% imshow(uint8(I_Sub{4}))
ind_change=find(tmp_S{i}>100);
mask(ind_change)=0;
mask2{i}=reshape(mask,si_I(1),si_I(2));% figure(2);imshow(mask)
% calculate the percentage of difference
count_change=length(find(mask2{i}==0));
change_per(i)=count_change/(si_I(1)*si_I(2));
end
% for i=1:39
% subplot(5,8,i);imshow(mask2{i})
% end
sig_ind=find(change_per<=0.08);
% 
out1=cell(2,length(sig_ind));
for i=1:length(sig_ind)
index=sig_ind(i);
BW1=mask2{index};
BW1=medfilt2(BW1,[3,3]);
BW2=edge(BW1, 'canny');
se=strel('disk',20);
BW3=imclose(BW2,se);
BW4=bwareaopen(BW3,400);%BW4=imclose(BW4,se);
out1{1,i}=index;
out1{2,i}=BW4;
end
% for i=1:length(out1)
% subplot(5,ceil(length(out1)/5),i);imshow(out1{2,i})
% end
for i=1:length(out1)
    tmp=out1{2,i};
    x1=find(tmp==1);
    x0=find(tmp==0);
    tmp(x1)=0;tmp(x0)=1;
    out1{2,i}=tmp;
end

output=cell(1,length(ALL_I));
for i=1:length(ALL_I)
    if find(sig_ind==i)>0
        x=find(sig_ind==i);
        output{i}=out1{2,x};
    else
        output{i}=zeros(si_I(1),si_I(2));
    end
end

for i=1:sig_ind
        tmp1=output{i};
    tmp2=output{i+1};
    output{i}=tmp1.*tmp2;
    if i==length(ALL_I)-1
        output{i}=output(i-1);
    end
end
% --------------
 continuous_scene=zeros(1,length(output));
change_ind=continuous_scene;
for i=1:length(sig_ind)-1
    if sig_ind(i)+1==sig_ind(i+1)
%         continuous_scene(i)=sig_ind(i);
%         continuous_scene(i+1)=sig_ind(i+1);
    else
        change_ind(i)=i+1;
    end
end
if change_ind(1)==0
    change_ind(1)=1;
end
change_ind=nonzeros(change_ind);

for i=1:length(change_ind)
    if i==length(change_ind)
        series_I{i}=sig_ind(change_ind(i):end);
    else
    series_I{i}=sig_ind(change_ind(i):change_ind(i+1)-1);
    end
end
% % §ädifference³Ì¤j­È?

% masks¬Û­¼
tmp=output;
for i=1:length(series_I)
    sum=ones(si_I(1),si_I(2));
    I_n=series_I{i};
%     tmp=output(I_n);
    for j=I_n
    sum=sum.*tmp{j};
    end
    for k=I_n
    output{k}=sum;
    end
    I_n=[I_n,I_n(end)+1];
      series_I{i}=I_n;
end

if series_I{end}==length(ALL_I)-1
    output(length(ALL_I))=output(length(ALL_I)-1);
end

for i=1:length(output)
    tmp=output{i};
    x1=find(tmp==1);
    x0=find(tmp==0);
    tmp(x1)=0;tmp(x0)=1;
    output{i}=tmp;
end
% for i=1:40
% subplot(5,8,i);imshow(output{i})
% end

end