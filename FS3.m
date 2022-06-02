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
% case 1. control
saveNames{1} = 'pE2_c1_control_par6new_ugsingle_ald_cf6all.mat';
% case 2. ref + ald
saveNames{2} = 'pE2_c2_ref_ald_fructose.mat';
saveNames{3} = 'pE2_c2_ref_ald_sucrose.mat';
saveNames{4} = 'pE2_c2_ref_ald_maltose.mat';
% case 3. only ald
saveNames{5} = 'pE2_c3_ald_fructose.mat';
saveNames{6} = 'pE2_c3_ald_sucrose.mat';
saveNames{7} = 'pE2_c3_ald_maltose.mat';
% case 4. ref + gapdh
saveNames{8} = 'pE2_c4_ref_gapdh_cf6all.mat';
saveNames{9} = 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
saveNames{10} = 'pE2_c4_ref_gapdh_fructose.mat';
saveNames{11} = 'pE2_c4_ref_gapdh_sucrose.mat';
saveNames{12} = 'pE2_c4_ref_gapdh_maltose.mat';
% case 5. gapdh
saveNames{13} = 'pE2_c5_gapdh_fructose.mat';
saveNames{14} = 'pE2_c5_gapdh_sucrose.mat';
saveNames{15} = 'pE2_c5_gapdh_maltose.mat';
% case 6. ref + ald + tre
saveNames{16} = 'pE2_c6_ref_ald_tre_fructose.mat';
saveNames{17} = 'pE2_c6_ref_ald_tre_sucrose.mat';
saveNames{18} = 'pE2_c6_ref_ald_tre_maltose.mat';
% case 6. ref + gapdh + tre
saveNames{19} = 'pE2_c7_ref_gapdh_tre_fructose.mat';
saveNames{20} = 'pE2_c7_ref_gapdh_tre_sucrose.mat';
saveNames{21} = 'pE2_c7_ref_gapdh_tre_maltose.mat';

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
% case 1. control
parCombs{1} = parSet1; % 'pE2_c1_control_par6new_ugsingle_ald_cf6all.mat';
% case 2. ref + ald
parCombs{2} = parSet2; % 'pE2_c2_ref_ald_fructose.mat';
parCombs{3} = parSet2; % 'pE2_c2_ref_ald_sucrose.mat';
parCombs{4} = parSet2; % 'pE2_c2_ref_ald_maltose.mat';
% case 3. only ald
parCombs{5} = parSet3; % 'pE2_c3_ald_fructose.mat';
parCombs{6} = parSet3; % 'pE2_c3_ald_sucrose.mat';
parCombs{7} = parSet3; % 'pE2_c3_ald_maltose.mat';
% case 4. ref + gapdh
parCombs{8} = parSet4; % 'pE2_c4_ref_gapdh_cf6all.mat';
parCombs{9} = parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
parCombs{10} = parSet4; % 'pE2_c4_ref_gapdh_fructose.mat';
parCombs{11} = parSet4; % 'pE2_c4_ref_gapdh_sucrose.mat';
parCombs{12} = parSet4; % 'pE2_c4_ref_gapdh_maltose.mat';
% case 5. gapdh
parCombs{13} = parSet5; % 'pE2_c5_gapdh_fructose.mat';
parCombs{14} = parSet5; % 'pE2_c5_gapdh_sucrose.mat';
parCombs{15} = parSet5; % 'pE2_c5_gapdh_maltose.mat';
% case 6. ref + ald + tre
parCombs{16} = parSet6; % 'pE2_c6_ref_ald_tre_fructose.mat';
parCombs{17} = parSet6; % 'pE2_c6_ref_ald_tre_sucrose.mat';
parCombs{18} = parSet6; % 'pE2_c6_ref_ald_tre_maltose.mat';
% case 7. ref + gapdh + tre
parCombs{19} = parSet7; % 'pE2_c7_ref_ald_tre_fructose.mat';
parCombs{20} = parSet7; % 'pE2_c7_ref_ald_tre_sucrose.mat';
parCombs{21} = parSet7; % 'pE2_c7_ref_ald_tre_maltose.mat';

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
warray{1}(wall) = ones; % parSet1; % 'pE2_c1_control_par6new_ugsingle_ald_cf6all.mat';
% case 2. ref + ald
warray{2}([201 206 209 203 220]) = ones; % parSet2; % 'pE2_c2_ref_ald_fructose.mat';
warray{3}([301 302 307 310 304 320]) = ones; % parSet2; % 'pE2_c2_ref_ald_sucrose.mat';
warray{4}([401 406 409 403 420]) = ones; % parSet2; % 'pE2_c2_ref_ald_maltose.mat';
% case 3. only ald
warray{5}([201 206 209 203 220]) = ones; % parSet3; % 'pE2_c3_ald_fructose.mat';
warray{6}([301 302 307 310 304 320]) = ones; % parSet3; % 'pE2_c3_ald_sucrose.mat';
warray{7}([401 406 409 403 420]) = ones; % parSet3; % 'pE2_c3_ald_maltose.mat';
% case 4. ref + gapdh
warray{8}(wall) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all.mat';
warray{9}([wall, 208 309 408, 207 308 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_cf6all_gap_dhap.mat';
warray{10}([201 206 209 203 220 208 207]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_fructose.mat';
warray{11}([301 302 307 310 304 320 309 308]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_sucrose.mat';
warray{12}([401 406 409 403 420 408 407]) = ones; % parSet4; % 'pE2_c4_ref_gapdh_maltose.mat';
% case 5. gapdh
warray{13}([201 206 209 203 220 208 207]) = ones; % parSet5; % 'pE2_c5_gapdh_fructose.mat';
warray{14}([301 302 307 310 304 320 309 308]) = ones; % parSet5; % 'pE2_c5_gapdh_sucrose.mat';
warray{15}([401 406 409 403 420 408 407]) = ones; % parSet5; % 'pE2_c5_gapdh_maltose.mat';
% case 6. ref + ald + tre
warray{16}([201 206 209 203 220 203]) = ones; % parSet6; % 'pE2_c6_ref_ald_tre_fructose.mat';
warray{17}([301 302 307 310 304 320 304]) = ones; % parSet6; % 'pE2_c6_ref_ald_tre_sucrose.mat';
warray{18}([401 406 409 403 420 403]) = ones; % parSet6; % 'pE2_c6_ref_ald_tre_maltose.mat';
% case 7. ref + gapdh + tre
warray{19}([201 206 209 203 220 208 207 203]) = ones; % parSet7; % 'pE2_c7_ref_ald_tre_fructose.mat';
warray{20}([301 302 307 310 304 320 309 308 304]) = ones; % parSet7; % 'pE2_c7_ref_ald_tre_sucrose.mat';
warray{21}([401 406 409 403 420 408 407 403]) = ones; % parSet7; % 'pE2_c7_ref_ald_tre_maltose.mat';



%% parameter estimation
% id_runs = 1:21;
% x1 = x;
% cluster = parcluster('local');
% pool = parpool(cluster,4);
% % pool = parpool(cluster,16);
% parfor i = id_runs
%     % preparation
%     saveName = saveNames{i};
%     selPars = parCombs{i};% selPars
%     w = warray{i}; % w
%     lambda = 0; % lambda
%     x_temp = x1(selPars);
%     plength = length(selPars);
%     if((i==5)||(i==6)||(i==7)||(i==13)||(i==14)||(i==15))
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
% delete(pool)
% quit

%% visualization
% recall info
xAll = []; 
namesHits = {}; 
residual_array = [];
sims_gluc = {};
sims_fruc = {};
sims_sucr = {};
sims_malt = {};
nS = 21;
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
        residual_array = [residual_array; residual'];
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

%% focus for figure 6

% % fructose
% close all
% nref = 14;
% selSims = [5,14]; % 5:7, fructose, sucrose and maltose
% plot_all_loop
% fh3 = figure(3);
% savefig(fh3,'pE2_fructose.fig')
% % fructose
% close all
% nref = 14;
% selSims = [6,14]; % 5:7, fructose, sucrose and maltose
% plot_all_loop
% fh5 = figure(5);
% savefig(fh5,'pE2_sucrose.fig')
% % fructose
% close all
% nref = 14;
% selSims = [7,14]; % 5:7, fructose, sucrose and maltose
% plot_all_loop
% fh7 = figure(7);
% savefig(fh7,'pE2_maltose.fig')

% % % all check
% % close all
% % nref = 14;
% % selSims = [5:7,14]; % 5:7, fructose, sucrose and maltose
% % plot_all_loop




%% simulation visualization
% nS = 32;
% sims_gluc = [sims_gluc; selResCellFF01];
% sims_fruc = [sims_fruc; selResCellFF01Fruc];
% sims_sucr = [sims_sucr; selResCellFF01Sucr];
% sims_malt = [sims_malt; selResCellFF01Malt];
% nSims = 32+1;
close all
nref = 14;
% selSims = [5,14]; % manual
selSims = [5,6,7,14]; % 5,6,7
plot_all_loop
% plot_all


%% Recall P2G
fh_3 = figure(3);
fh_5 = figure(5);
fh_7 = figure(7);

%%
% EXP
% GAPDH
% GAPDH_CSD

% fruc
threePG.fruc.exp_time = fh_3.Children(11).Children(2).XData;
threePG.fruc.exp_conc = fh_3.Children(11).Children(2).YData;
threePG.fruc.sim_gapdh_time = fh_3.Children(11).Children(6).XData;
threePG.fruc.sim_gapdh = fh_3.Children(11).Children(6).YData;
threePG.fruc.sim_gapdh_csd_time = fh_3.Children(11).Children(5).XData;
threePG.fruc.sim_gapdh_csd = fh_3.Children(11).Children(5).YData;
% sucr
threePG.sucr.exp_time = fh_5.Children(11).Children(2).XData;
threePG.sucr.exp_conc = fh_5.Children(11).Children(2).YData;
threePG.sucr.sim_gapdh_time = fh_5.Children(11).Children(6).XData;
threePG.sucr.sim_gapdh = fh_5.Children(11).Children(6).YData;
threePG.sucr.sim_gapdh_csd_time = fh_5.Children(11).Children(5).XData;
threePG.sucr.sim_gapdh_csd = fh_5.Children(11).Children(5).YData;
% malt
threePG.malt.exp_time = fh_7.Children(11).Children(2).XData;
threePG.malt.exp_conc = fh_7.Children(11).Children(2).YData;
threePG.malt.sim_gapdh_time = fh_7.Children(11).Children(6).XData;
threePG.malt.sim_gapdh = fh_7.Children(11).Children(6).YData;
threePG.malt.sim_gapdh_csd_time = fh_7.Children(11).Children(4).XData;
threePG.malt.sim_gapdh_csd = fh_7.Children(11).Children(4).YData;


%% 
% 
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
colGluc_dark = colGluc/2;
colFruc_dark = colFruc/2;
colSucr_dark = colSucr/2;
colMalt_dark = colMalt/2;
colGluc_soft = colGluc + ([1 1 1] - colGluc)/3;
colFruc_soft = colFruc + ([1 1 1] - colFruc)/3;
colSucr_soft = colSucr + ([1 1 1] - colSucr)/3;
colMalt_soft = colMalt + ([1 1 1] - colMalt)/3;


if exist('fh_700071','var')
    clf(fh_700071)
end
fh_700071 = figure(700071);
% fh_700071.Position = [1978 639 827 280];
fh_700071.Position = [1978 712 762 207];
% fruc
subplot(1,3,1)
p1 = plot(threePG.fruc.sim_gapdh_csd_time, threePG.fruc.sim_gapdh_csd, ...
    '-','LineWidth',1.5, 'Color', [.7 .7 .7]);
hold on
p2 = plot(threePG.fruc.sim_gapdh_time, threePG.fruc.sim_gapdh, ...
    '-','LineWidth',1.5, 'Color', 'k');
p3 = plot(threePG.fruc.exp_time, threePG.fruc.exp_conc, ...
    'o','MarkerSize',5,'Color',colFruc_dark,'MarkerFaceColor',colFruc);
ylim([0 6])
xlabel('Time (s)')
ylabel('[3PG] (mM)')
title('FF Fructose','Color',colFruc)
% sucr
subplot(1,3,2)
p1 = plot(threePG.sucr.sim_gapdh_csd_time, threePG.sucr.sim_gapdh_csd, ...
    '-','LineWidth',1.5, 'Color', [.7 .7 .7]);
hold on
p2 = plot(threePG.sucr.sim_gapdh_time, threePG.sucr.sim_gapdh, ...
    '-','LineWidth',1.5, 'Color', 'k');
p3 = plot(threePG.sucr.exp_time, threePG.sucr.exp_conc, ...
    'o','MarkerSize',5,'Color',colSucr_dark,'MarkerFaceColor',colSucr);
ylim([0 6])
legend([p1 p2 p3], 'GAPDH_{CSD}', 'GAPDH', 'experimental data',...
    'Location','South')
xlabel('Time (s)')
ylabel('[3PG] (mM)')
title('FF Sucrose','Color',colSucr)
% malt
subplot(1,3,3)
p1 = plot(threePG.malt.sim_gapdh_csd_time, threePG.malt.sim_gapdh_csd, ...
    '-','LineWidth',1.5, 'Color', [.7 .7 .7]);
hold on
p2 = plot(threePG.malt.sim_gapdh_time, threePG.malt.sim_gapdh, ...
    '-','LineWidth',1.5, 'Color', 'k');
p3 = plot(threePG.malt.exp_time, threePG.malt.exp_conc, ...
    'o','MarkerSize',5,'Color',colMalt_dark,'MarkerFaceColor',colMalt);
ylim([0 6])
xlabel('Time (s)')
ylabel('[3PG] (mM)')
title('FF Maltose','Color',colMalt)


% % % % % %% save current figure
% % % % % % print(fh_700071,'-dpdf','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\FS3data');
% % % % % print(fh_700071,'-dtiff','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\FS3data');
% % % % % savefig(fh_700071,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\FS3data');
% % % % % % 
% % % % % set(fh_700071,'Units','Inches');
% % % % % pos = get(fh_700071,'Position');
% % % % % set(fh_700071,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% % % % % print(fh_700071,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\FS3data','-dpdf','-r0')

