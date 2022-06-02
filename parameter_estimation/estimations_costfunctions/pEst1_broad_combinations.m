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

% save names
% select parameters
    % new parameters
    % new parameters + trehalose (entire)
    % new parameters + upper glycolysis (entire)
    % new parameters + upper glycolysis (single enzymes...)
    % new parameters + all included
% cost function
    % negative control: no weights 
    % fit sugars (in&out) + FBP
    % fit sugars (in&out) + FBP + LG
    % fit sugars (in&out) + FBP + TRE
    % fit sugars (in&out) + FBP + uptake rates
    % fit all

% optimOptions
options = optimoptions('lsqnonlin','Display','iter',...
    'FunctionTolerance', 1e-4, 'OptimalityTolerance', 1e-4,...
    'DiffMinChange',0.1);

% saveNames
saveNames = cell(32,1);
% par1new
saveNames{1} = 'pE1_par1new_cf1negcontrol.mat';
saveNames{2} = 'pE1_par1new_cf2sugars_fbp.mat';
saveNames{3} = 'pE1_par1new_cf3sugars_fbp_lg.mat';
saveNames{4} = 'pE1_par1new_cf4sugars_fbp_tre.mat';
saveNames{5} = 'pE1_par1new_cf5sugars_fbp_uptrates.mat';
saveNames{6} = 'pE1_par1new_cf6all.mat';
% par2new_tre
saveNames{7} = 'pE1_par2new_tre_cf2sugars_fbp.mat';
saveNames{8} = 'pE1_par2new_tre_cf3sugars_fbp_lg.mat';
saveNames{9} = 'pE1_par2new_tre_cf4sugars_fbp_tre.mat';
saveNames{10} = 'pE1_par2new_tre_cf5sugars_fbp_uptrates.mat';
saveNames{11} = 'pE1_par2new_tre_cf6all.mat';
% par3new_ugall
saveNames{12} = 'pE1_par3new_ugall_cf2sugars_fbp.mat';
saveNames{13} = 'pE1_par3new_ugall_cf3sugars_fbp_lg.mat';
saveNames{14} = 'pE1_par3new_ugall_cf4sugars_fbp_tre.mat';
saveNames{15} = 'pE1_par3new_ugall_cf5sugars_fbp_uptrates.mat';
saveNames{16} = 'pE1_par3new_ugall_cf6all.mat';
% par4new_ugsingle_pgi
saveNames{17} = 'pE1_par4new_ugsingle_pgi_cf2sugars_fbp.mat';
saveNames{18} = 'pE1_par4new_ugsingle_pgi_cf3sugars_fbp_lg.mat';
saveNames{19} = 'pE1_par4new_ugsingle_pgi_cf4sugars_fbp_tre.mat';
saveNames{20} = 'pE1_par4new_ugsingle_pgi_cf5sugars_fbp_uptrates.mat';
saveNames{21} = 'pE1_par4new_ugsingle_pgi_cf6all.mat';
% par5new_ugsingle_pfk
saveNames{22} = 'pE1_par5new_ugsingle_pfk_cf2sugars_fbp.mat';
saveNames{23} = 'pE1_par5new_ugsingle_pfk_cf3sugars_fbp_lg.mat';
saveNames{24} = 'pE1_par5new_ugsingle_pfk_cf4sugars_fbp_tre.mat';
saveNames{25} = 'pE1_par5new_ugsingle_pfk_cf5sugars_fbp_uptrates.mat';
saveNames{26} = 'pE1_par5new_ugsingle_pfk_cf6all.mat';
% par6new_ugsingle_ald
saveNames{27} = 'pE1_par6new_ugsingle_ald_cf2sugars_fbp.mat';
saveNames{28} = 'pE1_par6new_ugsingle_ald_cf3sugars_fbp_lg.mat';
saveNames{29} = 'pE1_par6new_ugsingle_ald_cf4sugars_fbp_tre.mat';
saveNames{30} = 'pE1_par6new_ugsingle_ald_cf5sugars_fbp_uptrates.mat';
saveNames{31} = 'pE1_par6new_ugsingle_ald_cf6all.mat';
% par7all
saveNames{32} = 'pE1_par7all_cf6all.mat';


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
parSet1 = [parHXT, parHXK, parINV,parMALX];
parSet2 = [parHXT, parHXK, parINV,parMALX, parTRE];
parSet3 = [parHXT, parHXK, parINV,parMALX, parUG];
parSet4 = [parHXT, parHXK, parINV,parMALX, parPGI];
parSet5 = [parHXT, parHXK, parINV,parMALX, parPFK];
parSet6 = [parHXT, parHXK, parINV,parMALX, parALD];
parSet7 = [parHXT, parHXK, parINV,parMALX, parTRE, parUG];
% 
parCombs = cell(32,1);
% par1new
parCombs{1} = parSet1; %'pE1_par1new_cf1negcontrol.mat';
parCombs{2} = parSet1; %'pE1_par1new_cf2sugars_fbp.mat';
parCombs{3} = parSet1; %'pE1_par1new_cf3sugars_fbp_lg.mat';
parCombs{4} = parSet1; %'pE1_par1new_cf4sugars_fbp_tre.mat';
parCombs{5} = parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
parCombs{6} = parSet1; %'pE1_par1new_cf6all.mat';
% par2new_tre
parCombs{7} = parSet2; %'pE1_par2new_tre_cf2sugars_fbp.mat';
parCombs{8} = parSet2; %'pE1_par2new_tre_cf3sugars_fbp_lg.mat';
parCombs{9} = parSet2; %'pE1_par2new_tre_cf4sugars_fbp_tre.mat';
parCombs{10} = parSet2; %'pE1_par2new_tre_cf5sugars_fbp_uptrates.mat';
parCombs{11} = parSet2; %'pE1_par2new_tre_cf6all.mat';
% par3new_ugall
parCombs{12} = parSet3; %'pE1_par3new_ugall_cf2sugars_fbp.mat';
parCombs{13} = parSet3; %'pE1_par3new_ugall_cf3sugars_fbp_lg.mat';
parCombs{14} = parSet3; %'pE1_par3new_ugall_cf4sugars_fbp_tre.mat';
parCombs{15} = parSet3; %'pE1_par3new_ugall_cf5sugars_fbp_uptrates.mat';
parCombs{16} = parSet3; %'pE1_par3new_ugall_cf6all.mat';
% par4new_ugsingle_pgi
parCombs{17} = parSet4; %'pE1_par4new_ugsingle_pgi_cf2sugars_fbp.mat';
parCombs{18} = parSet4; %'pE1_par4new_ugsingle_pgi_cf3sugars_fbp_lg.mat';
parCombs{19} = parSet4; %'pE1_par4new_ugsingle_pgi_cf4sugars_fbp_tre.mat';
parCombs{20} = parSet4; %'pE1_par4new_ugsingle_pgi_cf5sugars_fbp_uptrates.mat';
parCombs{21} = parSet4; %'pE1_par4new_ugsingle_pgi_cf6all.mat';
% par5new_ugsingle_pfk
parCombs{22} = parSet5; %'pE1_par4new_ugsingle_pfk_cf2sugars_fbp.mat';
parCombs{23} = parSet5; %'pE1_par4new_ugsingle_pfk_cf3sugars_fbp_lg.mat';
parCombs{24} = parSet5; %'pE1_par4new_ugsingle_pfk_cf4sugars_fbp_tre.mat';
parCombs{25} = parSet5; %'pE1_par4new_ugsingle_pfk_cf5sugars_fbp_uptrates.mat';
parCombs{26} = parSet5; %'pE1_par4new_ugsingle_pfk_cf6all.mat';
% par6new_ugsingle_ald
parCombs{27} = parSet6; %'pE1_par4new_ugsingle_ald_cf2sugars_fbp.mat';
parCombs{28} = parSet6; %'pE1_par4new_ugsingle_ald_cf3sugars_fbp_lg.mat';
parCombs{29} = parSet6; %'pE1_par4new_ugsingle_ald_cf4sugars_fbp_tre.mat';
parCombs{30} = parSet6; %'pE1_par4new_ugsingle_ald_cf5sugars_fbp_uptrates.mat';
parCombs{31} = parSet6; %'pE1_par4new_ugsingle_ald_cf6all.mat';
% par7all
parCombs{32} = parSet7; 

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

% 
wbaseline = zeros(499,1);
warray = cell(32,1);
for i = 1:length(warray)
    warray{i} = wbaseline;
end
% par1new
% warray{1} = parSet1; %'pE1_par1new_cf1negcontrol.mat';
warray{2}(wsugars_fbp) = ones; %parSet1; %'pE1_par1new_cf2sugars_fbp.mat';
warray{3}(wsugars_fbp_lg) = ones; %parSet1; %'pE1_par1new_cf3sugars_fbp_lg.mat';
warray{4}(wsugars_fbp_tre) = ones; %parSet1; %'pE1_par1new_cf4sugars_fbp_tre.mat';
warray{5}(wsugars_fbp) = ones; %parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
    warray{5}(wrates) = 3*ones; %parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
warray{6}(wall) = ones; %parSet1; %'pE1_par1new_cf6all.mat';
% par2new_tre
warray{7}(wsugars_fbp) = ones; %parSet2; %'pE1_par2new_tre_cf2sugars_fbp.mat';
warray{8}(wsugars_fbp_lg) = ones; %parSet2; %'pE1_par2new_tre_cf3sugars_fbp_lg.mat';
warray{9}(wsugars_fbp_tre) = ones; %parSet2; %'pE1_par2new_tre_cf4sugars_fbp_tre.mat';
warray{10}(wsugars_fbp) = ones; %parSet2; %'pE1_par2new_tre_cf5sugars_fbp_uptrates.mat';
    warray{10}(wrates) = 3*ones; %parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
warray{11}(wall) = ones; %parSet2; %'pE1_par2new_tre_cf6all.mat';
% par3new_ugall
warray{12}(wsugars_fbp) = ones; %parSet3; %'pE1_par3new_ugall_cf2sugars_fbp.mat';
warray{13}(wsugars_fbp_lg) = ones; %parSet3; %'pE1_par3new_ugall_cf3sugars_fbp_lg.mat';
warray{14}(wsugars_fbp_tre) = ones; %parSet3; %'pE1_par3new_ugall_cf4sugars_fbp_tre.mat';
warray{15}(wsugars_fbp) = ones; %parSet3; %'pE1_par3new_ugall_cf5sugars_fbp_uptrates.mat';
    warray{15}(wrates) = 3*ones; %parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
warray{16}(wall) = ones; %parSet3; %'pE1_par3new_ugall_cf6all.mat';
% par4new_ugsingle_pgi
warray{17}(wsugars_fbp) = ones; %parSet4; %'pE1_par4new_ugsingle_pgi_cf2sugars_fbp.mat';
warray{18}(wsugars_fbp_lg) = ones; %parSet4; %'pE1_par4new_ugsingle_pgi_cf3sugars_fbp_lg.mat';
warray{19}(wsugars_fbp_tre) = ones; %parSet4; %'pE1_par4new_ugsingle_pgi_cf4sugars_fbp_tre.mat';
warray{20}(wsugars_fbp) = ones; %parSet4; %'pE1_par4new_ugsingle_pgi_cf5sugars_fbp_uptrates.mat';
    warray{20}(wrates) = 3*ones; %parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
warray{21}(wall) = ones; %parSet4; %'pE1_par4new_ugsingle_pgi_cf6all.mat';
% par5new_ugsingle_pfk
warray{22}(wsugars_fbp) = ones; %parSet5; %'pE1_par4new_ugsingle_pfk_cf2sugars_fbp.mat';
warray{23}(wsugars_fbp_lg) = ones; %parSet5; %'pE1_par4new_ugsingle_pfk_cf3sugars_fbp_lg.mat';
warray{24}(wsugars_fbp_tre) = ones; %parSet5; %'pE1_par4new_ugsingle_pfk_cf4sugars_fbp_tre.mat';
warray{25}(wsugars_fbp) = ones; %parSet5; %'pE1_par4new_ugsingle_pfk_cf5sugars_fbp_uptrates.mat';
    warray{25}(wrates) = 3*ones; %parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
warray{26}(wall) = ones; %parSet5; %'pE1_par4new_ugsingle_pfk_cf6all.mat';
% par6new_ugsingle_ald
warray{27}(wsugars_fbp) = ones; %parSet6; %'pE1_par4new_ugsingle_ald_cf2sugars_fbp.mat';
warray{28}(wsugars_fbp_lg) = ones; %parSet6; %'pE1_par4new_ugsingle_ald_cf3sugars_fbp_lg.mat';
warray{29}(wsugars_fbp_tre) = ones; %parSet6; %'pE1_par4new_ugsingle_ald_cf4sugars_fbp_tre.mat';
warray{30}(wsugars_fbp) = ones; %parSet6; %'pE1_par4new_ugsingle_ald_cf5sugars_fbp_uptrates.mat';
    warray{30}(wrates) = 3*ones; %parSet1; %'pE1_par1new_cf5sugars_fbp_uptrates.mat';
warray{31}(wall) = ones; %parSet6; %'pE1_par4new_ugsingle_ald_cf6all.mat';
% par7all
warray{32}(wall) = ones; %parSet7;


% %% parameter estimation
% id_runs = 1:32;
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
%     lb = -3*ones(1,plength); lb([1 2 6 7 8 9 10 11 12 13 23 24 25 26]) = -4 * ones; lb(27) = -6;
%     ub = 3*ones(1,plength); ub([1 2 6 7 8 9 10 11 12 13 23 24 25 26]) = 4 * ones; ub(27) = 6;
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
nS = 32;
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


%% visualize changes in error residuals (like inside the cost fuction)
    % here we will have to simulate first
    error_cell = {};
    error_gluc_cell = {};
    error_fruc_cell = {};
    error_sucr_cell = {};
    error_malt_cell = {};
    for i = 1:nS
        disp(i)
        % simulate
        w = warray{i};
        lambda = 0;
        selPars = parCombs{i};
        x_temp = xAll(i,selPars);
        [error,error_gluc,error_fruc,error_sucr,error_malt] = costfun_FF01_all_recall_error(x_temp,setup,x,plotflag,selPars,lambda,w);
        % recall
        error_cell = [error_cell; error];
        error_gluc_cell = [error_gluc_cell; error_gluc];
        error_fruc_cell = [error_fruc_cell; error_fruc];
        error_sucr_cell = [error_sucr_cell; error_sucr];
        error_malt_cell = [error_malt_cell; error_malt];
    end
    % simulate the reference case
    selPars = 1;
    x_temp = x(selPars);
    [error_ref,error_gluc_ref,error_fruc_ref,error_sucr_ref,error_malt_ref] = costfun_FF01_all_recall_error(x_temp,setup,x,plotflag,selPars,lambda,w);
    %% simulate reference here
%     disp('run from here')
    % x = x1BSucr;
    simulate_all
    sim_ref_gluc = selResCellFF01;
    sim_ref_fruc = selResCellFF01Fruc;
    sim_ref_sucr = selResCellFF01Sucr;
    sim_ref_malt = selResCellFF01Malt;
    %
    save('pE1_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
        "error_ref","error_gluc_ref","error_fruc_ref","error_sucr_ref","error_malt_ref",...
        "error_cell","error_gluc_cell","error_fruc_cell","error_sucr_cell","error_malt_cell")
%%
load('pE1_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
    "error_ref","error_gluc_ref","error_fruc_ref","error_sucr_ref","error_malt_ref",...
    "error_cell","error_gluc_cell","error_fruc_cell","error_sucr_cell","error_malt_cell")



%% Visualize error
id2plot = 2;
plotflag = 12;
if plotflag == 12
    % glucose
    fn_eGluc = fieldnames(error_gluc_cell{id2plot});
    temp_error_gluc = struct2cell(error_gluc_cell{id2plot});
    temp_error_gluc_ref = struct2cell(error_gluc_ref);
    figure(301)
    for k = 1:(numel(fn_eGluc)-1)
        subplot(3,6,k)
        bar([temp_error_gluc_ref{k}, temp_error_gluc{k}],1.5)
        title(fn_eGluc{k})
        ylim([-1 1])
    end
    % fructose
    fn_eFruc = fieldnames(error_fruc_cell{id2plot});
    temp_error_fruc = struct2cell(error_fruc_cell{id2plot});
    temp_error_fruc_ref = struct2cell(error_fruc_ref);
    figure(302)
    for k = 1:(numel(fn_eFruc)-1)
        subplot(3,6,k)
        bar([temp_error_fruc_ref{k}, temp_error_fruc{k}],1.5)
        title(fn_eFruc{k})
        ylim([-1 1])
    end
    % sucrose
    fn_eSucr = fieldnames(error_sucr_cell{id2plot});
    temp_error_sucr = struct2cell(error_sucr_cell{id2plot});
    temp_error_sucr_ref = struct2cell(error_sucr_ref);
    figure(303)
    for k = 1:(numel(fn_eSucr)-1)
        subplot(3,6,k)
        bar([temp_error_sucr_ref{k}, temp_error_sucr{k}],1.5)
        title(fn_eSucr{k})
        ylim([-1 1])
    end
    % maltose
    fn_eMalt = fieldnames(error_malt_cell{id2plot});
    temp_error_malt = struct2cell(error_malt_cell{id2plot});
    temp_error_malt_ref = struct2cell(error_malt_ref);
    figure(304)
    for k = 1:(numel(fn_eMalt)-1)
        subplot(3,6,k)
        bar([temp_error_malt_ref{k}, temp_error_malt{k}],1.5)
        title(fn_eMalt{k})
        ylim([-1 1])
    end
end
plotflag = 0;


%% simulation visualization
% nS = 32;
% sims_gluc = [sims_gluc; selResCellFF01];
% sims_fruc = [sims_fruc; selResCellFF01Fruc];
% sims_sucr = [sims_sucr; selResCellFF01Sucr];
% sims_malt = [sims_malt; selResCellFF01Malt];
% nSims = 32+1;
close all
nref = 33;
% selSims = [21,33]; % manual
% selSims = [1:6,33]; % 1 ref
% selSims = [7:11,33]; % 2 tre
% selSims = [12:16,33]; % 3 ug
% selSims = [17:21,33]; % 4 pgi
% selSims = [22:26,33]; % 5 pfk
% selSims = [27:31,33]; % 6 ald
% selSims = [32,33]; % 7 all
selSims = [31,33]; % 7 all
plot_all_loop
% plot_all


%% testing for figure 6
close all
nref = 33;
% selSims = [21,33]; % manual
% selSims = [1:6,33]; % cf1
% selSims = [7:11,33]; % cf2
% selSims = [12:16,33]; % cf3
% selSims = [17:21,33]; % cf4
% selSims = [22:26,33]; % cf5
% selSims = [27:31,33]; % cf6
selSims = [6,11,16,21,26,31,32,  33]; % cf1
plot_all_loop
% plot_all




