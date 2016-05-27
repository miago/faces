function locations = findpeaks(peak_map,threshold)
% peak_map=total_prob_map{1};
% threshold=0.85;
notface= peak_map<=threshold;
peak_map(notface)=0;
p=50;
for i=1:10
m=max(peak_map(:));
if m>0
[max_indx,max_indy]=find(peak_map==m);
peak_map(max_indx-p:max_indx+p,max_indy-p:max_indy+p)=zeros(p*2+1,p*2+1);
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