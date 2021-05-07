# Colour Analysis of Coral Images

## **Image Colour Correction**
**Before quantifying intensity of red, blue, green (RGB) channels of points on coral images, the images require correcting the white balance of images with custom Pyton script. Make sure you have Python installed on your computer before running.**

**How to run script:**  
1. Download python script (*whiteCorrection.py*) to desired (empty) directory. 
2. Place images to correct into the same directory as the python script. 
3. Open terminal and move to directory containing the python script and images. 
4. Run python script with the following command: *python whiteCorrection.py*
5. Once script is finished running, 3 ouputs will be created: debug folder, out folder, and whiteCorrection.log
    * out: white-corrected images for use in colour analysis in MATLAB
    * debug: image of box used for white-correction to ensure area selected was clear (i.e., box should be white space)
    * whiteCorrection.log: log of sample processing performed
7. Review the debug images to ensure all images were corrected with a clear white box. If any sample was adjusted with non-white debug grids, rerun the analysis with new coordinates for the white box.
    * To change the corrdinates of the white box, open the python script and modify the coordiates on line 17 (*target_coords = 3750, 2900*) to move the box for the white correction.

<br/>

**Reference**  
Python script was written by [Matthew Kendall](https://github.com/matt-kendall).

---

## **Quantifying Colour Intensity**
**Colour intensity analysis requires your white-corrected images, MATLAB, and the macros included in this repository from [Winters et al 2009](https://www.tau.ac.il/lifesci/departments/zoology/members/loya/documents/206Winters.pdf).**

**How to processing images:**
1. Open MATLAB
2. Open the *AnalyzeIntensityModifications* and *CopyAndPaste_Excel_MatLab* macros in MATLAB.
3. Run *AnalyzeIntensityModifications* by clicking ‘Run’ under the green arrow. 
4. A window will pop up asking you to choose the number of pictures to analyze (default=1), the number of points per picture to analyze (default=10) and the size of the quadrats (default=25 pixels by 25 pixels).
    * We used 10 points for both *Siderastrea siderea* and *Porites astreoides* and 20 points for *Pseudodiploria strigosa* (10 points on the ridges, 10 points in the valley)
5. The coral image will appear and you will need to randomly select points over the coral fragment trying to avoid any abnormal locations (e.g., glare from light, skeleton, shaddow, etc.).
6. Update the sample name to current sample ID in the *CopyAndPaste* macro and then run.
    * This will create a csv excel file in your directory named as the sample ID with the values of each channel (red, green and blue, respectively).
    * Copy the output and paste in your master spreadsheet with the sample image ID now.
7. Repeat steps 3-6 for each white-corrected image.

<br/>

**Reference**
Winters G, Holzman R, Blekhamn A, Beer S, Loya Y. (2009). *Photographic assessment of coral chlorophyll contents: implications for ecophysiological studies and coral monitoring*. Journal of Experimental Marine Biology and Ecology 380: 25-35. *See Appendix for Macros.*
