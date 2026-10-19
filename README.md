Code-for-HEC
This MATLAB script applies a linear Gaussian hierarchical emergent constraint (HEC) to future snow cover fraction at the grid-cell scale. It combines historical–future relationships across climate models with the historical observational mean and between-product standard deviation to calculate the posterior mean and standard deviation on a 720 × 360 grid. The number of models is determined automatically from the input arrays. Historical and future simulations must contain the same models in the same order, and all inputs must use consistent units. Run the script separately for each SSP scenario.
1. System requirements
Suggested MATLAB release: MATLAB R2023b.
Required toolbox: Deep Learning Toolbox, providing the regression function.
Hardware: a standard desktop computer with sufficient memory for the input arrays. No GPU or other non-standard hardware is required.
The MATLAB release above is a suggested environment.
2. Installation guide
Download HEC_Code.m from the repository and open it in MATLAB. Set the MATLAB Current Folder to the working directory containing the script and the required input files.
No compilation or separate installation of the script is required. MATLAB and the required toolbox must already be installed. Setup consists of downloading the script and selecting the working directory; a measured setup time has not been specified.
3. Running the code and expected output
The repository contains the MATLAB script and this README. 
The script uses input files:
ob_ave_SCE.mat	ob_ave_SCE	720 × 360
ob_un_SCE.mat	ob_un_SCE	720 × 360
Sim_SCE_his.mat	Sim_SCE_his	720 × 360 × number of models
Sim_SCE_future.mat	Sim_SCE_future	720 × 360 × number of models
ob_ave_SCE represents the historical observational mean, and ob_un_SCE represents the between-product standard deviation. The simulation arrays contain corresponding historical and future model values.
Place the required files in the working directory and run:
HEC_Code
The script saves two output files in the working directory:
Future_SCE_ave_after_HEC.mat: the posterior mean, stored as Future_SCE_ave_after_HEC.
Future_SCE_std_after_HEC.mat: the posterior standard deviation, stored as Future_SCE_std_after_HEC.
Both output arrays have dimensions of 720 × 360.
Execution time depends on the number of models, MATLAB version and hardware. 
tic
HEC_Code
toc
4. Instructions for use
Prepare the input arrays using the filenames, variable names and dimensions listed above. Ensure that all inputs use the same grid orientation and consistent units, and that historical observations and simulations represent comparable periods.
Historical and future simulations must contain the same models in the same order. The script determines the number of models from the historical simulation array.
Run the script separately for each SSP scenario. Preserve the output files before the next run, or use separate working directories, because the same output filenames are used each time.
Code availability
https://github.com/yuanfangchai/Code-for-HEC
License
No license has been specified for this repository.
