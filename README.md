# Liver_vein_detection

MALDI imaging analysis.  Detects the repeating units of central & portal veins (CV & PV) in liver.  Construct 1D PV-CV coordinates. Extract signal changes along the axis for each metabolite, averaged over many (>100) selected PV-CV bonds of good quality. 

## Description

-- **script_main.m**

This is the main code that starts with the pre-generated ion intensity matrix, detects and classifies portal & central veins in MALDI imaging data of mouse liver using 3 markers (the first 3 peaks in "peaklist.csv"), records the centroid vein coordinates, constructs PV-CV axis that satisfies the bond length constraint, and integrates ion signals along the PV-CV axis for each metabolite.  The binary image of veins, the image of the markers with the detected veins and CV-PV bonds on top of it are plotted. The averaged ion signal changes along the axis for each metabolite can be plotted. 


-- **script_get_imax.m**

This code starts from the raw imzML/ibd file, parses the data, and generates the ion intenisty matrix based on the given peak list (peaklist.csv). The matrix consists of the metadata (X and Y coordinates in col 1 & 2), TIC (col 3) and ion intensities (col 4 to end). Some core functions from the software of IsoScope (https://github.com/xxing9703/Isoscope) are used and copied here in the isoscope_fn folder. An example raw data can be downloaded here: XXX

-- **classify\Script_CVPV_classify_model.m**

This code uses the training data set (manually cropped and labeled 12 X 12 X 3 images of veins) stored in CV and PV folders to generate a CNN model: md_net, which is used in script_main for vein classification. get_I_veins.m is used to extract the cropped vein image in  testing data.



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
