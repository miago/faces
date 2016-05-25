% Project_color(masks)
% ALL_I=getORimages();
% load('/Users/apple/Downloads/background_data.mat')
function [FindMask_image,Color_output]=Project_Color(ALL_I,background)
FindMask_image=cell(1,40);
Color_output=cell(1,40);
for z=1:length(ALL_I)
I=ALL_I{z}; %figure(1);imshow(uint8(I))
I=double(I);
R=I(:,:,1);G=I(:,:,2);B=I(:,:,3);
BG=background{z};
[BG_x,BG_y]=find(BG==1);
% figure(1);imshow(uint8(R));figure(2);imshow(uint8(G));figure(3);imshow(uint8(B))
[l,w,s]=size(I);
I_Mask=I;
 index_face=zeros(l,w);
 patch_s=20;
% for i=BG_x(1:end) % 1+patch_s/2:l-patch_s/2
%     for j=BG_y(1:end) % 1+patch_s/2:w-patch_s/2
BG_ind=[BG_x,BG_y];
for i=1:length(BG_ind)
   x_=BG_ind(i,1); y_=BG_ind(i,2);
   if x_-patch_s/2>0 && x_+patch_s/2<=l && y_-patch_s/2>0 && y_+patch_s/2<=w 
        R_patch=R(x_-patch_s/2:x_+patch_s/2,y_-patch_s/2:y_+patch_s/2);
        G_patch=G(x_-patch_s/2:x_+patch_s/2,y_-patch_s/2:y_+patch_s/2);
        B_patch=B(x_-patch_s/2:x_+patch_s/2,y_-patch_s/2:y_+patch_s/2);
        if mean(G_patch(:))-mean(R_patch(:))>25 && mean(G_patch(:))-mean(B_patch(:))>20
%  I_Mask(x_,y_,1:3)=ones(1,3);
 I_Mask(x_-10:x_+10,y_-10:y_+10,1)=zeros(21,21);
I_Mask(x_-10:x_+10,y_-10:y_+10,2)=zeros(21,21);
I_Mask(x_-10:x_+10,y_-10:y_+10,3)=zeros(21,21);
index_face(x_-10:x_+10,y_-10:y_+10)=1;
        end     
   end
end% end
%  imshow(uint8(I_Mask))
xy=find(index_face==1);
mask=zeros(l,w);
mask(xy)=1;
% figure(2);imshow(mask)
LB = 50; UB = 5000;
mask2=xor(bwareaopen(mask,LB), bwareaopen(mask,UB));
% figure(4);imshow(mask2)
FindMask_image{z}=I_Mask;
Color_output{z}=mask2;
end

end

