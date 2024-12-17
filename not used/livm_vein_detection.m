metadata=imax(:,1:2);
TIC=imax(:,3);
I0=idata2imgdata(imax(:,0+3),metadata)/mean(TIC); %get TIC
I1=idata2imgdata(imax(:,id1+3),metadata); % get marker images
I2=idata2imgdata(imax(:,id2+3),metadata);
I3=idata2imgdata(imax(:,id3+3),metadata);
if TIC_norm==1
    I1=I1./I0;  % TIC normalization
    I2=I2./I0;
    I3=I3./I0;
end
%---------------------------------
I1 = imgaussfilt(I1,sigma);
I2 = imgaussfilt(I2,sigma);
I3 = imgaussfilt(I3,sigma);

I1=log10(I1+eps);
I1=I1/max(max(I1));
I1=I1-nanmean(nanmean(I1))+0.67; %recenter
I1(I1<0)=0;
%I1=I1/prctile(I1(:),99);

I2=log10(I2+eps);
I2=I2/max(max(I2));
I2=I2-nanmean(nanmean(I2))+0.65; %recenter
I2(I2<0)=0;
%I2=I2/prctile(I2(:),99);

I3=log10(I3+eps);
I3=I3/max(max(I3));
I3=I3-nanmean(nanmean(I3))+0.93; %recenter
I3(I3<0)=0;
%I3=I3/prctile(I3(:),99);

% marker 1, green 2, red
BW1 = imbinarize(I1,t1);
BW2 = imbinarize(I2+I1*c1,t2);
BW3 = imbinarize(I3,t3);

%%


veins_xy=[];flag_pv=[];
veins_img=zeros(size(BW1));
%find all vein centers
s2 = regionprops(BW2,I2,'all');
s2=s2([s2.Area]>=vein_size_min);
load(md)
for i=1:length(s2)
    veins_xy(i,:)=s2(i).Centroid;
    pixels=s2(i).PixelList;
    bd=s2(i).BoundingBox;
    [I_veins{i},na]=get_I_veins(veins_xy(i,:),11,I1,I2,I3); 
   
%--------------------------trained classifier for CV & PV
  [flag,scores]=classify(md_net,im2uint8(I_veins{i}));
  %scores=minibatchpredict(md_net,im2uint8(I_veins{i}));
  %flag=scores2label(scores,classNames);
  if flag=='PV' && scores(2)>confid
     flag_pv(i)=1; %PV
  elseif flag=='CV' && scores(1)>confid 
     flag_pv(i)=0; %CV
  else
     flag_pv(i)=0.5;  %not sure 
  end
%----------------------------
    for j=1:size(pixels,1)
        veins_img(pixels(j,2),pixels(j,1))=flag_pv(i)*2-1;
    end
end
veins_idata=[];
for i=1:size(imax,1)
    veins_idata(i,1)=veins_img(metadata(i,2),metadata(i,1));
end

I4=idata2imgdata(veins_idata,metadata);


cv=veins_xy(flag_pv==0,:); cvid=find(flag_pv==0);
pv=veins_xy(flag_pv==1,:); pvid=find(flag_pv==1);

imgC=[];
imgC(:,:,1)=floor(I2*256);
imgC(:,:,2)=floor(I1*256);
imgC(:,:,3)=floor(I3*256);
imgC(:,:,1)=I2-0.5;
imgC(:,:,2)=I1-0.5;
imgC(:,:,3)=I3-0.85;

% plotting

figure,imshow(BW2)  % plot binarized image
figure,imshow((I4+1)/2,'colormap',jet) % show classified vein locations
figure,imshow(imgC*2) % MALDI for 3 markers 

viscircles(cv, 1,'Color','r'); %highlight veins
viscircles(pv, 1,'Color','g');




%writematrix(veins_idata, fname_out_vein); % export to collaborator.