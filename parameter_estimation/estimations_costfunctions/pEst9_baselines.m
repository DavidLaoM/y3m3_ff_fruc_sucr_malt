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

% simulation 
x = x_gapdh;
% % plotflag = 0; 
% % simulate_all
% % plotflag = 0;
% % 
% % % 
% % simref9.gluc = selResCellFF01{1};
% % simref9.fruc = selResCellFF01Fruc{1};
% % simref9.sucr = selResCellFF01Sucr{1};
% % simref9.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % 
% % simclamp20 = cell(7,1);
% % 
% % % G6P 
% % setup.clamp20.G6P = 1;
% % setup.clamp20.F6P = 0;
% % setup.clamp20.FBP = 0;
% % setup.clamp20.DHAP = 0;
% % setup.clamp20.GAP = 0;
% % setup.clamp20.threePG = 0;
% % setup.clamp20.twoPG = 0;
% % % 
% % simulate_all
% % simclamp20{1}.gluc = selResCellFF01{1};
% % simclamp20{1}.fruc = selResCellFF01Fruc{1};
% % simclamp20{1}.sucr = selResCellFF01Sucr{1};
% % simclamp20{1}.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % F6P 
% % setup.clamp20.G6P = 0;
% % setup.clamp20.F6P = 1;
% % setup.clamp20.FBP = 0;
% % setup.clamp20.DHAP = 0;
% % setup.clamp20.GAP = 0;
% % setup.clamp20.threePG = 0;
% % setup.clamp20.twoPG = 0;
% % % 
% % simulate_all
% % simclamp20{2}.gluc = selResCellFF01{1};
% % simclamp20{2}.fruc = selResCellFF01Fruc{1};
% % simclamp20{2}.sucr = selResCellFF01Sucr{1};
% % simclamp20{2}.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % FBP 
% % setup.clamp20.G6P = 0;
% % setup.clamp20.F6P = 0;
% % setup.clamp20.FBP = 1;
% % setup.clamp20.DHAP = 0;
% % setup.clamp20.GAP = 0;
% % setup.clamp20.threePG = 0;
% % setup.clamp20.twoPG = 0;
% % % 
% % simulate_all
% % simclamp20{3}.gluc = selResCellFF01{1};
% % simclamp20{3}.fruc = selResCellFF01Fruc{1};
% % simclamp20{3}.sucr = selResCellFF01Sucr{1};
% % simclamp20{3}.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % DHAP 
% % setup.clamp20.G6P = 0;
% % setup.clamp20.F6P = 0;
% % setup.clamp20.FBP = 0;
% % setup.clamp20.DHAP = 1;
% % setup.clamp20.GAP = 0;
% % setup.clamp20.threePG = 0;
% % setup.clamp20.twoPG = 0;
% % % 
% % simulate_all
% % simclamp20{4}.gluc = selResCellFF01{1};
% % simclamp20{4}.fruc = selResCellFF01Fruc{1};
% % simclamp20{4}.sucr = selResCellFF01Sucr{1};
% % simclamp20{4}.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % GAP 
% % setup.clamp20.G6P = 0;
% % setup.clamp20.F6P = 0;
% % setup.clamp20.FBP = 0;
% % setup.clamp20.DHAP = 0;
% % setup.clamp20.GAP = 1;
% % setup.clamp20.threePG = 0;
% % setup.clamp20.twoPG = 0;
% % % 
% % simulate_all
% % simclamp20{5}.gluc = selResCellFF01{1};
% % simclamp20{5}.fruc = selResCellFF01Fruc{1};
% % simclamp20{5}.sucr = selResCellFF01Sucr{1};
% % simclamp20{5}.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % threePG 
% % setup.clamp20.G6P = 0;
% % setup.clamp20.F6P = 0;
% % setup.clamp20.FBP = 0;
% % setup.clamp20.DHAP = 0;
% % setup.clamp20.GAP = 0;
% % setup.clamp20.threePG = 1;
% % setup.clamp20.twoPG = 0;
% % % 
% % simulate_all
% % simclamp20{6}.gluc = selResCellFF01{1};
% % simclamp20{6}.fruc = selResCellFF01Fruc{1};
% % simclamp20{6}.sucr = selResCellFF01Sucr{1};
% % simclamp20{6}.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % twoPG 
% % setup.clamp20.G6P = 0;
% % setup.clamp20.F6P = 0;
% % setup.clamp20.FBP = 0;
% % setup.clamp20.DHAP = 0;
% % setup.clamp20.GAP = 0;
% % setup.clamp20.threePG = 0;
% % setup.clamp20.twoPG = 1;
% % % 
% % simulate_all
% % simclamp20{7}.gluc = selResCellFF01{1};
% % simclamp20{7}.fruc = selResCellFF01Fruc{1};
% % simclamp20{7}.sucr = selResCellFF01Sucr{1};
% % simclamp20{7}.malt = selResCellFF01Malt{1};
% % clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% % 
% % % 
% % save('pE9_sims_safecopy.mat','simref9','simclamp20')


%%  
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
% selSims = [1,7]; % threePG: just in LG
selSims = [1,8]; % twoPG; just in lG
plot_all_loop





