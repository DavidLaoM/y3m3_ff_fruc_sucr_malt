% % PREPARE_SIMULATIONS.M

% assays to run
setup.runSScanelas = 0;
setup.runGSvanHeerden = 0;
setup.plotResultsMode = 0; %30; %20; %10;
setup.conditionsSS = 0;
setup.conditionsGP = 0;

% model structure used
setup.biomass = 0; % biomass
setup.clamp10.Pi = 0;%1; 
setup.clamp10.TRE = 0;%1; 
setup.clamp10.NADX = 0;%1; 
setup.clamp10.AXP = 0;%1; 
setup.clamp10.IXP = 1; 
setup.clamp10.UDP_GLC = 1; % UDP_GLC_exp in AGT1 rate equation
setup.clamp = setup.clamp10;

% get datasets (others needed)
[legenda] = legendaFull;
loadData_Y3M1;
% get GPFF datasets 
load('TUDdata.mat'); % loads the datasets
    dataset.FF01.time_mets = [0;5;10;15;20;25;30;60;90;120;150;180;220;250;300;350;400];
    dataset.FF01.timeECgluc= [0;5;11;15;20;   30;60;90;    150;180;220;250;300;350;400];
    dataset.FF03.time_mets = [0;5;10;20;30;40;60;90;120;150;200;250;300;400;550;700;800;900;1000;1200;1400;1600;1700;1803];
    dataset.FF04.time_mets = [0;5;10;15;20;30;60;90;120;150;180;220;250;300;350;398];
reorganiseTUDdata; % puts it in order for easily coding in the next section

% Code that checks if not more than one experiment is selected above, and that reports it if this is the case:
su = 0;
fn = fieldnames(setup.GPdataset);
for i = 1:numel(fn)
    su = su+ setup.GPdataset.(fn{i});
end
if su > 1
    disp('too many datasets used')
end

% Code to set the initial conditions to be used for the simulation:
z = 2; % mL intracellular volume/gram cell dry weight
if setup.GPdataset.GP400WT == 1
    [ssdataFF01] = read_ssdataFF01(z);
    InitCond_GP_TUD;
    [dataFF01] = redefine_dataFF01(dataFF01,ssdataFF01); % redefine and merge "dataFF01" and "ssdataFF01" for plotting with "plotMode" set at "2_HugoCloudt"
elseif setup.GPdataset.GP1800WT == 1
    InitCond_GP_TUD_1800;
elseif setup.GPdataset.GP400M == 1
    InitCond_GP_TUD_mutant;
elseif setup.GPdataset.Fruc == 1
    Vbroth = 4; % broth volume (L)
    [dataFF01Fruc] = readFF01Fruc(z);
    dataset.FF01Fruc = dataFF01Fruc;
    save_dataFruc = dataFF01Fruc;
    [IC] = InitCond_FF01Fruc(Vbroth,dataFF01Fruc);
    [dataFF01Fruc] = redefine_dataFF01Fruc(dataFF01Fruc);
elseif setup.GPdataset.Sucr == 1
    Vbroth = 4; % broth volume (L)
    [dataFF01Sucr] = readFF01Sucr(z);
    dataset.FF01Sucr = dataFF01Sucr;
    save_dataSucr = dataFF01Sucr;
    [IC] = InitCond_FF01Sucr(Vbroth,dataFF01Sucr);
    [dataFF01Sucr] = redefine_dataFF01Sucr(dataFF01Sucr);
elseif setup.GPdataset.Malt == 1
    Vbroth = 4; % broth volume (L)
    [dataFF01Malt] = readFF01Malt(z);
    dataset.FF01Malt = dataFF01Malt;
    save_dataMalt = dataFF01Malt;
    [IC] = InitCond_FF01Malt(Vbroth,dataFF01Malt);
    [dataFF01Malt] = redefine_dataFF01Malt(dataFF01Malt);
end

% Code to set the Csmin value to be used for the simulation
if setup.GPdataset.GP400WT == 1
    setup.GLCecmin = 0.0944;    % value of the experimental GLCec baseline [mM]
    setup.FRCecmin = 0;         % value of the experimental FRCec baseline [mM]
    setup.Maltecmin = 0;        % value of the experimental Maltec baseline [mM]
elseif setup.GPdataset.GP1800WT == 1
    setup.GLCecmin = 0.0504;    % value of the experimental GLCec baseline [mM]
    setup.FRCecmin = 0;         % value of the experimental FRCec baseline [mM]
    setup.Maltecmin = 0;        % value of the experimental Maltec baseline [mM]
elseif setup.GPdataset.GP400M == 1
    setup.GLCecmin = 0.0369;    % value of the experimental GLCec baseline [mM]
    setup.FRCecmin = 0;         % value of the experimental FRCec baseline [mM]
    setup.Maltecmin = 0;        % value of the experimental Maltec baseline [mM]
elseif setup.GPdataset.Fruc == 1
    setup.GLCecmin = 0;         % value of the experimental GLCec baseline [mM]
    setup.FRCecmin = 0.544-0.1822;%0.544;     % value of the experimental FRCec baseline [mM]
    setup.Maltecmin = 0;        % value of the experimental Maltec baseline [mM]
elseif setup.GPdataset.Sucr == 1
    setup.GLCecmin = 0.0998;    % value of the experimental GLCec baseline [mM]
    setup.FRCecmin = 0.1915 - 0.0998;%0.192;     % value of the experimental FRCec baseline [mM]
    setup.Maltecmin = 0;        % value of the experimental Maltec baseline [mM]
elseif setup.GPdataset.Malt == 1
    setup.GLCecmin = 0;         % value of the experimental GLCec baseline [mM]
    setup.FRCecmin = 0;         % value of the experimental FRCec baseline [mM]
    setup.Maltecmin = 0.0386 - 0.0237; %0.0386;   % value of the experimental Maltec baseline [mM]
end

% Number of FF cycles to simulate:
NumberCycles = 5;

% latest model changes (as of 2021-07-29)
setup.glycSynthDeg = 1; % this adds a reaction to the mass balance (ODEs), reaction calculation in rate equations and the starting parameter value
setup.glycSynthDeg_separate = 1;
setup.ATHinhibitionT6P = 1;
setup.ATH_separate_EC_VAC = 1;
setup.glycogenReactionsSink = 1;
setup.dataset = dataset;

% choose dataset
plotMode = "2_HugoCloudt"; % (set "plotMode = 2;" to get the plots of the original code, set "plotMode = "2_HugoCloudt";" for Hugo's plots)
choosedataset;

% Number of simulations to perform
nSims = 1;

