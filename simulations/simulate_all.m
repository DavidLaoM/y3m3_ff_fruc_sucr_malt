%% (1) Simulation of FF01

% baseline and inhibition
setup.ElevatedGLCecBaseline = 1;    % experimental GLCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedFRCecBaseline = 0;    % experimental FRCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedMaltecBaseline = 0;   % experimental Maltec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.GLTinhibFRC = 0;              % glucose transport inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRTinhibGLC = 0;              % fructose transport inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)
setup.GLKinhibFRC = 0;              % glucose phosphorylation inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRKinhibGLC = 0;              % fructose phosohorylation inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)

% Choose the experiment to simulate (set one of the 6 lines below to "1"):
setup.GPdataset.GP400WT = 1;    % FF01 ("0" = off, "1" = on)
setup.GPdataset.GP1800WT = 0;   % FF03 ("0" = off, "1" = on)
setup.GPdataset.GP400M = 0;     % FF04 ("0" = off, "1" = on)
setup.GPdataset.Fruc = 0;       % FF01Fruc ("0" = off, "1" = on)
setup.GPdataset.Sucr = 0;       % FF01Sucr ("0" = off, "1" = on)
setup.GPdataset.Malt = 0;       % FF01Malt ("0" = off, "1" = on)

% common setup
if plotflag ~= 0, disp("FF glucose simulation in progress."); end
prepare_simulations

% Simulations of FF cycles
run_simulations
selResCellFF01 = selResCell;
sim_gluc_4error.T = T_2;
sim_gluc_4error.Y = Y_2;
sim_gluc_4error.V = V_2;


%% (2) Simulation of FF01Fruc

% baseline and inhibition
setup.ElevatedGLCecBaseline = 1;    % experimental GLCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedFRCecBaseline = 1;    % experimental FRCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedMaltecBaseline = 0;   % experimental Maltec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.GLTinhibFRC = 0;              % glucose transport inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRTinhibGLC = 0;              % fructose transport inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)
setup.GLKinhibFRC = 0;              % glucose phosphorylation inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRKinhibGLC = 0;              % fructose phosohorylation inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)

% Choose the experiment to simulate (set one of the 6 lines below to "1"):
setup.GPdataset.GP400WT = 0;    % FF01 ("0" = off, "1" = on)
setup.GPdataset.GP1800WT = 0;   % FF03 ("0" = off, "1" = on)
setup.GPdataset.GP400M = 0;     % FF04 ("0" = off, "1" = on)
setup.GPdataset.Fruc = 1;       % FF01Fruc ("0" = off, "1" = on)
setup.GPdataset.Sucr = 0;       % FF01Sucr ("0" = off, "1" = on)
setup.GPdataset.Malt = 0;       % FF01Malt ("0" = off, "1" = on)

% common setup
if plotflag ~= 0, disp("FF fructose simulation in progress."); end
prepare_simulations
 
% Simulations of FF cycles
run_simulations
selResCellFF01Fruc = selResCell;
sim_fruc_4error.T = T_2;
sim_fruc_4error.Y = Y_2;
sim_fruc_4error.V = V_2;


%% (3) Simulation of FF01Sucr

% baseline and inhibition
setup.ElevatedGLCecBaseline = 1;    % experimental GLCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedFRCecBaseline = 1;    % experimental FRCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedMaltecBaseline = 0;   % experimental Maltec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.GLTinhibFRC = 1;              % glucose transport inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRTinhibGLC = 1;              % fructose transport inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)
setup.GLKinhibFRC = 1;              % glucose phosphorylation inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRKinhibGLC = 1;              % fructose phosohorylation inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)

% Choose the experiment to simulate (set one of the 6 lines below to "1"):
setup.GPdataset.GP400WT = 0;    % FF01 ("0" = off, "1" = on)
setup.GPdataset.GP1800WT = 0;   % FF03 ("0" = off, "1" = on)
setup.GPdataset.GP400M = 0;     % FF04 ("0" = off, "1" = on)
setup.GPdataset.Fruc = 0;       % FF01Fruc ("0" = off, "1" = on)
setup.GPdataset.Sucr = 1;       % FF01Sucr ("0" = off, "1" = on)
setup.GPdataset.Malt = 0;       % FF01Malt ("0" = off, "1" = on)

% common setup
if plotflag ~= 0, disp("FF sucrose simulation in progress."); end
prepare_simulations

% Simulations of FF cycles
run_simulations
selResCellFF01Sucr = selResCell;
sim_sucr_4error.T = T_2;
sim_sucr_4error.Y = Y_2;
sim_sucr_4error.V = V_2;


%% (4) Simulation of FF01Malt

% baseline and inhibition
setup.ElevatedGLCecBaseline = 1;    % experimental GLCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedFRCecBaseline = 0;    % experimental FRCec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.ElevatedMaltecBaseline = 1;   % experimental Maltec baseline > 0 ("0" = NOT taken into account, "1" = taken into account)
setup.GLTinhibFRC = 0;              % glucose transport inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRTinhibGLC = 0;              % fructose transport inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)
setup.GLKinhibFRC = 0;              % glucose phosphorylation inhibition by fructose ("0" = NOT taken into account, "1" = taken into account)
setup.FRKinhibGLC = 0;              % fructose phosohorylation inhibition by glucose ("0" = NOT taken into account, "1" = taken into account)

% Choose the experiment to simulate (set one of the 6 lines below to "1"):
setup.GPdataset.GP400WT = 0;    % FF01 ("0" = off, "1" = on)
setup.GPdataset.GP1800WT = 0;   % FF03 ("0" = off, "1" = on)
setup.GPdataset.GP400M = 0;     % FF04 ("0" = off, "1" = on)
setup.GPdataset.Fruc = 0;       % FF01Fruc ("0" = off, "1" = on)
setup.GPdataset.Sucr = 0;       % FF01Sucr ("0" = off, "1" = on)
setup.GPdataset.Malt = 1;       % FF01Malt ("0" = off, "1" = on)

% common setup
if plotflag ~= 0, disp("FF maltose simulation in progress."); end
prepare_simulations

% Simulations of FF cycles
run_simulations
selResCellFF01Malt = selResCell;
sim_malt_4error.T = T_2;
sim_malt_4error.Y = Y_2;
sim_malt_4error.V = V_2;

