function [imgdata,alphadata]=idata2imgdata(idata,metadata)
xmax=max(metadata(:,1)+10);
ymax=max(metadata(:,2)+10);

imgdata=nan(ymax,xmax); % rows->y, columns->x
alphadata=zeros(ymax,xmax);
   for i=1:size(metadata,1)                
        imgdata(metadata(i,2),metadata(i,1)) = idata(i);  %1d ->2d
        alphadata(metadata(i,2),metadata(i,1)) = 1;
   end 