% this script is to generate ion intensity matrix from raw imzML/ibd files
% Some function from isoScope is used 

clear
close all
addpath('isoscope_fn');

% specify .imzML file. ibd file should be within the same folder.
fn_imzML='Y:\qehf\MALDI-TIMS-TOF\Laith\230809_livM76-79_NEDC_15um\230809_livM79_NEDC_15um\230809_livm79_nedc_15um.imzML';

option.threshold=0; % no intensity threshold 
option.profile=0; % data is already centroid

fn_pks='peaklist.xlsx'; %peak list

[imax, msi]=liv_get_imax(fn_pks,fn_imzML,option); % get imax
writematrix(imax,'livm79.csv'); % save imax as csv file
