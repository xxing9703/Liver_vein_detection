function [slops,top]=linearfit(sig,portion,cap)
slops=[];
x=floor(size(sig,1)*portion(1)):floor(size(sig,1)*portion(2)); 
y=sig(x,:);
for i=1:size(y,2)
  p = polyfit(x,y(:,i),1);
  yfit=x*p(1)+p(2);
  %slops(i)=log10(abs((yfit(end)/yfit(1)))); %log of fold change
  aa=yfit(end)-yfit(1); aa=max(aa,-500); aa=min(aa,500); 
  slops(i)=log10(abs((yfit(end)/yfit(1)))); %+  0.1*log10(abs(aa))*sign(aa);
end
slops(slops>cap)=cap;
slops(slops<-cap)=-cap;
[~,idx]=max(y);
top=idx+x(1);  % index of the maximum value of the curve.

