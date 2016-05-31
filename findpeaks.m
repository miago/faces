function locations = findpeaks(peak_map,threshold)
% peak_map=total_prob_map{8};
% threshold=0.85;
notface= peak_map<=threshold;
peak_map(notface)=0;
p=70; 
for i=1:10
m=max(peak_map(:));
if m>0
[max_indx,max_indy]=find(peak_map==m);
    if max_indx-p>0 && max_indx+p<=length(peak_map)&&max_indy-p>0&&max_indy+p<=length(peak_map)
peak_map(max_indx-p:max_indx+p,max_indy-p:max_indy+p)=zeros(p*2+1,p*2+1);
    break;
    elseif max_indx-p2>0 && max_indx+p2<=length(peak_map)&&max_indy-p2>0&&max_indy+p2<=length(peak_map)
 p2=50;
        peak_map(max_indx-p2:max_indx+p2,max_indy-p2:max_indy+p2)=zeros(p2*2+1,p2*2+1); break;       
    elseif max_indx-p3>0 && max_indx+p3<=length(peak_map)&&max_indy-p3>0&&max_indy+p3<=length(peak_map)
 p3=30;
        peak_map(max_indx-p3:max_indx+p3,max_indy-p3:max_indy+p3)=zeros(p3*2+1,p3*2+1); break;
      elseif max_indx-p3>0 && max_indx+p3<=length(peak_map)&&max_indy-p3>0&&max_indy+p3<=length(peak_map)
 p3=10;
        peak_map(max_indx-p3:max_indx+p3,max_indy-p3:max_indy+p3)=zeros(p3*2+1,p3*2+1); break;
    else
    p3=0;
        peak_map(max_indx-p3:max_indx+p3,max_indy-p3:max_indy+p3)=zeros(p3*2+1,p3*2+1); break;    
    end
% BW=bwareaopen(peak_map,30); peak_map=peak_map.*BW;
for j=1:length(max_indx)
locations{i}=[max_indx(j),max_indy(j)];
if length(max_indx)>1
i=i+1;
end
end
end
end


end