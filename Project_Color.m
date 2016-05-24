% Project_color(masks)
clear all;close all;
I=imread('/Users/apple/Documents/Image_processing/Project/project_train_data/0007.png');
% figure(4);imshow(I)
I=double(I);
R=I(:,:,1);G=I(:,:,2);B=I(:,:,3);
% figure(1);imshow(uint8(R))
% figure(2);imshow(uint8(G))
% figure(3);imshow(uint8(B))
[l,w,s]=size(I);
I_blur=I;
 index_face=zeros(l,w);
for i=1:l-30
    for j=1:w-30    
        R_patch=R(i:i+30,j:j+30);
        G_patch=G(i:i+30,j:j+30);
        B_patch=B(i:i+30,j:j+30);
        if mean(G_patch(:))-mean(R_patch(:))>27 && mean(G_patch(:))-mean(B_patch(:))>15
%             for k=1:3
%             I_blur(i:i+30,j-10:j+20,k)=myconv2(I_G(i:i+30,j-10:j+20),gauss2d(1));
%             end
% if j-40>
I_blur(i-40:i+20,j:j+30,1)=zeros(61,31)+mean(R_patch(:));
I_blur(i-40:i+20,j:j+30,2)=zeros(61,31)+mean(G_patch(:));
I_blur(i-40:i+20,j:j+30,3)=zeros(61,31)+mean(B_patch(:));
index_face(i,j)=1;
        end     
    end
end
[x,y]=find(index_face==1);
imshow(uint8(I_blur))