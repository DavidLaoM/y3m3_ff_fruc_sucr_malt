% % PEST1_
% simplify almost all inside the cost function. Outside just the initial
% parameter set, estimation setup and later visualization

%% Initial recall
clear; close all; clc;
set_paths;
dbstop if error

% initial setup
setup.clamp10.FBP = 0;
setup.sameKm = 1;
plotflag = 0; 

% parameter set
load('x1_initial.mat','x1BSucr','x1AFruct')
x = x1BSucr;
% reference parameter set
load('pset_pE10_xres.mat','x_pE10_end'); 
xref = zeros(1,184); xref(1:165) = x_pE10_end;

% % testSimulation
% plotflag = 11; 
% simulate_all
% plotflag = 0;

% % test cost function
% plotflag = 11; % 11 = simulations per dataset, 12 = cost function visual 
% lambda = 0; 
% w = zeros(499,1);
% selPars = 100;
% x_temp = x(100);
% [error] = costfun_FF01_all(x_temp,setup,x,plotflag,selPars,lambda,w);
% plotflag = 0;

%% Parameter estimation setup

% 1 control case (some with ALD)
% 2 ref + ALD. fructose-specific
% 2 ref + ALD. sucrose-specific
% 2 ref + ALD. maltose-specific
% 3 only ALD. fructose-specific

% 3 only ALD. sucrose-specific
% 3 only ALD. maltsoe-specific
% 4 ref + GAPDH fit all
% 4 ref + GAPDH fit all + gap + dhap
% 4 ref + GAPDH fit all + gap + dhap. fructose-specific

% 4 ref + GAPDH fit all + gap + dhap. sucrose-specific
% 4 ref + GAPDH fit all + gap + dhap. maltose-specific
% 5 only GAPDH fit all + gap + dhap. fructose-specific
% 5 only GAPDH fit all + gap + dhap. sucrose-specific
% 5 only GAPDH fit all + gap + dhap. maltose-specific

% 6 ref + ALD + TRE. fructose-specific
% 6 ref + ALD + TRE. sucrose-specific
% 6 ref + ALD + TRE. maltose-specific
% 7 ref + GAPDH + TRE. fructose-specific
% 7 ref + GAPDH + TRE. sucrose-specific

% 7 ref + GAPDH + TRE. maltose-specific


% optimOptions
options = optimoptions('lsqnonlin','Display','iter',...
    'FunctionTolerance', 1e-4, 'OptimalityTolerance', 1e-4,...
    'DiffMinChange',0.1);

% % 
nS1 = 21;
% saveNames
saveNames = cell(nS1,1);
% saveNames{9} = 'pE7_c1_ug.mat';
saveNames{1} = 'pE7_c1_ug.mat';
saveNames{2} = 'pE7_c5_gapdh.mat';
saveNames{3} = 'pE7_c2_pgk.mat';
saveNames{4} = 'pE7_c3_pgm.mat';
saveNames{5} = 'pE7_c4_eno.mat';
saveNames{6} = 'pE7_c5_pyk.mat';

% parCombs
parINV = [177 178];
    parHXT_glc = [36 38 166];
    parHXT_fruc = [167 169 170];
    parHXT_malt = [179 180 181 182];
parHXT = [parHXT_glc, parHXT_fruc, parHXT_malt]; 
parMALX = [183 184];
    parHXK_glc = [28 29 30 31 32 33 34 171];
    parHXK_fruc = [172 173 174 175 176];
parHXK = [parHXK_glc, parHXK_fruc]; 
    parPGM1 = 83:86;
    parTPS1 = 124:128;
parGAPDH = 21:27;
%     parTPS2 = 119:121;
%     parNTH1 = 122:123;
%     parUGP = 144:148;
%     parATH = 149:150;
%     parAGT1 = [151:154,158];
%     parvacT = 155:157;
parTRE = [parPGM1, parTPS1];
parPGI = [57:60];
parPFK = [43:56,87];
parALD = [11:15];
parTPI = [79:82];
parUG = [parPGI,parPFK,parALD,parTPI];
% 
par_ref = [parHXT, parHXK, parINV, parMALX]; 
% 
parSet1 = [par_ref, parALD]; 
parSet2 = [par_ref, parALD]; 
parSet3 = parALD; 
parSet4 = [par_ref, parGAPDH]; 
parSet5 = parGAPDH;
parSet6 = [par_ref, parALD, parTRE]; 
parSet7 = [par_ref, parGAPDH, parTRE]; 
%
parPGK = 61:66;
parPGM = 67:70;
parENO = 16:19;
parPYK = 71:77;
% 
parCombs = cell(nS1,1);
parCombs{1} = [par_ref, parGAPDH, parPGK, parPGM, parENO, parPYK];
parCombs{2} = [par_ref, parGAPDH]; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
parCombs{3} = [par_ref, parPGK];
parCombs{4} = [par_ref, parPGM];
parCombs{5} = [par_ref, parENO];
parCombs{6} = [par_ref, parPYK];

% warray
wsugars = [101 201 301 302 401];
wfbp = [109 206 307 406];
wsugars_fbp = [wsugars, wfbp];
wlg = [112 209 310 409];
wsugars_fbp_lg = [wsugars_fbp, wlg];
wtre = [104 203 304 403];
wsugars_fbp_tre = [wsugars_fbp, wtre];
wrates = [120 220 320 420];
% wsugars_fbp_rates = [wsugars_fbp, wrates];
wall = [wsugars, wfbp, wlg, wtre, wrates];
wgap = [111 208 309 408];
wdhap = [110 207 308 407];
% 
wbaseline = zeros(499,1);
warray = cell(nS1,1);
for i = 1:length(warray)
    warray{i} = wbaseline;
end
% case 1. control % [wsugars wfbp wlg wtre wrates]
warray{1}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{2}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{3}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{4}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{5}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{6}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';


% % % % %% parameter estimation
% % % % id_runs = 1:21;
% % % % x1 = x;
% % % % % % % % cluster = parcluster('local');
% % % % % pool = parpool(cluster,4);
% % % % % % % % pool = parpool(cluster,16);
% % % % % 
% % % % % % % % parfor i = id_runs
% % % % for i = 1
% % % %     % preparation
% % % %     saveName = saveNames{i};
% % % %     selPars = parCombs{i};% selPars
% % % %     w = warray{i}; % w
% % % %     lambda = 0; % lambda
% % % %     x_temp = x1(selPars);
% % % %     plength = length(selPars);
% % % %     setup.x_reg = xref(selPars);% parameters
% % % % %     if((i==5)||(i==6)||(i==7)||(i==13)||(i==14)||(i==15))
% % % % %         lb = -3*ones(1,plength); 
% % % % %         ub = 3*ones(1,plength); 
% % % % %     else
% % % %         lb = -3*ones(1,plength); lb([1 2 6 7 8 9 10 11 12 13 23 24 25 26]) = -4 * ones; lb(27) = -6;
% % % %         ub = 3*ones(1,plength); ub([1 2 6 7 8 9 10 11 12 13 23 24 25 26]) = 4 * ones; ub(27) = 6;
% % % % %     end
% % % %     % estimate
% % % %     sprintf('run num.%d tested',i)
% % % %     [xres,resnorm,residual,exitflag] = lsqnonlin(@costfun_FF01_all,x_temp,lb,ub,options,setup,x1,plotflag,selPars,lambda,w);
% % % %     disp(xres)
% % % %     % simulate
% % % %     x = x1BSucr; x(selPars) = xres;
% % % %     simulate_all
% % % %     % errorcalc
% % % %     lambda = 0;
% % % % %     selPars = parCombs{i};
% % % % %     xref = x1BSucr;
% % % %     [error,error_gluc,error_fruc,error_sucr,error_malt] = costfun_FF01_all_recall_error(xres,setup,x1,plotflag,selPars,lambda,w);
% % % %     % recall
% % % %     error_cell = error;
% % % %     error_gluc_cell = error_gluc;
% % % %     error_fruc_cell = error_fruc;
% % % %     error_sucr_cell = error_sucr;
% % % %     error_malt_cell = error_malt;
% % % %     % save
% % % %     parSave_sugars_cluster_withError(saveName,...
% % % %         xres, resnorm, residual, exitflag, w, selPars, lambda,...
% % % %         selResCellFF01,selResCellFF01Fruc,selResCellFF01Sucr,selResCellFF01Malt,...
% % % %         error_cell,error_gluc_cell,error_fruc_cell,error_sucr_cell,error_malt_cell)
% % % % end
% % % % delete(pool)
% % % % quit


%% simulate reference
x = x1BSucr;
simulate_all
sim_ref_gluc = selResCellFF01;
sim_ref_fruc = selResCellFF01Fruc;
sim_ref_sucr = selResCellFF01Sucr;
sim_ref_malt = selResCellFF01Malt;


%% visualization
% recall info
xAll = []; 
namesHits = {}; 
residual_array = {};
% 
sims_gluc = {};
sims_fruc = {};
sims_sucr = {};
sims_malt = {};
% 
% % error = {};
error_gluc = {};
error_fruc = {};
error_sucr = {};
error_malt = {};
% 
nS = 6;
for i = 1:nS
    loadName = saveNames{i};
    if exist(loadName,'file') == 2
        load(loadName);
        % parameters
        selPars = parCombs{i};
        x2 = x;
        x2(selPars) = xres;
        xAll = [xAll; x2];
        namesHits = [namesHits; loadName];
        % error (residual)
        residual_array = [residual_array; residual'];
        % simulations
        sims_gluc = [sims_gluc; selResCellFF01];
        sims_fruc = [sims_fruc; selResCellFF01Fruc];
        sims_sucr = [sims_sucr; selResCellFF01Sucr];
        sims_malt = [sims_malt; selResCellFF01Malt];
        % error
% %         error = [error; error_cell];
        error_gluc = [error_gluc; error_gluc_cell];
        error_fruc = [error_fruc; error_fruc_cell];
        error_sucr = [error_sucr; error_sucr_cell];
        error_malt = [error_malt; error_malt_cell];
    end    
end
% simulations change name
sims_gluc_7 = sims_gluc; 
sims_fruc_7 = sims_fruc; 
sims_sucr_7 = sims_sucr; 
sims_malt_7 = sims_malt; 
% error change name
% % error_cell_7 = [error_cell; error];
error_gluc_cell_7 = error_gluc;
error_fruc_cell_7 = error_fruc;
error_sucr_cell_7 = error_sucr;
error_malt_cell_7 = error_malt;

%%
% save('pE7_sims_safecopy.mat',...
%     "sims_gluc_7","sims_fruc_7","sims_sucr_7","sims_malt_7",...
%     "error_gluc_cell_7","error_fruc_cell_7","error_sucr_cell_7","error_malt_cell_7")
%     "error_cell_7","error_gluc_cell_7","error_fruc_cell_7","error_sucr_cell_7","error_malt_cell_7")


%%
load('pE7_sims_safecopy.mat',...
    "sims_gluc_7","sims_fruc_7","sims_sucr_7","sims_malt_7",...
    "error_gluc_cell_7","error_fruc_cell_7","error_sucr_cell_7","error_malt_cell_7")


%%
% saveNames{1} = 'pE7_c1_ug.mat';
% saveNames{2} = 'pE7_c5_gapdh.mat';
% saveNames{3} = 'pE7_c2_pgk.mat';
% saveNames{4} = 'pE7_c3_pgm.mat';
% saveNames{5} = 'pE7_c4_eno.mat';
% saveNames{6} = 'pE7_c5_pyk.mat';
close all
nref = 7;
% selSims = [1:6,7]; % all
% selSims = [1,7]; % ug
selSims = [2,7]; % gapdh
% selSims = [3,7]; % pgk
% selSims = [4,7]; % pgm
% selSims = [5,7]; % eno
% selSims = [6,7]; % pyk
% selSims = [3:6,7]; % pyk
plot_all_loop
% plot_all
