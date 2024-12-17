function [imax,msi]=liv_get_imax(fn_pks,fn_imzML,option)
padding=[10,10,10,10]; % add paddings around the cropped image.
msi=msi_process(fn_imzML,option,1);
msi=msi_get_metadata(msi,padding); 
pks=loadpks(fn_pks);
pk.ppm=15;
pk.z=-1;
pk.offset=0;
pk.isoType=1;
msi.pk=pk;
msi=msi_get_imax(msi,pks.sdata);
dt=msi.data;
    for i=1:length(dt)
        TIC(i)= double(sum(dt(i).peak_sig));
    end
    msi.TIC=TIC';
imax=[msi.metadata,msi.TIC(:),msi.imax]; %data matrix to work with