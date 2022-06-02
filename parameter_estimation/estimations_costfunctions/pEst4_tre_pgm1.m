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
% load('x1_initial.mat','x1BSucr','x1AFruct')
% x = x1BSucr;
load('x_Y3M3_2.mat','x_Y3M3_2')
x = x_Y3M3_2;

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

% 1 tre. all sugars.
% 1 tre. fructose-specific.
% 1 tre. sucrose-specific.
% 1 tre. maltose-specific.

% 2 tre + ref. all sugars.
% 2 tre + ref. fructose-specific.
% 2 tre + ref. sucrose-specific.
% 2 tre + ref. maltose-specific.

% 3 tre + ref + gapdh. all sugars.
% 3 tre + ref + gapdh. fructose-specific.
% 3 tre + ref + gapdh. sucrose-specific.
% 3 tre + ref + gapdh. maltose-specific.

% optimOptions
options = optimoptions('lsqnonlin','Display','iter',...
    'FunctionTolerance', 1e-4, 'OptimalityTolerance', 1e-4,...
    'DiffMinChange',0.1);

% % 
nS1 = 4;
% saveNames
saveNames = cell(nS1,1);
% case 1. tre
saveNames{1} = 'pE4_pgm1_all.mat';
saveNames{2} = 'pE4_pgm1_fructose.mat';
saveNames{3} = 'pE4_pgm1_sucrose.mat';
saveNames{4} = 'pE4_pgm1_maltose.mat';

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
parSet1 = parPGM1;

% % 
parCombs = cell(nS1,1);
% case 1. tre
parCombs{1} = parSet1; %'pE3_par1tre_all.mat';
parCombs{2} = parSet1; %'pE3_par1tre_fructose.mat';
parCombs{3} = parSet1; %'pE3_par1tre_sucrose.mat';
parCombs{4} = parSet1; %'pE3_par1tre_maltose.mat';

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
% case 1. tre
warray{1}([203 304 403]) = ones; %'pE3_par1tre_all.mat';
warray{2}(203) = ones; %'pE3_par1tre_fructose.mat';
warray{3}(304) = ones; %'pE3_par1tre_sucrose.mat';
warray{4}(403) = ones; %'pE3_par1tre_maltose.mat';


% %% parameter estimation
% id_runs = 1:4;
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
%     if(i<=4)
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
%     x = x_Y3M3_2; x(selPars) = xres;
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
nS = 4;
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

%% simulation visualization
% nS = 32;
% sims_gluc = [sims_gluc; selResCellFF01];
% sims_fruc = [sims_fruc; selResCellFF01Fruc];
% sims_sucr = [sims_sucr; selResCellFF01Sucr];
% sims_malt = [sims_malt; selResCellFF01Malt];
% nSims = 32+1;
close all
nref = 5;
% selSims = [1,5]; % manual
selSims = [1:4,5]; % p1
plot_all_loop
% plot_all


%%
%% saving
fh3 = figure(3);
fh5 = figure(5);
fh7 = figure(7);
% 
pE4_pgm1_fruc = interp1(fh3.Children(20).Children(6).XData,...
    fh3.Children(20).Children(6).YData,...
    fh3.Children(20).Children(2).XData, ...
    'pchip');
pE4_pgm1_sucr = interp1(fh5.Children(20).Children(5).XData,...
    fh5.Children(20).Children(5).YData,...
    fh5.Children(20).Children(2).XData, ...
    'pchip');
pE4_pgm1_malt = interp1(fh7.Children(20).Children(4).XData,...
    fh7.Children(20).Children(4).YData,...
    fh7.Children(20).Children(2).XData, ...
    'pchip');


%%
saveNames_4 = saveNames;
save('pE4_simData.mat',...
    'sims_gluc', 'sim_ref_gluc',...
    'sims_fruc', 'sim_ref_fruc',...
    'sims_sucr', 'sim_ref_sucr',...
    'sims_malt', 'sim_ref_malt',...
    'pE4_pgm1_fruc', 'pE4_pgm1_sucr', 'pE4_pgm1_malt', ...
    "saveNames_4")


% saveNames_3 = saveNames;
% save('pE3_simData.mat',...
%     'sims_gluc', 'sim_ref_gluc',...
%     'sims_fruc', 'sim_ref_fruc',...
%     'sims_sucr', 'sim_ref_sucr',...
%     'sims_malt', 'sim_ref_malt',...
%     'pE3_pgm1_tps1_fruc', 'pE3_pgm1_tps1_sucr', 'pE3_pgm1_tps1_malt', ...
%     'pE3_exp_fruc', 'pE3_exp_sucr', 'pE3_exp_malt', ...
%     'pE3_ref_fruc', 'pE3_ref_sucr', 'pE3_ref_malt', ...
%     "saveNames_3")



% %% study what is different in the parTRE estimates
% % 
% colAll = [0 0.4470 0.7410];
% colFruc = [0.8500 0.3250 0.0980];
% colSucr = [0.9290 0.6940 0.1250];
% colMalt = [0.4940 0.1840 0.5560];
% % 
% % clf(100)
% fh100 = figure(100);
% fh100.Position = [1 41 1920 963];
% subplot(2,4,1), plot(xAll(1,parSet1),'o-','color',colAll,'MarkerFaceColor',colAll,'MarkerSize',4), title('all sugars'), ylim([-3 3])
%     xlim([0 10]), xticks(1:9), xticklabels(legenda.parameters(parSet1)),xtickangle(90)
% subplot(2,4,2), plot(xAll(2,parSet1),'o-','color',colFruc,'MarkerFaceColor',colFruc,'MarkerSize',4), title('fructose'), ylim([-3 3])
%     xlim([0 10]), xticks(1:9), xticklabels(legenda.parameters(parSet1)),xtickangle(90)
% subplot(2,4,5), plot(xAll(3,parSet1),'o-','color',colSucr,'MarkerFaceColor',colSucr,'MarkerSize',4), title('sucrose'), ylim([-3 3])
%     xlim([0 10]), xticks(1:9), xticklabels(legenda.parameters(parSet1)),xtickangle(90)
% subplot(2,4,6), plot(xAll(4,parSet1),'o-','color',colMalt,'MarkerFaceColor',colMalt,'MarkerSize',4), title('maltose'), ylim([-3 3])
%     xlim([0 10]), xticks(1:9), xticklabels(legenda.parameters(parSet1)),xtickangle(90)
% subplot(2,4,[3 4 7 8]), hold on, box on
%     plot(xAll(1,parSet1),'o-','color',colAll,'MarkerFaceColor',colAll,'MarkerSize',4), 
%     plot(xAll(2,parSet1),'o-','color',colFruc,'MarkerFaceColor',colFruc,'MarkerSize',4), 
%     plot(xAll(3,parSet1),'o-','color',colSucr,'MarkerFaceColor',colSucr,'MarkerSize',4), 
%     plot(xAll(4,parSet1),'o-','color',colMalt,'MarkerFaceColor',colMalt,'MarkerSize',4), 
%     legend('all sugars','fructose','sucrose','maltose')
%     xlim([0 10]), xticks(1:9), xticklabels(legenda.parameters(parSet1)),xtickangle(90)
% %% 
% diff_malt_all = xAll(1,parSet1) - xAll(4,parSet1);
% diff_malt_fruc = xAll(2,parSet1) - xAll(4,parSet1);
% diff_malt_sucr = xAll(3,parSet1) - xAll(4,parSet1);
% diff_malt_malt = xAll(4,parSet1) - xAll(4,parSet1);
% full_mat = [diff_malt_all', diff_malt_fruc', diff_malt_sucr', diff_malt_malt'];
% % 
% fh101 = figure(101);
% fh101.Position = [962 42 958 954];
% heatmap(full_mat)
% colormap("cool")
% fh101.Children.YDisplayLabels = legenda.parameters(parSet1);
% 
% 
% %% save resulting case
% 
% 

