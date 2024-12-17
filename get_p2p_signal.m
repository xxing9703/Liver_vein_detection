% specify point 1 and point 2 (p1, p2), find the signals along the line
% between these two pts in steps.  sig calculates the weithed average
% signal while sig00 finds signals at rounded coordinates. 
function [sig,sig00]=get_p2p_signal(imax,meta,step,p1,p2)

X1=p1(1); Y1=p1(2);
X2=p2(1); Y2=p2(2);

R=((X1-X2)^2+(Y1-Y2)^2)^0.5;  % distance between p1 and p2

dX=(X2-X1)/step;  %stepsize along X
dY=(Y2-Y1)/step;  %stepsize along Y

x=X1:dX:X2;
y=Y1:dY:Y2;

if dX==0
    x=ones(1,step+1)*X1;
end
if dY==0
    y=ones(1,step+1)*Y1;
end

pos0=[x',y'];
pos00=[round(x'),round(y')];

offset=[0,0;1,0;0,1;1,1]; %offset to the nearest 4 pixels

pos=[]; w=[];
for i=1:size(offset,1)
  pos{i}=[floor(x')+offset(i,1),floor(y')+offset(i,2)];
  w(:,i)=sum((pos0-pos{i}).^2, 2).^0.5;
end
weight=(1./w)./sum(1./w,2);
weight(isnan(weight))=1;

idx=[];
for i=1:length(x)
    for j=1:size(offset,1)        
        try
          idx(i,j)=find(meta(:,2)==pos{j}(i,2)&meta(:,1)==pos{j}(i,1));
        catch
          idx(i,j)=1;  % outof bound for any nearest pixel (N/A)
        end        
    end
end
sig=zeros(length(x),size(imax,2));
for i=1:size(offset,1)
 subset{i}=imax(idx(:,i),:);
 sig=sig+subset{i}.*weight(:,i);  % weighted signal
end
%-------------------------
idx00=[];
for i=1:length(x)
  try
   idx00(i)=find(meta(:,1)==pos00(i,1) & meta(:,2)==pos00(i,2));
  catch
   idx00(i)=1;  
  end
end
sig00= imax(idx00,:);   % signal rounded to integer pixels




