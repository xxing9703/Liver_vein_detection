# Liver_vein_detection

Liver's structure contains many repeating units of lobules in hexagonal shape, consisting of central & portal veins (CV & PV), which are highlighted by markers in MALDI.  While CV-PV axis represents the simplest repeating unit and the primary spatial feature in liver, metabolomic gradient changes along the CV-PV axis could be reliably extracted computationally, taking advantage of the large mount of signal averaging.

This standalone app (main_liver_CVPV.mlapp) is fully automated and generalized to process the liver MALDI images for this purpose, with a user-friendly interface for testing different parameter settings and visualizing the results.  It takes the extracted MALDI ion intensitiy matrix as the input (spatial coordinates & ion signals for each metabolite from a pre-defined peak list), runs through a computational pipeline including: 1) vein identification 2) vein classification  3) construction & selection of CV-PV coordinates. 4) signal extraction and averaging,  and export the metabolomic signal changes along the 1-D coordiante.

An old script version can be found in the branch "script-version".


## Getting Started (for visualization only)

1. Download or make a clone of this repo. Matlab needs to be installed (see Installation)

2. Run "main_liver_CVPV.mlapp"
   
3. Use the 7 speedbottons to load and visualize the pre-calculated results (.mat) for each sample tissue. (it will take ~1/2 mins to fully load)

4. There are four tabs,
   1) MALDI browser:  display individual ion images.  colormap and scales can be changed. 
   2) CV-PV identification: detect veins & select bonds, subject to parameter settting.(see detailed usage) 
   3) Vein classification: display vein classification results.
   4) 1-D signal display:  show averaged metabolite signal changes along CV-PV axis.  Mouse click indivual bond on the image to display the signal from a single selected bond.
 
##  Detailed usage of the app (Running)

1. "peaklist.xlsx" defines both the markers and metabolite list to be extracted. The first three rows of metabolites are the 3 markers used for vein detection & classification. DO NOT change them or their orderings. User can change the remaining portion of the metabolite list of their interest.   

2. Use the "Load" button to load an ion intensity matrixes.  Only one example "liver_mouse_1.xlsx" is included in this repo.  For testing all 7 examples, download from https://figshare.com/s/9422d969f5724036b54a and put them in the same folder.

3. After successful loading, the first three tabs will show results of ion images, vein & bonds detection using the default settings.
   1) in the second tab,  bond length (min & max) defines the ranges of bond length (in pixels) to be selected as good CV-PV bonds. The wider the range, the more bonds will be selected.
   2) gaussion sigma is the smoothing filer parameter for vein detection using HEME signal.
   3) min vein size is the minimum number of pixels of an isolated region that can be considered as a vein.
   4) The signal distribution of each of the three markers are displayed, green and dotted lines defines the color thresholding for signal normalization, such that it can be generalized from data to data.  DO NOT change the marker threshold unless data from a very different dataset is loaded.
   5) Click the update button after any change of parameters  

4. After the veins & bonds are defined, click the Run button to compute bond singals along each CV-PV axis for each metabolites. It will normally take a coupon of minutes, and the animation of the bond calculation will show on the image.
5. After the Run is completed, go to the last tab to visualize averaged and individual metabolomic signals along the CV-PV axis.

 
## Installation

Install matlab (the latest version is preferred). The following toolboxes are needed.

  --image processing toolbox

  --Deep learning toolbox

  --statistics and machine learning toobox
  
  --App installation file: liver_CVPV.mlappinstall

Try to increase the Java heap memory if you encountered memory overflow error when parsing the raw data using script_get_imax.m.
https://www.mathworks.com/help/matlab/matlab_external/java-heap-memory-preferences.html
