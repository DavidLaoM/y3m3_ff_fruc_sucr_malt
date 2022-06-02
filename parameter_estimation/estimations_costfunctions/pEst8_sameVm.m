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
plotflag = 11; 
simulate_all
plotflag = 0;

% 
simref.gluc = selResCellFF01{1};
simref.fruc = selResCellFF01Fruc{1};
simref.sucr = selResCellFF01Sucr{1};
simref.malt = selResCellFF01Malt{1};


%% Parameters to adjust
% % 
% p.GLT.VmGLT=0.2*10.^x(36).*3.67;                                                              x(36) = -0.6154;
% p.FRT.VmFRT=0.2*10.^x(169).*3.67;                                                             x(169) = 0.2309;
% % 
% p.HXK1_kcatglc=0.2*10.^x(34).*4.75; % s-1 (Van Eunen et al., 2012)                            x(34) = 0.8505
% p.HXK1_kcatfrc=0.2*10.^x(175).*4.75.*2; % s-1 (Lobo & Maitra, 1977; Teusink et al., 2000)     x(175) = 1.2566
xHXTvm_array = [-0.6154 -0.6 -0.4 -0.2 0 0.2 0.2309];
xHKvm_array = [0.8505 0.9 0.95 1 1.05 1.10 1.15 1.20 1.25 1.2566];
% 
nHXT = length(xHXTvm_array);
nHK = length(xHKvm_array);
% % % 
% % simref.HXTchange = cell(1,nHXT);
% % for o = 1:nHXT
% %     clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% %     % parameters
% %     x = x_gapdh;
% %     x(36) = xHXTvm_array(o);
% %     x(169) = xHXTvm_array(o);
% %     % simulation
% %     simulate_all
% %     % saving
% %     simref.HXTchange{o}.gluc = selResCellFF01{1};
% %     simref.HXTchange{o}.fruc = selResCellFF01Fruc{1};
% %     simref.HXTchange{o}.sucr = selResCellFF01Sucr{1};
% %     simref.HXTchange{o}.malt = selResCellFF01Malt{1};
% % end
% % %
% % simref.HKchange = cell(1,nHK);
% % for o = 1:nHK
% %     clear selResCellFF01 selResCellFF01Fruc selResCellFF01Sucr selResCellFF01Malt
% %     % parameters
% %     x = x_gapdh;
% %     x(34) = xHKvm_array(o);
% %     x(175) = xHKvm_array(o);
% %     % simulation
% %     simulate_all
% %     % saving
% %     simref.HKchange{o}.gluc = selResCellFF01{1};
% %     simref.HKchange{o}.fruc = selResCellFF01Fruc{1};
% %     simref.HKchange{o}.sucr = selResCellFF01Sucr{1};
% %     simref.HKchange{o}.malt = selResCellFF01Malt{1};
% % end
% % % 
% % x = x_gapdh;
% % % saving
% % save('pE8_sims_safecopy.mat','simref')


%% analysis
load('pE8_sims_safecopy.mat','simref')


%% for HXTchange
% 
sims_gluc = cell(1,1); sims_gluc{1} = simref.gluc;
sims_fruc = cell(1,1); sims_fruc{1} = simref.fruc;
sims_sucr = cell(1,1); sims_sucr{1} = simref.sucr;
sims_malt = cell(1,1); sims_malt{1} = simref.malt;
% 
sim_ref_gluc = cell(nHXT,1);
sim_ref_fruc = cell(nHXT,1);
sim_ref_sucr = cell(nHXT,1);
sim_ref_malt = cell(nHXT,1);
for i = 1:nHXT
    sim_ref_gluc{i} = simref.HXTchange{i}.gluc;
    sim_ref_fruc{i} = simref.HXTchange{i}.fruc;
    sim_ref_sucr{i} = simref.HXTchange{i}.sucr;
    sim_ref_malt{i} = simref.HXTchange{i}.malt;
end
close all
nref = 1;
selSims = [1:nHXT,nref];
plot_all_loop


%% for HKchange
sim_ref_gluc = cell(nHK,1);
sim_ref_fruc = cell(nHK,1);
sim_ref_sucr = cell(nHK,1);
sim_ref_malt = cell(nHK,1);
for i = 1:nHK
    sim_ref_gluc{i} = simref.HKchange{i}.gluc;
    sim_ref_fruc{i} = simref.HKchange{i}.fruc;
    sim_ref_sucr{i} = simref.HKchange{i}.sucr;
    sim_ref_malt{i} = simref.HKchange{i}.malt;
end
close all
nref = 1;
selSims = [1:nHK,nref];
plot_all_loop


%% va
% x(34)
% x(175)
close all
% simulation 
x = x_gapdh;
    x([34 175]) = ones;
plotflag = 11; 
simulate_all
plotflag = 0;


%% saving the new parameter set
% 
x_Y3M3_5  =x;
save('x_Y3M3_5.mat','x_Y3M3_5')


