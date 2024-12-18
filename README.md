# Liver_vein_detection

MALDI imaging analysis.  Detects central & portal veins in liver.  Construct 1D PV-CV coordinates. Extract metabolite signal changes along the axis with >100 high quality PV-CV bond averages. 

## Description

-- script_main.m

This is the main code that starts with the pre-generated ion intensity matrix, detects and classifies portal & central veins (PV & CV) in MALDI imaging data of mouse liver using 3 markers (the first 3 peaks in "peaklist.csv"), records the vein coordinates, constructs multiple PV-CV axes, and integrates ion signals along the PV-CV axis for each metabolite.  The images of the markers along with the detected veins and CV-PV bonds are plotted.  


-- script_get_imax.m

This code starts from the raw imzML file, parses the data and generates the ion intenisty matrix based on the given peak list (peaklist.csv).  Some core functions from the software of IsoScope (https://github.com/xxing9703/Isoscope) are used and put in the isoscope_fn folder. An example raw data can be downloaded here: 

-- classify\Script_CVPV_classify_model.m

This code uses the training data stored in CV and PV folders to generate a CNN model: md_net, which is used in script_main for vein classification.



## Getting Started
1. Download this repo.

2. Download the ion intensity matrix data from the link below, put them in the same folder
https://figshare.com/s/9422d969f5724036b54a

3. Run script_main.m in matlab. ("liver_mouse_3.csv" is used in this demo -- line 3, and can be replaced by any other data)
   
4. All results are saved in the variables "bonds" and "pks"
   
## Installing

Install matlab of the latest version. The following toolboxes are needed.

*image processing

*neural_network

*statistics and machine learning 


Try to increase the Java heap memory if you encountered memory overflow error when parsing the raw data using script_get_imax.m.
https://www.mathworks.com/help/matlab/matlab_external/java-heap-memory-preferences.html
