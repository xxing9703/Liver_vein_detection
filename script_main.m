clear
close all
imax=readmatrix('liver_mouse_3.csv');% load ion intensity matrix

fn_pks='peaklist.xlsx'; %peak list
pks_=loadpks(fn_pks);
pks=pks_.sdata;
%% vein detection
markers=[1,2,3]; % indices of the markers in the peak list
sigma=1; % gaussian smooth
thred=[0.75,0.8,0.96]; % binarize thresholds for markers
TIC_norm=1;%TIC normalization? true=1 false=0
vein_size_min=3; % minimum vein size
md='md_net.mat'; % vein classifier model
confid=0.5; % vein type confidence level(0.5-1), 
% 0.5 menas probablity >50% is true, <50% is false
% 0.7 menas probablity >70% is true, <30% is false, otherwise not sure

[cv,pv,I_veins,flag_pv]=liv_vein_detection(imax,markers,thred,TIC_norm,sigma,vein_size_min,md,confid);
%% connecting CV-PV bonds
ln=[20,45]; % bond length constraint (in pixels) for CV/PV detection
bond=liv_CV_PV_bond(cv,pv,ln);

%% show vein classification
liv_show_classification(I_veins,flag_pv);

%% read signal for each bond per metabolite peak
step=50; %steps for each bond
portion=[.2,.8];% central portion for linear fitting

[bond,pks]=liv_readsig(bond,imax,step,portion,pks);

%% plot averaged signals along the CV-PV axis for each metabolites.  
pk_id=1; %starting peak ID
n=36; % number of peaks
liv_plot_cv_pv(pks,pk_id,n);

