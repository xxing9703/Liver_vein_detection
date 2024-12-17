% batch process to convert imZML to mat format.
% create a csv file following the format of template first and use this
% function to process
function batch_convert(template)
if nargin<1
   [f,p]=uigetfile({'*.xlsx';'*.csv'},'load batch file');
   template=fullfile(p,f);
end
T=table2struct(readtable(template));
for i=1:length(T)
 fname=fullfile(T(i).path,T(i).filename);  
 option.threshold=T(i).threshold;
 option.profile=T(i).isProfile;
 msi=msi_process(fname,option,T(i).norm);

 [filepath,name,~] = fileparts(fname);
 fmsi=fullfile(filepath,[name,'.mat']);
 save(fmsi,'msi','-v7.3');
end
