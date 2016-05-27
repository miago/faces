% FindMask_image: masks locations on the original image. 
% Color_output: binary image of masks location.
function [FindMask_image,Color_output]=ColorDetect(I,BG)
I=double(I);
R=I(:,:,1);G=I(:,:,2);B=I(:,:,3);
[BG_x,BG_y]=find(BG==1);
[l,w,s]=size(I);
I_Mask=I;
 index_face=zeros(l,w);
 patch_s=20;
BG_ind=[BG_x,BG_y];
for i=1:length(BG_ind)
   x_=BG_ind(i,1); y_=BG_ind(i,2);
   if x_-patch_s/2>0 && x_+patch_s/2<=l && y_-patch_s/2>0 && y_+patch_s/2<=w 
        R_patch=R(x_-patch_s/2:x_+patch_s/2,y_-patch_s/2:y_+patch_s/2);
        G_patch=G(x_-patch_s/2:x_+patch_s/2,y_-patch_s/2:y_+patch_s/2);
        B_patch=B(x_-patch_s/2:x_+patch_s/2,y_-patch_s/2:y_+patch_s/2);
        if mean(G_patch(:))-mean(R_patch(:))>25 && mean(G_patch(:))-mean(B_patch(:))>20
 I_Mask(x_-10:x_+10,y_-10:y_+10,1)=zeros(21,21);
I_Mask(x_-10:x_+10,y_-10:y_+10,2)=zeros(21,21);
I_Mask(x_-10:x_+10,y_-10:y_+10,3)=zeros(21,21);
index_face(x_-10:x_+10,y_-10:y_+10)=1;
        end     
   end
end
xy=find(index_face==1);
mask=zeros(l,w);
mask(xy)=1;
LB = 50; UB = 5000;
Color_output=xor(bwareaopen(mask,LB), bwareaopen(mask,UB));
FindMask_image=I_Mask;

end