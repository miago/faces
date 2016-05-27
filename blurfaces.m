function I_blur=blurfaces(I, locations)
% I=ALL_I{1};
I_blur=I;
R=I(:,:,1);G=I(:,:,2);B=I(:,:,3);
p=45;
for i=1:length(locations)
    ind=locations{i}; 
    x=ind(1); y=ind(2);
%    I(x,y,1:3)=0;
        R_patch=R(x-p:x+p,y-p:y+p);
        G_patch=G(x-p:x+p,y-p:y+p);
        B_patch=B(x-p:x+p,y-p:y+p);    
I_blur(x-p:x+p,y-p:y+p,1)=zeros(2*p+1,2*p+1)+mean(R_patch(:));
I_blur(x-p:x+p,y-p:y+p,2)=zeros(2*p+1,2*p+1)+mean(G_patch(:));
I_blur(x-p:x+p,y-p:y+p,3)=zeros(2*p+1,2*p+1)+mean(B_patch(:));
   
end
%  imshow(I_blur)
end