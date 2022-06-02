% Initial recall
clear; close all; clc;
set_paths;
dbstop if error

% initial setup
setup.clamp10.FBP = 0;
setup.sameKm = 1;
plotflag = 0; 


% %  selecting parameter
% x_literature
load('pset_pE10_xres.mat','x_pE10_end'); 
x_literature = zeros(1,184); x_literature(1:165) = x_pE10_end;
% x_ug
load('x1_initial.mat','x1BSucr','x1AFruct')
x_ug = x1BSucr;
% x_gapdh
load('x_Y3M3_3.mat','x_Y3M3_3')
x_gapdh = x_Y3M3_3;
% x_tre
load('x_Y3M3_4.mat','x_fit_all','x_fit_fructose','x_fit_sucrose','x_fit_maltose')
x_tre_fructose = x_fit_fructose;
x_tre_sucrose = x_fit_sucrose;
x_tre_maltose = x_fit_maltose; 


%% simulation 
x = x_gapdh;
load('pE9_sims_safecopy.mat','simref9','simclamp20')
% setup.clamp20.G6P = 0;
% setup.clamp20.F6P = 0;
% setup.clamp20.FBP = 0;
% setup.clamp20.DHAP = 0;
% setup.clamp20.GAP = 0;
% setup.clamp20.threePG = 0;
% setup.clamp20.twoPG = 0;


%% 
% 
sims_gluc = cell(1,1); sims_gluc{1} = simref9.gluc;
sims_fruc = cell(1,1); sims_fruc{1} = simref9.fruc;
sims_sucr = cell(1,1); sims_sucr{1} = simref9.sucr;
sims_malt = cell(1,1); sims_malt{1} = simref9.malt;

% 
n9 = 7;
sim_ref_gluc = cell(n9,1);
sim_ref_fruc = cell(n9,1);
sim_ref_sucr = cell(n9,1);
sim_ref_malt = cell(n9,1);
for i = 1:n9
    sim_ref_gluc{i} = simclamp20{i}.gluc;
    sim_ref_fruc{i} = simclamp20{i}.fruc;
    sim_ref_sucr{i} = simclamp20{i}.sucr;
    sim_ref_malt{i} = simclamp20{i}.malt;
end
close all
nref = 1;
% selSims = [1:8];
% selSims = [1,2]; % G6P, no improvement
% selSims = [1,3]; % F6P, no improvement
% selSims = [1,4]; % FBP: baselines do have some sensitivity, but still hard to improve for the fructose case.
% selSims = [1,5]; % DHAP: baselines do have some sensitivity, but still hard to improve for the fructose case. Bit worse than FBP.
% selSims = [1,6]; % GAP: baselines do have some sensitivity, but still hard to improve for the fructose case.
selSims = [1,7]; % threePG: just in LG
% selSims = [1,8]; % twoPG; just in lG
plot_all_loop

fh_fruct_clamp_threePG = figure(3);
fruct_twoPG_clamp_threePG.expdata.t = fh_fruct_clamp_threePG.Children(10).Children(2).XData;
fruct_twoPG_clamp_threePG.expdata.conc = fh_fruct_clamp_threePG.Children(10).Children(2).YData;
fruct_twoPG_clamp_threePG.simrefdata.t = fh_fruct_clamp_threePG.Children(10).Children(4).XData;
fruct_twoPG_clamp_threePG.simrefdata.conc = fh_fruct_clamp_threePG.Children(10).Children(4).YData;
fruct_twoPG_clamp_threePG.simclampdata.t = fh_fruct_clamp_threePG.Children(10).Children(3).XData;
fruct_twoPG_clamp_threePG.simclampdata.conc = fh_fruct_clamp_threePG.Children(10).Children(3).YData;


%% loop to extrat the data

% % % blanks
% % %
% % data4plot.fruc.sim.twoPG = cell(7,1);
% % data4plot.fruc.sim.threePG = cell(7,1);
% % data4plot.fruc.sim.GAP = cell(7,1);
% % data4plot.fruc.sim.DHAP = cell(7,1);
% % data4plot.fruc.sim.FBP = cell(7,1);
% % %
% % data4plot.sucr.sim.twoPG = cell(7,1);
% % data4plot.sucr.sim.threePG = cell(7,1);
% % data4plot.sucr.sim.GAP = cell(7,1);
% % data4plot.sucr.sim.DHAP = cell(7,1);
% % data4plot.sucr.sim.FBP = cell(7,1);
% % %
% % data4plot.malt.sim.twoPG = cell(7,1);
% % data4plot.malt.sim.threePG = cell(7,1);
% % data4plot.malt.sim.GAP = cell(7,1);
% % data4plot.malt.sim.DHAP = cell(7,1);
% % data4plot.malt.sim.FBP = cell(7,1);
% % % loop
% % for o = 1:7
% %     % plotting
% %     close all
% %     ref = 1;
% %     selSims = [1,o+1];
% %     plot_all_loop
% %     % extracting the data
% %     fh3 = figure(3);
% %     fh5 = figure(5);
% %     fh7 = figure(7);
% %     %
% %     if o == 1
% %         % % EXP
% %         % fruc
% %         data4plot.fruc.exp.threePG = fh3.Children(11).Children(2).YData;
% %         data4plot.fruc.exp.GAP = fh3.Children(12).Children(2).YData;
% %         data4plot.fruc.exp.DHAP = fh3.Children(13).Children(2).YData;
% %         data4plot.fruc.exp.FBP = fh3.Children(14).Children(2).YData;
% %         data4plot.fruc.exp.time = fh3.Children(14).Children(2).XData;
% %         % sucr 
% %         data4plot.sucr.exp.twoPG = fh5.Children(10).Children(2).YData;
% %         data4plot.sucr.exp.threePG = fh5.Children(11).Children(2).YData;
% %         data4plot.sucr.exp.GAP = fh5.Children(12).Children(2).YData;
% %         data4plot.sucr.exp.DHAP = fh5.Children(13).Children(2).YData;
% %         data4plot.sucr.exp.FBP = fh5.Children(14).Children(2).YData;
% %         data4plot.sucr.exp.time = fh5.Children(14).Children(2).XData;
% %         % 
% %         data4plot.malt.exp.twoPG = fh7.Children(10).Children(2).YData;
% %         data4plot.malt.exp.threePG = fh7.Children(11).Children(2).YData;
% %         data4plot.malt.exp.GAP = fh7.Children(12).Children(2).YData;
% %         data4plot.malt.exp.DHAP = fh7.Children(13).Children(2).YData;
% %         data4plot.malt.exp.FBP = fh7.Children(14).Children(2).YData;
% %         data4plot.malt.exp.time = fh7.Children(14).Children(2).XData;
% %         % % REF SIM
% %         % fruc
% %         data4plot.fruc.refsim.twoPG = interp1(fh3.Children(10).Children(4).XData, fh3.Children(10).Children(4).YData, data4plot.fruc.exp.time, 'spline');
% %         data4plot.fruc.refsim.threePG = interp1(fh3.Children(11).Children(4).XData, fh3.Children(11).Children(4).YData, data4plot.fruc.exp.time, 'spline');
% %         data4plot.fruc.refsim.GAP = interp1(fh3.Children(12).Children(4).XData, fh3.Children(12).Children(4).YData, data4plot.fruc.exp.time, 'spline');
% %         data4plot.fruc.refsim.DHAP = interp1(fh3.Children(13).Children(4).XData, fh3.Children(13).Children(4).YData, data4plot.fruc.exp.time, 'spline');
% %         data4plot.fruc.refsim.FBP = interp1(fh3.Children(14).Children(4).XData, fh3.Children(14).Children(4).YData, data4plot.fruc.exp.time, 'spline');
% %         %
% %         data4plot.sucr.refsim.twoPG = interp1(fh5.Children(10).Children(4).XData, fh5.Children(10).Children(4).YData, data4plot.sucr.exp.time, 'spline');
% %         data4plot.sucr.refsim.threePG = interp1(fh5.Children(11).Children(4).XData, fh5.Children(11).Children(4).YData, data4plot.sucr.exp.time, 'spline');
% %         data4plot.sucr.refsim.GAP = interp1(fh5.Children(12).Children(4).XData, fh5.Children(12).Children(4).YData, data4plot.sucr.exp.time, 'spline');
% %         data4plot.sucr.refsim.DHAP = interp1(fh5.Children(13).Children(4).XData, fh5.Children(13).Children(4).YData, data4plot.sucr.exp.time, 'spline');
% %         data4plot.sucr.refsim.FBP = interp1(fh5.Children(14).Children(4).XData, fh5.Children(14).Children(4).YData, data4plot.sucr.exp.time, 'spline');
% %         % 
% %         data4plot.malt.refsim.twoPG = interp1(fh7.Children(10).Children(4).XData, fh7.Children(10).Children(4).YData, data4plot.malt.exp.time, 'spline');
% %         data4plot.malt.refsim.threePG = interp1(fh7.Children(11).Children(4).XData, fh7.Children(11).Children(4).YData, data4plot.malt.exp.time, 'spline');
% %         data4plot.malt.refsim.GAP = interp1(fh7.Children(12).Children(4).XData, fh7.Children(12).Children(4).YData, data4plot.malt.exp.time, 'spline');
% %         data4plot.malt.refsim.DHAP = interp1(fh7.Children(13).Children(4).XData, fh7.Children(13).Children(4).YData, data4plot.malt.exp.time, 'spline');
% %         data4plot.malt.refsim.FBP = interp1(fh7.Children(14).Children(4).XData, fh7.Children(14).Children(4).YData, data4plot.malt.exp.time, 'spline');
% %     end
% %     % % SIM
% %     %
% %     temp_data4plot.fruc.sim.twoPG = interp1(fh3.Children(10).Children(3).XData, fh3.Children(10).Children(3).YData, data4plot.fruc.exp.time, 'spline');
% %     temp_data4plot.fruc.sim.threePG = interp1(fh3.Children(11).Children(3).XData, fh3.Children(11).Children(3).YData, data4plot.fruc.exp.time, 'spline');
% %     temp_data4plot.fruc.sim.GAP = interp1(fh3.Children(12).Children(3).XData, fh3.Children(12).Children(3).YData, data4plot.fruc.exp.time, 'spline');
% %     temp_data4plot.fruc.sim.DHAP = interp1(fh3.Children(13).Children(3).XData, fh3.Children(13).Children(3).YData, data4plot.fruc.exp.time, 'spline');
% %     temp_data4plot.fruc.sim.FBP = interp1(fh3.Children(14).Children(3).XData, fh3.Children(14).Children(3).YData, data4plot.fruc.exp.time, 'spline');
% %     %
% %     temp_data4plot.sucr.sim.twoPG = interp1(fh5.Children(10).Children(3).XData, fh5.Children(10).Children(3).YData, data4plot.sucr.exp.time, 'spline');
% %     temp_data4plot.sucr.sim.threePG = interp1(fh5.Children(11).Children(3).XData, fh5.Children(11).Children(3).YData, data4plot.sucr.exp.time, 'spline');
% %     temp_data4plot.sucr.sim.GAP = interp1(fh5.Children(12).Children(3).XData, fh5.Children(12).Children(3).YData, data4plot.sucr.exp.time, 'spline');
% %     temp_data4plot.sucr.sim.DHAP = interp1(fh5.Children(13).Children(3).XData, fh5.Children(13).Children(3).YData, data4plot.sucr.exp.time, 'spline');
% %     temp_data4plot.sucr.sim.FBP = interp1(fh5.Children(14).Children(3).XData, fh5.Children(14).Children(3).YData, data4plot.sucr.exp.time, 'spline');
% %     %
% %     temp_data4plot.malt.sim.twoPG = interp1(fh7.Children(10).Children(3).XData, fh7.Children(10).Children(3).YData, data4plot.malt.exp.time, 'spline');
% %     temp_data4plot.malt.sim.threePG = interp1(fh7.Children(11).Children(3).XData, fh7.Children(11).Children(3).YData, data4plot.malt.exp.time, 'spline');
% %     temp_data4plot.malt.sim.GAP = interp1(fh7.Children(12).Children(3).XData, fh7.Children(12).Children(3).YData, data4plot.malt.exp.time, 'spline');
% %     temp_data4plot.malt.sim.DHAP = interp1(fh7.Children(13).Children(3).XData, fh7.Children(13).Children(3).YData, data4plot.malt.exp.time, 'spline');
% %     temp_data4plot.malt.sim.FBP = interp1(fh7.Children(14).Children(3).XData, fh7.Children(14).Children(3).YData, data4plot.malt.exp.time, 'spline');
% %     % % properly locate SIM
% %     %
% %     data4plot.fruc.sim.twoPG{o} = temp_data4plot.fruc.sim.twoPG;
% %     data4plot.fruc.sim.threePG{o} = temp_data4plot.fruc.sim.threePG;
% %     data4plot.fruc.sim.GAP{o} = temp_data4plot.fruc.sim.GAP;
% %     data4plot.fruc.sim.DHAP{o} = temp_data4plot.fruc.sim.DHAP;
% %     data4plot.fruc.sim.FBP{o} = temp_data4plot.fruc.sim.FBP;
% %     %
% %     data4plot.sucr.sim.twoPG{o} = temp_data4plot.sucr.sim.twoPG;
% %     data4plot.sucr.sim.threePG{o} = temp_data4plot.sucr.sim.threePG;
% %     data4plot.sucr.sim.GAP{o} = temp_data4plot.sucr.sim.GAP;
% %     data4plot.sucr.sim.DHAP{o} = temp_data4plot.sucr.sim.DHAP;
% %     data4plot.sucr.sim.FBP{o} = temp_data4plot.sucr.sim.FBP;
% %     %
% %     data4plot.malt.sim.twoPG{o} = temp_data4plot.malt.sim.twoPG;
% %     data4plot.malt.sim.threePG{o} = temp_data4plot.malt.sim.threePG;
% %     data4plot.malt.sim.GAP{o} = temp_data4plot.malt.sim.GAP;
% %     data4plot.malt.sim.DHAP{o} = temp_data4plot.malt.sim.DHAP;
% %     data4plot.malt.sim.FBP{o} = temp_data4plot.malt.sim.FBP;
% % end
% % %%
% % % save('F7simData.mat','data4plot')
%%
load('F7simData.mat','data4plot')


%% calculate error: baselines
% 
err_base_fruc = zeros(6,4);
err_base_sucr = zeros(6,5);
err_base_malt = zeros(6,5);
% metNames
metNames_fruc = {'FBP', 'DHAP', 'GAP', 'threePG'};
metNames_sucr = {'FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
metNames_malt = {'FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
% clampNames
clampNames = {'reference','FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
for recalldata = 1
    for o = 1:5
        o2 = o + 1;
        o3 = o + 2;
        % fruc
        err_base_fruc(o2,1) = sum(abs(data4plot.fruc.exp.FBP(1) - data4plot.fruc.sim.FBP{o3}(1))); % FBP
        err_base_fruc(o2,2) = sum(abs(data4plot.fruc.exp.DHAP(1) - data4plot.fruc.sim.DHAP{o3}(1))); % DHAP
        err_base_fruc(o2,3) = sum(abs(data4plot.fruc.exp.GAP(1) - data4plot.fruc.sim.GAP{o3}(1))); % GAP
        err_base_fruc(o2,4) = sum(abs(data4plot.fruc.exp.threePG(1) - data4plot.fruc.sim.threePG{o3}(1))); % threePG
    %     err_base_fruc(o2,5) = sum(abs(data4plot.fruc.exp.twoPG(1) - data4plot.fruc.sim.twoPG{o3}(1))); % twoPG
        % sucr
        err_base_sucr(o2,1) = sum(abs(data4plot.sucr.exp.FBP(1) - data4plot.sucr.sim.FBP{o3}(1))); % FBP
        err_base_sucr(o2,2) = sum(abs(data4plot.sucr.exp.DHAP(1) - data4plot.sucr.sim.DHAP{o3}(1))); % DHAP
        err_base_sucr(o2,3) = sum(abs(data4plot.sucr.exp.GAP(1) - data4plot.sucr.sim.GAP{o3}(1))); % GAP
        err_base_sucr(o2,4) = sum(abs(data4plot.sucr.exp.threePG(1) - data4plot.sucr.sim.threePG{o3}(1))); % threePG
        err_base_sucr(o2,5) = sum(abs(data4plot.sucr.exp.twoPG(1) - data4plot.sucr.sim.twoPG{o3}(1))); % twoPG
        % malt
        err_base_malt(o2,1) = sum(abs(data4plot.malt.exp.FBP(1) - data4plot.malt.sim.FBP{o3}(1))); % FBP
        err_base_malt(o2,2) = sum(abs(data4plot.malt.exp.DHAP(1) - data4plot.malt.sim.DHAP{o3}(1))); % DHAP
        err_base_malt(o2,3) = sum(abs(data4plot.malt.exp.GAP(1) - data4plot.malt.sim.GAP{o3}(1))); % GAP
        err_base_malt(o2,4) = sum(abs(data4plot.malt.exp.threePG(1) - data4plot.malt.sim.threePG{o3}(1))); % threePG
        err_base_malt(o2,5) = sum(abs(data4plot.malt.exp.twoPG(1) - data4plot.malt.sim.twoPG{o3}(1))); % twoPG
    end
    % from the reference
    % fruc
    err_base_fruc(1,1) = sum(abs(data4plot.fruc.exp.FBP(1) - data4plot.fruc.refsim.FBP(1))); % FBP
    err_base_fruc(1,2) = sum(abs(data4plot.fruc.exp.DHAP(1) - data4plot.fruc.refsim.DHAP(1))); % DHAP
    err_base_fruc(1,3) = sum(abs(data4plot.fruc.exp.GAP(1) - data4plot.fruc.refsim.GAP(1))); % GAP
    err_base_fruc(1,4) = sum(abs(data4plot.fruc.exp.threePG(1) - data4plot.fruc.refsim.threePG(1))); % threePG
    %     err_base_fruc(1,5) = sum(abs(data4plot.fruc.exp.twoPG(1) - data4plot.fruc.refsim.twoPG(1))); % twoPG
    % sucr
    err_base_sucr(1,1) = sum(abs(data4plot.sucr.exp.FBP(1) - data4plot.sucr.refsim.FBP(1))); % FBP
    err_base_sucr(1,2) = sum(abs(data4plot.sucr.exp.DHAP(1) - data4plot.sucr.refsim.DHAP(1))); % DHAP
    err_base_sucr(1,3) = sum(abs(data4plot.sucr.exp.GAP(1) - data4plot.sucr.refsim.GAP(1))); % GAP
    err_base_sucr(1,4) = sum(abs(data4plot.sucr.exp.threePG(1) - data4plot.sucr.refsim.threePG(1))); % threePG
    err_base_sucr(1,5) = sum(abs(data4plot.sucr.exp.twoPG(1) - data4plot.sucr.refsim.twoPG(1))); % twoPG
    % malt
    err_base_malt(1,1) = sum(abs(data4plot.malt.exp.FBP(1) - data4plot.malt.refsim.FBP(1))); % FBP
    err_base_malt(1,2) = sum(abs(data4plot.malt.exp.DHAP(1) - data4plot.malt.refsim.DHAP(1))); % DHAP
    err_base_malt(1,3) = sum(abs(data4plot.malt.exp.GAP(1) - data4plot.malt.refsim.GAP(1))); % GAP
    err_base_malt(1,4) = sum(abs(data4plot.malt.exp.threePG(1) - data4plot.malt.refsim.threePG(1))); % threePG
    err_base_malt(1,5) = sum(abs(data4plot.malt.exp.twoPG(1) - data4plot.malt.refsim.twoPG(1))); % twoPG
    
    % %%
    err_base_fruc(2,1) = NaN;
    err_base_fruc(3,2) = NaN;
    err_base_fruc(4,3) = NaN;
    err_base_fruc(5,4) = NaN;
    % err_base_fruc(6,5) = NaN;
    %
    err_base_sucr(2,1) = NaN;
    err_base_sucr(3,2) = NaN;
    err_base_sucr(4,3) = NaN;
    err_base_sucr(5,4) = NaN;
    err_base_sucr(6,5) = NaN;
    %
    err_base_malt(2,1) = NaN;
    err_base_malt(3,2) = NaN;
    err_base_malt(4,3) = NaN;
    err_base_malt(5,4) = NaN;
    err_base_malt(6,5) = NaN;
end
% %% rescaling
for o = 1:5
    if o ~= 5
        err_base_fruc(:,o) = rescale(err_base_fruc(:,o));
    end
    err_base_sucr(:,o) = rescale(err_base_sucr(:,o));
    err_base_malt(:,o) = rescale(err_base_malt(:,o));
end


%% calculate error: full profile
% 
err_base_fruc2 = zeros(6,4);
err_base_sucr2 = zeros(6,5);
err_base_malt2 = zeros(6,5);
% metNames
metNames_fruc = {'FBP', 'DHAP', 'GAP', 'threePG'};
metNames_sucr = {'FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
metNames_malt = {'FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
% clampNames
clampNames = {'reference','FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
for recalldata = 1
    for o = 1:5
        o2 = o + 1;
        o3 = o + 2;
        % fruc
        err_base_fruc2(o2,1) = sum(abs(data4plot.fruc.exp.FBP(1:15) - data4plot.fruc.sim.FBP{o3}(1:15))); % FBP
        err_base_fruc2(o2,2) = sum(abs(data4plot.fruc.exp.DHAP(1:15) - data4plot.fruc.sim.DHAP{o3}(1:15))); % DHAP
        err_base_fruc2(o2,3) = sum(abs(data4plot.fruc.exp.GAP(1:15) - data4plot.fruc.sim.GAP{o3}(1:15))); % GAP
        err_base_fruc2(o2,4) = sum(abs(data4plot.fruc.exp.threePG(1:15) - data4plot.fruc.sim.threePG{o3}(1:15))); % threePG
    %     err_base_fruc2(o2,5) = sum(abs(data4plot.fruc.exp.twoPG(1:15) - data4plot.fruc.sim.twoPG{o3}(1:15))); % twoPG
        % sucr
        err_base_sucr2(o2,1) = sum(abs(data4plot.sucr.exp.FBP - data4plot.sucr.sim.FBP{o3})); % FBP
        err_base_sucr2(o2,2) = sum(abs(data4plot.sucr.exp.DHAP - data4plot.sucr.sim.DHAP{o3})); % DHAP
        err_base_sucr2(o2,3) = sum(abs(data4plot.sucr.exp.GAP - data4plot.sucr.sim.GAP{o3})); % GAP
        err_base_sucr2(o2,4) = sum(abs(data4plot.sucr.exp.threePG - data4plot.sucr.sim.threePG{o3})); % threePG
        err_base_sucr2(o2,5) = sum(abs(data4plot.sucr.exp.twoPG - data4plot.sucr.sim.twoPG{o3})); % twoPG
        % malt
        err_base_malt2(o2,1) = sum(abs(data4plot.malt.exp.FBP - data4plot.malt.sim.FBP{o3})); % FBP
        err_base_malt2(o2,2) = sum(abs(data4plot.malt.exp.DHAP - data4plot.malt.sim.DHAP{o3})); % DHAP
        err_base_malt2(o2,3) = sum(abs(data4plot.malt.exp.GAP - data4plot.malt.sim.GAP{o3})); % GAP
        err_base_malt2(o2,4) = sum(abs(data4plot.malt.exp.threePG - data4plot.malt.sim.threePG{o3})); % threePG
        err_base_malt2(o2,5) = sum(abs(data4plot.malt.exp.twoPG - data4plot.malt.sim.twoPG{o3})); % twoPG
    end
    % from the reference
    % fruc
    err_base_fruc2(1,1) = sum(abs(data4plot.fruc.exp.FBP(1:15) - data4plot.fruc.refsim.FBP(1:15))); % FBP
    err_base_fruc2(1,2) = sum(abs(data4plot.fruc.exp.DHAP(1:15) - data4plot.fruc.refsim.DHAP(1:15))); % DHAP
    err_base_fruc2(1,3) = sum(abs(data4plot.fruc.exp.GAP(1:15) - data4plot.fruc.refsim.GAP(1:15))); % GAP
    err_base_fruc2(1,4) = sum(abs(data4plot.fruc.exp.threePG(1:15) - data4plot.fruc.refsim.threePG(1:15))); % threePG
    %     err_base_fruc2(1,5) = sum(abs(data4plot.fruc.exp.twoPG(1:15) - data4plot.fruc.refsim.twoPG(1:15))); % twoPG
    % sucr
    err_base_sucr2(1,1) = sum(abs(data4plot.sucr.exp.FBP - data4plot.sucr.refsim.FBP)); % FBP
    err_base_sucr2(1,2) = sum(abs(data4plot.sucr.exp.DHAP - data4plot.sucr.refsim.DHAP)); % DHAP
    err_base_sucr2(1,3) = sum(abs(data4plot.sucr.exp.GAP - data4plot.sucr.refsim.GAP)); % GAP
    err_base_sucr2(1,4) = sum(abs(data4plot.sucr.exp.threePG - data4plot.sucr.refsim.threePG)); % threePG
    err_base_sucr2(1,5) = sum(abs(data4plot.sucr.exp.twoPG - data4plot.sucr.refsim.twoPG)); % twoPG
    % malt
    err_base_malt2(1,1) = sum(abs(data4plot.malt.exp.FBP - data4plot.malt.refsim.FBP)); % FBP
    err_base_malt2(1,2) = sum(abs(data4plot.malt.exp.DHAP - data4plot.malt.refsim.DHAP)); % DHAP
    err_base_malt2(1,3) = sum(abs(data4plot.malt.exp.GAP - data4plot.malt.refsim.GAP)); % GAP
    err_base_malt2(1,4) = sum(abs(data4plot.malt.exp.threePG - data4plot.malt.refsim.threePG)); % threePG
    err_base_malt2(1,5) = sum(abs(data4plot.malt.exp.twoPG - data4plot.malt.refsim.twoPG)); % twoPG
    
    % %%
    err_base_fruc2(2,1) = NaN;
    err_base_fruc2(3,2) = NaN;
    err_base_fruc2(4,3) = NaN;
    err_base_fruc2(5,4) = NaN;
    % err_base_fruc2(6,5) = NaN;
    %
    err_base_sucr2(2,1) = NaN;
    err_base_sucr2(3,2) = NaN;
    err_base_sucr2(4,3) = NaN;
    err_base_sucr2(5,4) = NaN;
    err_base_sucr2(6,5) = NaN;
    %
    err_base_malt2(2,1) = NaN;
    err_base_malt2(3,2) = NaN;
    err_base_malt2(4,3) = NaN;
    err_base_malt2(5,4) = NaN;
    err_base_malt2(6,5) = NaN;
end
% %% rescaling
for o = 1:5
    if o ~= 5
        err_base_fruc2(:,o) = rescale(err_base_fruc2(:,o));
    end
    err_base_sucr2(:,o) = rescale(err_base_sucr2(:,o));
    err_base_malt2(:,o) = rescale(err_base_malt2(:,o));
end

%% calculate error: splines
% 
err_base_fruc3 = zeros(6,4);
err_base_sucr3 = zeros(6,5);
err_base_malt3 = zeros(6,5);
% metNames
metNames_fruc = {'FBP', 'DHAP', 'GAP', 'threePG'};
metNames_sucr = {'FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
metNames_malt = {'FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
% clampNames
clampNames = {'reference','FBP', 'DHAP', 'GAP', 'threePG', 'twoPG'};
% csaps
xx = 1:10:400; 
psmooth = 0.0001;
for recalldata = 1
    for o = 1:5
        o2 = o + 1;
        o3 = o + 2;
        
        % fruc
        err_base_fruc3(o2,1) = sum(abs(csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.FBP(1:15),psmooth,xx) - csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.FBP{o3}(1:15),psmooth,xx))); % FBP
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.FBP{o3}(1:15),psmooth,xx)
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.FBP{o3}(1:15),psmooth,xx)
%         %
%         figure
%         xx = 1:10:400;
%         plot(xx,csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.GAP{o3}(1:15),psmooth,xx),...% plot(xx,spline(temp1_noNAN,temp2_noNAN,xx),'LineWidth',1.5,'Color',colGluc)
%             'LineWidth',3,'Color',colGluc)
%         hold on
%         plot(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.GAP{o3}(1:15),'ko')
        %
        err_base_fruc3(o2,2) = sum(abs(csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.DHAP(1:15),psmooth,xx) - csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.DHAP{o3}(1:15),psmooth,xx))); % DHAP
%         err_base_fruc3(o2,2) = sum(abs(data4plot.fruc.exp.DHAP(1:15) - data4plot.fruc.sim.DHAP{o3}(1:15))); % DHAP
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.DHAP{o3}(1:15),psmooth,xx)
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.DHAP{o3}(1:15),psmooth,xx)
        err_base_fruc3(o2,3) = sum(abs(csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.GAP(1:15),psmooth,xx)- csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.GAP{o3}(1:15),psmooth,xx))); % GAP
%         err_base_fruc3(o2,3) = sum(abs(data4plot.fruc.exp.GAP(1:15) - data4plot.fruc.sim.GAP{o3}(1:15))); % GAP
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.GAP{o3}(1:15),psmooth,xx)
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.GAP{o3}(1:15),psmooth,xx)
        err_base_fruc3(o2,4) = sum(abs(csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.threePG(1:15),psmooth,xx) - csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.threePG{o3}(1:15),psmooth,xx))); % threePG
%         err_base_fruc3(o2,4) = sum(abs(data4plot.fruc.exp.threePG(1:15) - data4plot.fruc.sim.threePG{o3}(1:15))); % threePG
    %     err_base_fruc3(o2,5) = sum(abs(data4plot.fruc.exp.twoPG(1:15) - data4plot.fruc.sim.twoPG{o3}(1:15))); % twoPG
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.exp.threePG{o3}(1:15),psmooth,xx)
%         csaps(data4plot.fruc.exp.time(1:15),data4plot.fruc.sim.threePG{o3}(1:15),psmooth,xx)
        % sucr
        err_base_sucr3(o2,1) = sum(abs(csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.FBP,psmooth,xx) - csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.FBP{o3},psmooth,xx))); % FBP
%         err_base_sucr3(o2,1) = sum(abs(data4plot.sucr.exp.FBP - data4plot.sucr.sim.FBP{o3})); % FBP
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.FBP{o3},psmooth,xx)
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.FBP{o3},psmooth,xx)
        err_base_sucr3(o2,2) = sum(abs(csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.DHAP,psmooth,xx) - csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.DHAP{o3},psmooth,xx))); % DHAP
%         err_base_sucr3(o2,2) = sum(abs(data4plot.sucr.exp.DHAP - data4plot.sucr.sim.DHAP{o3})); % DHAP
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.DHAP{o3},psmooth,xx)
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.DHAP{o3},psmooth,xx)
        err_base_sucr3(o2,3) = sum(abs(csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.GAP,psmooth,xx) - csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.GAP{o3},psmooth,xx))); % GAP
%         err_base_sucr3(o2,3) = sum(abs(data4plot.sucr.exp.GAP - data4plot.sucr.sim.GAP{o3})); % GAP
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.GAP{o3},psmooth,xx)
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.GAP{o3},psmooth,xx)
        err_base_sucr3(o2,4) = sum(abs(csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.threePG,psmooth,xx) - csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.threePG{o3},psmooth,xx))); % threePG
%         err_base_sucr3(o2,4) = sum(abs(data4plot.sucr.exp.threePG - data4plot.sucr.sim.threePG{o3})); % threePG
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.threePG{o3},psmooth,xx)
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.threePG{o3},psmooth,xx)
        err_base_sucr3(o2,5) = sum(abs(csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.twoPG,psmooth,xx) - csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.twoPG{o3},psmooth,xx))); % twoPG
%         err_base_sucr3(o2,5) = sum(abs(data4plot.sucr.exp.twoPG - data4plot.sucr.sim.twoPG{o3})); % twoPG
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.exp.twoPG{o3},psmooth,xx)
%         csaps(data4plot.sucr.exp.time,data4plot.sucr.sim.twoPG{o3},psmooth,xx)
        % malt
        err_base_malt3(o2,1) = sum(abs(csaps(data4plot.malt.exp.time,data4plot.malt.exp.FBP,psmooth,xx) - csaps(data4plot.malt.exp.time,data4plot.malt.sim.FBP{o3},psmooth,xx))); % FBP
%         err_base_malt3(o2,1) = sum(abs(data4plot.malt.exp.FBP - data4plot.malt.sim.FBP{o3})); % FBP
%         csaps(data4plot.malt.exp.time,data4plot.malt.exp.FBP{o3},psmooth,xx)
%         csaps(data4plot.malt.exp.time,data4plot.malt.sim.FBP{o3},psmooth,xx)
        err_base_malt3(o2,2) = sum(abs(csaps(data4plot.malt.exp.time,data4plot.malt.exp.DHAP,psmooth,xx) - csaps(data4plot.malt.exp.time,data4plot.malt.sim.DHAP{o3},psmooth,xx))); % DHAP
%         err_base_malt3(o2,2) = sum(abs(data4plot.malt.exp.DHAP - data4plot.malt.sim.DHAP{o3})); % DHAP
%         csaps(data4plot.malt.exp.time,data4plot.malt.exp.DHAP{o3},psmooth,xx)
%         csaps(data4plot.malt.exp.time,data4plot.malt.sim.DHAP{o3},psmooth,xx)
        err_base_malt3(o2,3) = sum(abs(csaps(data4plot.malt.exp.time,data4plot.malt.exp.GAP,psmooth,xx) - csaps(data4plot.malt.exp.time,data4plot.malt.sim.GAP{o3},psmooth,xx))); % GAP
%         err_base_malt3(o2,3) = sum(abs(data4plot.malt.exp.GAP - data4plot.malt.sim.GAP{o3})); % GAP
%         csaps(data4plot.malt.exp.time,data4plot.malt.exp.GAP{o3},psmooth,xx)
%         csaps(data4plot.malt.exp.time,data4plot.malt.sim.GAP{o3},psmooth,xx)
        err_base_malt3(o2,4) = sum(abs(csaps(data4plot.malt.exp.time,data4plot.malt.exp.threePG,psmooth,xx) - csaps(data4plot.malt.exp.time,data4plot.malt.sim.threePG{o3},psmooth,xx))); % threePG
%         err_base_malt3(o2,4) = sum(abs(data4plot.malt.exp.threePG - data4plot.malt.sim.threePG{o3})); % threePG
%         csaps(data4plot.malt.exp.time,data4plot.malt.exp.threePG{o3},psmooth,xx)
%         csaps(data4plot.malt.exp.time,data4plot.malt.sim.threePG{o3},psmooth,xx)
        err_base_malt3(o2,5) = sum(abs(csaps(data4plot.malt.exp.time,data4plot.malt.exp.twoPG,psmooth,xx) - csaps(data4plot.malt.exp.time,data4plot.malt.sim.twoPG{o3},psmooth,xx))); % twoPG
%         err_base_malt3(o2,5) = sum(abs(data4plot.malt.exp.twoPG - data4plot.malt.sim.twoPG{o3})); % twoPG
%         csaps(data4plot.malt.exp.time,data4plot.malt.exp.twoPG{o3},psmooth,xx)
%         csaps(data4plot.malt.exp.time,data4plot.malt.sim.twoPG{o3},psmooth,xx)
    end
% %     % from the reference
% %     % fruc
% %     err_base_fruc3(1,1) = sum(abs(data4plot.fruc.exp.FBP(1:15) - data4plot.fruc.refsim.FBP(1:15))); % FBP
% %     err_base_fruc3(1,2) = sum(abs(data4plot.fruc.exp.DHAP(1:15) - data4plot.fruc.refsim.DHAP(1:15))); % DHAP
% %     err_base_fruc3(1,3) = sum(abs(data4plot.fruc.exp.GAP(1:15) - data4plot.fruc.refsim.GAP(1:15))); % GAP
% %     err_base_fruc3(1,4) = sum(abs(data4plot.fruc.exp.threePG(1:15) - data4plot.fruc.refsim.threePG(1:15))); % threePG
% %     %     err_base_fruc3(1,5) = sum(abs(data4plot.fruc.exp.twoPG(1:15) - data4plot.fruc.refsim.twoPG(1:15))); % twoPG
% %     % sucr
% %     err_base_sucr3(1,1) = sum(abs(data4plot.sucr.exp.FBP - data4plot.sucr.refsim.FBP)); % FBP
% %     err_base_sucr3(1,2) = sum(abs(data4plot.sucr.exp.DHAP - data4plot.sucr.refsim.DHAP)); % DHAP
% %     err_base_sucr3(1,3) = sum(abs(data4plot.sucr.exp.GAP - data4plot.sucr.refsim.GAP)); % GAP
% %     err_base_sucr3(1,4) = sum(abs(data4plot.sucr.exp.threePG - data4plot.sucr.refsim.threePG)); % threePG
% %     err_base_sucr3(1,5) = sum(abs(data4plot.sucr.exp.twoPG - data4plot.sucr.refsim.twoPG)); % twoPG
% %     % malt
% %     err_base_malt3(1,1) = sum(abs(data4plot.malt.exp.FBP - data4plot.malt.refsim.FBP)); % FBP
% %     err_base_malt3(1,2) = sum(abs(data4plot.malt.exp.DHAP - data4plot.malt.refsim.DHAP)); % DHAP
% %     err_base_malt3(1,3) = sum(abs(data4plot.malt.exp.GAP - data4plot.malt.refsim.GAP)); % GAP
% %     err_base_malt3(1,4) = sum(abs(data4plot.malt.exp.threePG - data4plot.malt.refsim.threePG)); % threePG
% %     err_base_malt3(1,5) = sum(abs(data4plot.malt.exp.twoPG - data4plot.malt.refsim.twoPG)); % twoPG
    
    % %%
    err_base_fruc3(2,1) = NaN;
    err_base_fruc3(3,2) = NaN;
    err_base_fruc3(4,3) = NaN;
    err_base_fruc3(5,4) = NaN;
    % err_base_fruc3(6,5) = NaN;
    %
    err_base_sucr3(2,1) = NaN;
    err_base_sucr3(3,2) = NaN;
    err_base_sucr3(4,3) = NaN;
    err_base_sucr3(5,4) = NaN;
    err_base_sucr3(6,5) = NaN;
    %
    err_base_malt3(2,1) = NaN;
    err_base_malt3(3,2) = NaN;
    err_base_malt3(4,3) = NaN;
    err_base_malt3(5,4) = NaN;
    err_base_malt3(6,5) = NaN;
end
% %% rescaling
for o = 1:5
    if o ~= 5
        err_base_fruc3(:,o) = rescale(err_base_fruc3(:,o));
    end
    err_base_sucr3(:,o) = rescale(err_base_sucr3(:,o));
    err_base_malt3(:,o) = rescale(err_base_malt3(:,o));
end

%% plotting error: baselines
% figures
if exist('fh_700061','var')
    clf(fh_700061)
end
fh_700061 = figure(700061);
fh_700061.Position = [1970 573 1120 400];
% fh_700061.Position = [69 466 805 467];
% % % 
% % idxs_shift = [1,2, 5,6,7, 4,3, 8,9,10];
% % selError_fructose2 = selError_fructose(idxs_shift,:);
% % selError_sucrose2 = selError_sucrose(idxs_shift,:);
% % selError_maltose2 = selError_maltose(idxs_shift,:);
%  colormap
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
% 
sp1 = subplot(1,3,1); 
    hm1 = heatmap(metNames_fruc,clampNames,err_base_fruc,'CellLabelColor','none');
    hm1.Title = 'Fructose (dtp1)';
% %     caxis([0, 30]);
    hm1.Colormap(:,1) = linspace(0.9,0.850,256)';
    hm1.Colormap(:,2) = linspace(0.9447,0.325,256)';
    hm1.Colormap(:,3) = linspace(0.9741,0.098,256)';
sp2 = subplot(1,3,2); 
    hm2 = heatmap(metNames_sucr,clampNames,err_base_sucr,'CellLabelColor','none');
    hm2.Title = 'Sucrose (dtp1)';
% %     caxis([0, 30]);
    hm2.Colormap(:,1) = linspace(0.9,0.929,256)';
    hm2.Colormap(:,2) = linspace(0.9447,0.694,256)';
    hm2.Colormap(:,3) = linspace(0.9741,0.125,256)';
sp3 = subplot(1,3,3); 
    hm3 = heatmap(metNames_malt,clampNames,err_base_malt,'CellLabelColor','none');
    hm3.Title = 'Maltose (dtp1)';
% %     caxis([0, 30]);
    hm3.Colormap(:,1) = linspace(0.9,0.494,256)';
    hm3.Colormap(:,2) = linspace(0.9447,0.184,256)';
    hm3.Colormap(:,3) = linspace(0.9741,0.556,256)';


%% plotting error: splines
% figures
if exist('fh_700063','var')
    clf(fh_700063)
end
fh_700063 = figure(700063);
fh_700063.Position = [1990 573 1120 400];
% fh_700061.Position = [69 466 805 467];
% % % 
% % idxs_shift = [1,2, 5,6,7, 4,3, 8,9,10];
% % selError_fructose2 = selError_fructose(idxs_shift,:);
% % selError_sucrose2 = selError_sucrose(idxs_shift,:);
% % selError_maltose2 = selError_maltose(idxs_shift,:);
%  colormap
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
% 
sp1 = subplot(1,3,1); 
    hm1 = heatmap(metNames_fruc,clampNames,err_base_fruc3,'CellLabelColor','none');
    hm1.Title = 'Fructose (csaps)';
% %     caxis([0, 30]);
    hm1.Colormap(:,1) = linspace(0.9,0.850,256)';
    hm1.Colormap(:,2) = linspace(0.9447,0.325,256)';
    hm1.Colormap(:,3) = linspace(0.9741,0.098,256)';
sp2 = subplot(1,3,2); 
    hm2 = heatmap(metNames_sucr,clampNames,err_base_sucr3,'CellLabelColor','none');
    hm2.Title = 'Sucrose (csaps)';
% %     caxis([0, 30]);
    hm2.Colormap(:,1) = linspace(0.9,0.929,256)';
    hm2.Colormap(:,2) = linspace(0.9447,0.694,256)';
    hm2.Colormap(:,3) = linspace(0.9741,0.125,256)';
sp3 = subplot(1,3,3); 
    hm3 = heatmap(metNames_malt,clampNames,err_base_malt3,'CellLabelColor','none');
    hm3.Title = 'Maltose (csaps)';
% %     caxis([0, 30]);
    hm3.Colormap(:,1) = linspace(0.9,0.494,256)';
    hm3.Colormap(:,2) = linspace(0.9447,0.184,256)';
    hm3.Colormap(:,3) = linspace(0.9741,0.556,256)';


%% plotting error: full profile
% figures
if exist('fh_700062','var')
    clf(fh_700062)
end
fh_700062 = figure(700062);
fh_700062.Position = [1980 573 1120 400];
% fh_700061.Position = [69 466 805 467];
% % % 
% % idxs_shift = [1,2, 5,6,7, 4,3, 8,9,10];
% % selError_fructose2 = selError_fructose(idxs_shift,:);
% % selError_sucrose2 = selError_sucrose(idxs_shift,:);
% % selError_maltose2 = selError_maltose(idxs_shift,:);
%  colormap
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
% 
sp1 = subplot(1,3,1); 
    hm1 = heatmap(metNames_fruc,clampNames,err_base_fruc2,'CellLabelColor','none');
%     hm1.Title = 'Fructose (dtpAll)';
    hm1.Title = 'Fructose';
% %     caxis([0, 30]);
    hm1.Colormap(:,1) = linspace(0.9,0.850,256)';
    hm1.Colormap(:,2) = linspace(0.9447,0.325,256)';
    hm1.Colormap(:,3) = linspace(0.9741,0.098,256)';
    hm1.XLabel = 'Model Error (mM)';
    hm1.YLabel = 'Metabolite clamped';
sp2 = subplot(1,3,2); 
    hm2 = heatmap(metNames_sucr,clampNames,err_base_sucr2,'CellLabelColor','none');
%     hm2.Title = 'Sucrose (dtpAll)';
    hm2.Title = 'Sucrose';
% %     caxis([0, 30]);
    hm2.Colormap(:,1) = linspace(0.9,0.929,256)';
    hm2.Colormap(:,2) = linspace(0.9447,0.694,256)';
    hm2.Colormap(:,3) = linspace(0.9741,0.125,256)';
    hm2.XLabel = 'Model Error (mM)';
    hm2.YLabel = 'Metabolite clamped';
sp3 = subplot(1,3,3); 
    hm3 = heatmap(metNames_malt,clampNames,err_base_malt2,'CellLabelColor','none');
%     hm3.Title = 'Maltose (dtpAll)';
    hm3.Title = 'Maltose';
% %     caxis([0, 30]);
    hm3.Colormap(:,1) = linspace(0.9,0.494,256)';
    hm3.Colormap(:,2) = linspace(0.9447,0.184,256)';
    hm3.Colormap(:,3) = linspace(0.9741,0.556,256)';
    hm3.XLabel = 'Model Error (mM)';
    hm3.YLabel = 'Metabolite clamped';


%% 
% fh_fruct_clamp_threePG = figure(3);
% fruct_twoPG_clamp_threePG.expdata.t = fh_fruct_clamp_threePG.Children(10).Children(2).XData;
% fruct_twoPG_clamp_threePG.expdata.conc = fh_fruct_clamp_threePG.Children(10).Children(2).YData;
% fruct_twoPG_clamp_threePG.simrefdata.t = fh_fruct_clamp_threePG.Children(10).Children(4).XData;
% fruct_twoPG_clamp_threePG.simrefdata.conc = fh_fruct_clamp_threePG.Children(10).Children(4).YData;
% fruct_twoPG_clamp_threePG.simclampdata.t = fh_fruct_clamp_threePG.Children(10).Children(3).XData;
% fruct_twoPG_clamp_threePG.simclampdata.conc = fh_fruct_clamp_threePG.Children(10).Children(3).YData;

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


if exist('fh_700064','var')
    clf(fh_700064)
end
fh_700064 = figure(700064);
% fh_700064.Position = [1980 573 1120 400];
fh_700064.Position = [2946 386 315 269];
% 2PG
p1 = plot(fruct_twoPG_clamp_threePG.simrefdata.t,fruct_twoPG_clamp_threePG.simrefdata.conc,'-',...
    'LineWidth',1.5,'Color',[.7 .7 .7]);
hold on
p2 = plot(fruct_twoPG_clamp_threePG.simclampdata.t,fruct_twoPG_clamp_threePG.simclampdata.conc,'-',...
    'LineWidth',1.5,'Color','black');
p3 = plot(fruct_twoPG_clamp_threePG.expdata.t,fruct_twoPG_clamp_threePG.expdata.conc,'o',...
    'MarkerSize',5,'Color',colFruc_dark,'MarkerFaceColor',colFruc);
ylim([0 0.6])
xlabel('Time (s)')
ylabel('2PG Concentration (mM)')
legend([p1 p2 p3], 'unclamped model', 'clamped 3PG concentration', 'experimental data',...
    'Location','SouthEast')


% % % % % %% saving plots
% % % % % 
% % % % % %% save current figure
% % % % % % print(fh_700062,'-dpdf','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Bdata');
% % % % % print(fh_700062,'-dtiff','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Bdata');
% % % % % savefig(fh_700062,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Bdata');
% % % % % % 
% % % % % set(fh_700062,'Units','Inches');
% % % % % pos = get(fh_700062,'Position');
% % % % % set(fh_700062,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% % % % % print(fh_700062,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Bdata','-dpdf','-r0')
% % % % % 
% % % % % %% save current figure
% % % % % % print(fh_700064,'-dpdf','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Adata');
% % % % % print(fh_700064,'-dtiff','E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Adata');
% % % % % savefig(fh_700064,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Adata');
% % % % % % 
% % % % % set(fh_700064,'Units','Inches');
% % % % % pos = get(fh_700064,'Position');
% % % % % set(fh_700064,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
% % % % % print(fh_700064,'E:\OneDrive - TU Eindhoven\Documents\ch6_sugars\toolbox_sugars\workContinuation_sugars\manuscript\F7Adata','-dpdf','-r0')

