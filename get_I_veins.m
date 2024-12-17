function [I_veins,na]=get_I_veins(pos,sz,I1,I2,I3)
xy_start=floor(pos-sz/2);
vein_pos=[xy_start,xy_start+sz]; 
I_veins=[];
I_veins(:,:,1)=I2(vein_pos(2):vein_pos(4),vein_pos(1):vein_pos(3))-0.4;
I_veins(:,:,2)=I1(vein_pos(2):vein_pos(4),vein_pos(1):vein_pos(3))-0.4;
I_veins(:,:,3)=I3(vein_pos(2):vein_pos(4),vein_pos(1):vein_pos(3))-0.7;
na=sum(sum(sum(isnan(I_veins))));
avg(1)=nanmean(nanmean(I_veins(:,:,1)));
avg(2)=nanmean(nanmean(I_veins(:,:,2)));
avg(3)=nanmean(nanmean(I_veins(:,:,3)));

for i=1:size(I_veins,1)
    for j=1:size(I_veins,2)
        for k=1:size(I_veins,3)
            if isnan(I_veins(i,j,k))
               I_veins(i,j,k)=avg(k); 
            end
        end
    end
end
