% % PEST5_
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
nS1 = 20;
% saveNames
saveNames = cell(nS1,1);
% case 1. ref + gapdh
saveNames{1} = 'pE5_ref_gapdh_lam1.mat';
saveNames{2} = 'pE5_ref_gapdh_lam2.mat';
saveNames{3} = 'pE5_ref_gapdh_lam3.mat';
saveNames{4} = 'pE5_ref_gapdh_lam4.mat';
saveNames{5} = 'pE5_ref_gapdh_lam5.mat';
saveNames{6} = 'pE5_ref_gapdh_lam6.mat';
saveNames{7} = 'pE5_ref_gapdh_lam7.mat';
saveNames{8} = 'pE5_ref_gapdh_lam8.mat';
saveNames{9} = 'pE5_ref_gapdh_lam9.mat';
saveNames{10} = 'pE5_ref_gapdh_lam10.mat';
% case 2. gapdh
saveNames{11} = 'pE5_gapdh_lam1.mat';
saveNames{12} = 'pE5_gapdh_lam2.mat';
saveNames{13} = 'pE5_gapdh_lam3.mat';
saveNames{14} = 'pE5_gapdh_lam4.mat';
saveNames{15} = 'pE5_gapdh_lam5.mat';
saveNames{16} = 'pE5_gapdh_lam6.mat';
saveNames{17} = 'pE5_gapdh_lam7.mat';
saveNames{18} = 'pE5_gapdh_lam8.mat';
saveNames{19} = 'pE5_gapdh_lam9.mat';
saveNames{20} = 'pE5_gapdh_lam10.mat';

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

% % 
parCombs = cell(nS1,1);
% case 1. ref + gapdh
parCombs{1} = parSet4;
parCombs{2} = parSet4;
parCombs{3} = parSet4;
parCombs{4} = parSet4;
parCombs{5} = parSet4;
parCombs{6} = parSet4;
parCombs{7} = parSet4;
parCombs{8} = parSet4;
parCombs{9} = parSet4;
parCombs{10} = parSet4;
% case 2. gapdh
parCombs{11} = parSet5;
parCombs{12} = parSet5;
parCombs{13} = parSet5;
parCombs{14} = parSet5;
parCombs{15} = parSet5;
parCombs{16} = parSet5;
parCombs{17} = parSet5;
parCombs{18} = parSet5;
parCombs{19} = parSet5;
parCombs{20} = parSet5;

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
% case 1. ref + gapdh
warray{1}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{2}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{3}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{4}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{5}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{6}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{7}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{8}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{9}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{10}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
% case 2. gapdh
warray{11}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{12}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{13}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{14}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{15}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{16}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{17}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{18}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{19}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{20}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';

% lambdalist
lambdalist = [1E-3 1E-2 1E-1 3E-1 1E0 3E0 1E1 3E1 1E2 1E3,...
              1E-3 1E-2 1E-1 3E-1 1E0 3E0 1E1 3E1 1E2 1E3];


% %% parameter estimation
% id_runs = 1:20;
% x1 = x;
% % cluster = parcluster('local');
% % pool = parpool(cluster,4);
% % % pool = parpool(cluster,16);
% % parfor i = id_runs
% for o = 1
%     i = o;
%     % preparation
%     saveName = saveNames{i};
%     selPars = parCombs{i};% selPars
%     w = warray{i}; % w
%     lambda = lambdalist(i); % lambda
%     setup.x_reg = xref(selPars);% parameters
%     x_temp = x1(selPars);
%     plength = length(selPars);
%     if(i>=11)
%         lb = -3*ones(1,plength); 
%         ub = 3*ones(1,plength); 
%     else
%         lb = -3*ones(1,plength); lb([1 2 6 7 8 9 10 11 12 13 23 24 25 26]) = -4 * ones; lb(27) = -6;
%         ub = 3*ones(1,plength); ub([1 2 6 7 8 9 10 11 12 13 23 24 25 26]) = 4 * ones; ub(27) = 6;
%     end
%     % estimate
%     sprintf('run num.%d tested',i)
%     [xres,resnorm,residual,exitflag] = lsqnonlin(@costfun_FF01_all,x_temp,lb,ub,options,setup,x1,plotflag,selPars,lambda,w);
%     disp(xres)
%     % simulate
%     x = x1BSucr; x(selPars) = xres;
%     simulate_all
%     % save
%     parSave_sugars_cluster(saveName,...
%         xres, resnorm, residual, exitflag, w, selPars, lambda,...
%         selResCellFF01,selResCellFF01Fruc,selResCellFF01Sucr,selResCellFF01Malt)
% end
% % delete(pool)
% % quit

%% visualization
% recall info
xAll = []; 
namesHits = {}; 
% % residual_array = [];
sims_gluc = {};
sims_fruc = {};
sims_sucr = {};
sims_malt = {};
nS = 20;
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
        % error
% %         residual_array = [residual_array; residual'];
        % simulations
        sims_gluc = [sims_gluc; selResCellFF01];
        sims_fruc = [sims_fruc; selResCellFF01Fruc];
        sims_sucr = [sims_sucr; selResCellFF01Sucr];
        sims_malt = [sims_malt; selResCellFF01Malt];
    end    
end


% % % % %% visualize changes in error residuals (like inside the cost fuction)
% % % %     % here we will have to simulate first
% % % %     error_cell = {};
% % % %     error_gluc_cell = {};
% % % %     error_fruc_cell = {};
% % % %     error_sucr_cell = {};
% % % %     error_malt_cell = {};
% % % %     for i = 1:nS
% % % %         disp(i)
% % % %         % simulate
% % % %         w = warray{i};
% % % %         lambda = 0;
% % % %         selPars = parCombs{i};
% % % %         x_temp = xAll(i,selPars);
% % % %         [error,error_gluc,error_fruc,error_sucr,error_malt] = costfun_FF01_all_recall_error(x_temp,setup,x,plotflag,selPars,lambda,w);
% % % %         % recall
% % % %         error_cell = [error_cell; error];
% % % %         error_gluc_cell = [error_gluc_cell; error_gluc];
% % % %         error_fruc_cell = [error_fruc_cell; error_fruc];
% % % %         error_sucr_cell = [error_sucr_cell; error_sucr];
% % % %         error_malt_cell = [error_malt_cell; error_malt];
% % % %     end
% % % %     % simulate the reference case
% % % %     selPars = 1;
% % % %     x_temp = x(selPars);
% % % %     [error_ref,error_gluc_ref,error_fruc_ref,error_sucr_ref,error_malt_ref] = costfun_FF01_all_recall_error(x_temp,setup,x,plotflag,selPars,lambda,w);
% % % %     %% simulate reference here
% % % % %     disp('run from here')
% % % %     % x = x1BSucr;
% % % %     simulate_all
% % % %     sim_ref_gluc = selResCellFF01;
% % % %     sim_ref_fruc = selResCellFF01Fruc;
% % % %     sim_ref_sucr = selResCellFF01Sucr;
% % % %     sim_ref_malt = selResCellFF01Malt;
% % % %     %
% % % %     save('pE1_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
% % % %         "error_ref","error_gluc_ref","error_fruc_ref","error_sucr_ref","error_malt_ref",...
% % % %         "error_cell","error_gluc_cell","error_fruc_cell","error_sucr_cell","error_malt_cell")
% % % % %%
% % % % load('pE1_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
% % % %     "error_ref","error_gluc_ref","error_fruc_ref","error_sucr_ref","error_malt_ref",...
% % % %     "error_cell","error_gluc_cell","error_fruc_cell","error_sucr_cell","error_malt_cell")
% % % % 
% % % % 
% % % % 
% % % % %% Visualize error
% % % % id2plot = 2;
% % % % plotflag = 12;
% % % % if plotflag == 12
% % % %     % glucose
% % % %     fn_eGluc = fieldnames(error_gluc_cell{id2plot});
% % % %     temp_error_gluc = struct2cell(error_gluc_cell{id2plot});
% % % %     temp_error_gluc_ref = struct2cell(error_gluc_ref);
% % % %     figure(301)
% % % %     for k = 1:(numel(fn_eGluc)-1)
% % % %         subplot(3,6,k)
% % % %         bar([temp_error_gluc_ref{k}, temp_error_gluc{k}],1.5)
% % % %         title(fn_eGluc{k})
% % % %         ylim([-1 1])
% % % %     end
% % % %     % fructose
% % % %     fn_eFruc = fieldnames(error_fruc_cell{id2plot});
% % % %     temp_error_fruc = struct2cell(error_fruc_cell{id2plot});
% % % %     temp_error_fruc_ref = struct2cell(error_fruc_ref);
% % % %     figure(302)
% % % %     for k = 1:(numel(fn_eFruc)-1)
% % % %         subplot(3,6,k)
% % % %         bar([temp_error_fruc_ref{k}, temp_error_fruc{k}],1.5)
% % % %         title(fn_eFruc{k})
% % % %         ylim([-1 1])
% % % %     end
% % % %     % sucrose
% % % %     fn_eSucr = fieldnames(error_sucr_cell{id2plot});
% % % %     temp_error_sucr = struct2cell(error_sucr_cell{id2plot});
% % % %     temp_error_sucr_ref = struct2cell(error_sucr_ref);
% % % %     figure(303)
% % % %     for k = 1:(numel(fn_eSucr)-1)
% % % %         subplot(3,6,k)
% % % %         bar([temp_error_sucr_ref{k}, temp_error_sucr{k}],1.5)
% % % %         title(fn_eSucr{k})
% % % %         ylim([-1 1])
% % % %     end
% % % %     % maltose
% % % %     fn_eMalt = fieldnames(error_malt_cell{id2plot});
% % % %     temp_error_malt = struct2cell(error_malt_cell{id2plot});
% % % %     temp_error_malt_ref = struct2cell(error_malt_ref);
% % % %     figure(304)
% % % %     for k = 1:(numel(fn_eMalt)-1)
% % % %         subplot(3,6,k)
% % % %         bar([temp_error_malt_ref{k}, temp_error_malt{k}],1.5)
% % % %         title(fn_eMalt{k})
% % % %         ylim([-1 1])
% % % %     end
% % % % end
% % % % plotflag = 0;
% % % % 

%% simulate reference
simulate_all
sim_ref_gluc = selResCellFF01;
sim_ref_fruc = selResCellFF01Fruc;
sim_ref_sucr = selResCellFF01Sucr;
sim_ref_malt = selResCellFF01Malt;

%% simulation visualization
% nS = 32;
% sims_gluc = [sims_gluc; selResCellFF01];
% sims_fruc = [sims_fruc; selResCellFF01Fruc];
% sims_sucr = [sims_sucr; selResCellFF01Sucr];
% sims_malt = [sims_malt; selResCellFF01Malt];
% nSims = 32+1;
close all
nref = 21;
% selSims = [11,21]; % manual
selSims = [1:3,21]; % manual
% selSims = [1:10,21]; % c1 control works
% % selSims = [11:20,21]; % c2 ref ald
plot_all_loop
% plot_all


%% examine. Taking the 3rd case as an example
fh4001 = figure(4001);
fh4001.Position = [111 367 1608 534];
%
subplot(1,3,[1 2])
plot(1:34,xref(parSet4),'o-',"Color",[.7 .7 .7],"MarkerFaceColor",[.7 .7 .7],"MarkerEdgeColor",[.7 .7 .7])
hold on
plot(1:34,xAll(1,parSet4),'o-',"Color",'b',"MarkerFaceColor",'b',"MarkerEdgeColor",'b')
hold on
plot(1:34,xAll(3,parSet4),'o-',"Color",'k',"MarkerFaceColor",'k',"MarkerEdgeColor",'k')
xticks(1:34)
xticklabels(parSet4)
xlim([0 35])
%
subplot(1,3,3)
plot(1:7,xref(parSet5),'o-',"Color",[.7 .7 .7],"MarkerFaceColor",[.7 .7 .7],"MarkerEdgeColor",[.7 .7 .7])
hold on
plot(1:7,xAll(1,parSet5),'o-',"Color",'b',"MarkerFaceColor",'b',"MarkerEdgeColor",'b')
hold on
plot(1:7,xAll(3,parSet5),'o-',"Color",'k',"MarkerFaceColor",'k',"MarkerEdgeColor",'k')
xticks(1:7)
xticklabels(parSet5)
xlim([0 8])




%% save resulting case

