function liv_show_classification(ax, I_veins,flag_pv)
idx_pv=find(flag_pv==1);
idx_cv=find(flag_pv==0);
I_pv=[]; I_cv=[];
for i=1:length(idx_pv)
  I_pv=[I_pv,I_veins{idx_pv(i)}];  
end
for i=1:length(idx_cv)
  I_cv=[I_cv,I_veins{idx_cv(i)}];  
end
cc_max=max(size(I_cv,2),size(I_pv,2));
cc_max=ceil(cc_max/120)*120;
%cc_min=max(size(I_cv,2),size(I_pv,2));
I_pv=padarray(I_pv,[0,cc_max-size(I_pv,2),0],'post');
I_cv=padarray(I_cv,[0,cc_max-size(I_cv,2),0],'post');
II=[I_pv;I_cv];

tp1=I_pv(:,1:120,:);
tp2=I_cv(:,1:120,:);
for i=1:ceil(cc_max/120)-1
  tp1=[tp1; I_pv(:,i*120+1:(i+1)*120,:)];
  tp2=[tp2; I_cv(:,i*120+1:(i+1)*120,:)];
end
III=[tp1,zeros(12*ceil(cc_max/120),12,3),tp2];
imshow(III,'Parent',ax);