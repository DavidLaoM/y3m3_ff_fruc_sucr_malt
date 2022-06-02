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
% load('x1_initial.mat','x1BSucr','x1AFruct')
% x = x1BSucr;
load('x_Y3M3_2.mat','x_Y3M3_2')
x = x_Y3M3_2;
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
saveNames{1} = 'pE6_ref_gapdh_lam1.mat';
saveNames{2} = 'pE6_ref_gapdh_lam2.mat';
saveNames{3} = 'pE6_ref_gapdh_lam3.mat';
saveNames{4} = 'pE6_ref_gapdh_lam4.mat';
saveNames{5} = 'pE6_ref_gapdh_lam5.mat';
saveNames{6} = 'pE6_ref_gapdh_lam6.mat';
saveNames{7} = 'pE6_ref_gapdh_lam7.mat';
saveNames{8} = 'pE6_ref_gapdh_lam8.mat';
saveNames{9} = 'pE6_ref_gapdh_lam9.mat';
saveNames{10} = 'pE6_ref_gapdh_lam10.mat';
% case 2. gapdh
saveNames{11} = 'pE6_gapdh_lam1.mat';
saveNames{12} = 'pE6_gapdh_lam2.mat';
saveNames{13} = 'pE6_gapdh_lam3.mat';
saveNames{14} = 'pE6_gapdh_lam4.mat';
saveNames{15} = 'pE6_gapdh_lam5.mat';
saveNames{16} = 'pE6_gapdh_lam6.mat';
saveNames{17} = 'pE6_gapdh_lam7.mat';
saveNames{18} = 'pE6_gapdh_lam8.mat';
saveNames{19} = 'pE6_gapdh_lam9.mat';
saveNames{20} = 'pE6_gapdh_lam10.mat';

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
lambdalist = [1E-2 2E-2 5E-2 1E-1 3E-1 2E-1 5E-1 1E0 2E0 5E0,...
              1E-2 2E-2 5E-2 1E-1 3E-1 2E-1 5E-1 1E0 2E0 5E0];


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
%     x = x_Y3M3_2; x(selPars) = xres;
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
nS = 20;
for i = 1:nS
    selPars = parCombs{i};
    if i == 1
        xres = [-0.6351   -2.0515   -1.7499   -0.3833    0.2063    0.5972    1.0723,...
           -0.9987    0.5251   -0.9790   -0.4417   -0.3899   -2.2160    1.9746,...
           -1.3476   -0.4593    0.8159   -0.2272   -2.5092    2.0363    0.0167,...
            1.2723   -2.9900    0.5194   -3.1886   -2.2366   -0.9932    0.9899,...
            0.3648    2.7942   -0.5192   -0.5364    0.1949    0.1099];
    elseif i == 2
        xres = [-0.6253   -2.0460   -1.7533   -0.3848    0.2222    0.6003    1.0651,...
           -1.0013    0.5369   -0.9691   -0.4630   -0.4256   -2.2749    1.9923,...
           -1.3692   -0.4911    0.8432   -0.2491   -2.5008    2.0291    0.0060,...
            1.2572   -3.0083    0.5408   -3.2077   -2.2395   -0.9728    1.0102,...
            0.3690    2.7932   -0.5099   -0.5588    0.1945    0.1269];
    elseif i == 3
        xres = [-0.6173   -2.0422   -1.7530   -0.3880    0.2296    0.6003    1.0608,...
           -1.0046    0.5426   -0.9686   -0.4671   -0.4374   -2.3008    1.9932,...
           -1.3800   -0.5022    0.8493   -0.2498   -2.5007    2.0287    0.0053,...
            1.2566   -3.0092    0.5413   -3.2087   -2.2396   -0.9613    1.0140,...
            0.3694    2.7934   -0.5040   -0.5647    0.1940    0.1335];
    elseif i == 4
        xres = [-0.6154   -2.0415   -1.7529   -0.3886    0.2309    0.6003    1.0601,...
           -1.0052    0.5436   -0.9685   -0.4677   -0.4394   -2.3052    1.9933,...
           -1.3818   -0.5042    0.8505   -0.2499   -2.5007    2.0287    0.0052,...
            1.2566   -3.0093    0.5414   -3.2088   -2.2396   -0.9593    1.0146,...
            0.3695    2.7934   -0.5030   -0.5657    0.1940    0.1347];
    elseif i == 5
        xres = [-0.6271   -2.0478   -1.7526   -0.3861    0.2224    0.5991    1.0644,...
           -1.0024    0.5369   -0.9694   -0.4608   -0.4238   -2.2748    1.9925,...
           -1.3675   -0.4900    0.8409   -0.2494   -2.4998    2.0276    0.0080,...
            1.2590   -3.0058    0.5405   -3.2050   -2.2380   -0.9709    1.0075,...
            0.3679    2.7909   -0.5091   -0.5568    0.1966    0.1271];
    elseif i == 6
        xres = [-0.6211   -2.0440   -1.7530   -0.3869    0.2269    0.6002    1.0623,...
           -1.0034    0.5405   -0.9688   -0.4654   -0.4329   -2.2915    1.9931,...
           -1.3759   -0.4980    0.8468   -0.2498   -2.5008    2.0286    0.0057,...
            1.2571   -3.0087    0.5412   -3.2082   -2.2394   -0.9653    1.0123,...
            0.3691    2.7931   -0.5061   -0.5622    0.1945    0.1311];
    elseif i == 7
        xres = [-0.6224   -2.0448   -1.7526   -0.3868    0.2258    0.5997    1.0626,...
           -1.0029    0.5396   -0.9683   -0.4643   -0.4303   -2.2873    1.9929,...
           -1.3740   -0.4962    0.8452   -0.2497   -2.4993    2.0275    0.0059,...
            1.2565   -3.0068    0.5409   -3.2061   -2.2383   -0.9663    1.0108,...
            0.3687    2.7915   -0.5067   -0.5606    0.1946    0.1301];
    elseif i == 8
        xres = [-0.6620   -2.0712   -1.6647   -0.4277    0.1737    0.5549    1.0444,...
           -0.9868    0.5234   -0.9124   -0.4342   -0.3377   -2.0822    1.9683,...
           -1.3156   -0.4435    0.7999   -0.2311   -2.3640    1.9152    0.0184,...
            1.1938   -2.8312    0.5033   -3.0202   -2.1523   -0.9921    0.9313,...
            0.3592    2.6386   -0.5429   -0.4855    0.1895    0.0991];
    elseif i == 9
        xres = [-0.7328   -1.8603   -0.4969   -0.5928    0.0591    0.1233    0.1437,...
           -0.6392    0.3807   -0.1937   -0.1136    0.1585   -1.6952    1.6621,...
           -2.1339   -1.3797    0.9653   -0.0231   -0.4104    0.3124    0.0114,...
            0.1821   -0.4615    0.4591   -0.8551   -0.6997   -0.5416    0.3064,...
            0.4166    0.1952   -0.8857   -0.0240   -0.2469    0.0467];
    elseif i == 10
        xres = [-0.6895   -1.5166    0.0018   -0.3501    0.2948    0.0652   -0.0750,...
           -0.4697    0.4989   -0.0360   -0.1768    0.4183   -2.3413    1.6208,...
           -2.6955   -2.3144    1.0809   -0.0000   -0.0009    0.0010   -0.1850,...
            0.1838   -0.0006    0.0368   -0.0392    0.0610   -0.1053    0.0082,...
            0.3911    0.0781   -0.6469    0.2936   -0.2898    0.0616];
    elseif i == 11
        xres = [0.9229    0.5335    2.1355   -0.5430   -0.3401    0.2348    0.3240];
    elseif i == 12
        xres = [1.3047    0.4717    2.3058   -0.6424   -0.4965    0.1785    0.2524];
    elseif i == 13
        xres = [1.0209    0.5211    2.2401   -0.6472   -0.3287    0.2269    0.3077];
    elseif i == 14
        xres = [0.9535    0.5366    2.1526   -0.6299   -0.3685    0.2189    0.3224];
    elseif i == 15
        xres = [0.0967    0.8649    0.4583   -0.5971    0.2100    0.1204    0.6331];
    elseif i == 16
        xres = [0.5471    0.6505    1.7256   -0.4642   -0.1391    0.2421    0.4464];
    elseif i == 17
        xres = [-0.0183    0.9293    0.1325   -0.4040    0.2759   -0.0843    0.6749];
    elseif i == 18
        xres = [0.0163    0.7864    0.1312   -0.4150    0.2767   -0.2537    0.5164];
    elseif i == 19
        xres = [-0.0138    0.5539    0.0067   -0.3851    0.2789   -0.2653    0.2898];
    elseif i == 20
        xres = [-0.0140    0.3929    0.0082   -0.3877    0.2791   -0.2681    0.1713];
    end
    x2 = x;
    x2(selPars) = xres;
    xAll = [xAll; x2];
end
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% 
% 
% % sim results
% sims_gluc = {};
% sims_fruc = {};
% sims_sucr = {};
% sims_malt = {};
% for i = 1:nS
%     x = xAll(i,:);
%     simulate_all
%     sims_gluc = [sims_gluc, selResCellFF01];
%     sims_fruc = [sims_fruc, selResCellFF01Fruc];
%     sims_sucr = [sims_sucr, selResCellFF01Sucr];
%     sims_malt = [sims_malt, selResCellFF01Malt];
% end
% 
% % sim ref
% x = x_Y3M3_2;
% simulate_all
% sim_ref_gluc = selResCellFF01;
% sim_ref_fruc = selResCellFF01Fruc;
% sim_ref_sucr = selResCellFF01Sucr;
% sim_ref_malt = selResCellFF01Malt;
% 
% %
% save('pE6_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
%     "sims_gluc","sims_fruc","sims_sucr","sims_malt")
% sims_gluc = sims_gluc';
% sims_fruc = sims_fruc';
% sims_sucr = sims_sucr';
% sims_malt = sims_malt';
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% 
% 
% % here we will have to simulate first
% error_cell = {};
% error_gluc_cell = {};
% error_fruc_cell = {};
% error_sucr_cell = {};
% error_malt_cell = {};
% for i = 1:nS
%     disp(i)
%     % simulate
%     w = warray{i};
%     lambda = 0;
%     selPars = parCombs{i};
%     x_temp = xAll(i,selPars);
%     setup.x_reg = xref(selPars);
%     [error,error_gluc,error_fruc,error_sucr,error_malt] = costfun_FF01_all_recall_error(x_temp,setup,x,plotflag,selPars,lambda,w);
%     % recall
%     error_cell = [error_cell; error];
%     error_gluc_cell = [error_gluc_cell; error_gluc];
%     error_fruc_cell = [error_fruc_cell; error_fruc];
%     error_sucr_cell = [error_sucr_cell; error_sucr];
%     error_malt_cell = [error_malt_cell; error_malt];
% end
% % simulate the reference case
% selPars = 1;
% x_temp = x(selPars);
% [error_ref,error_gluc_ref,error_fruc_ref,error_sucr_ref,error_malt_ref] = costfun_FF01_all_recall_error(x_temp,setup,x,plotflag,selPars,lambda,w);
% 
% %
% save('pE6_sims_safecopy_withErrors.mat',...
%     "error_ref","error_gluc_ref","error_fruc_ref","error_sucr_ref","error_malt_ref",...
%     "error_cell","error_gluc_cell","error_fruc_cell","error_sucr_cell","error_malt_cell")
% 
% 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

%%
load('pE6_sims_safecopy.mat',"sim_ref_gluc","sim_ref_fruc","sim_ref_sucr","sim_ref_malt",...
    "sims_gluc","sims_fruc","sims_sucr","sims_malt")
sims_gluc = sims_gluc';
sims_fruc = sims_fruc';
sims_sucr = sims_sucr';
sims_malt = sims_malt';

%% simulation visualization
% nS = 32;
% sims_gluc = [sims_gluc; selResCellFF01];
% sims_fruc = [sims_fruc; selResCellFF01Fruc];
% sims_sucr = [sims_sucr; selResCellFF01Sucr];
% sims_malt = [sims_malt; selResCellFF01Malt];
% nSims = 32+1;
close all
nref = 21;
% selSims = [1,21]; % manual
% selSims = [1:10,21]; % pE6_ref_gapdh
% selSims = [11:20,21]; % pE6_gapdh
% selSims = [8:9,21]; % pE6_ref_gapdh, manual
selSims = [17:19,21]; % pE6_gapdh, manual
% % selSims = 19; % pE6_gapdh, manual
plot_all_loop
% plot_all

% % fh3 = figure(3);
% % fh5 = figure(5);
% % fh7 = figure(7);
% % savefig(fh3,'pE6_fructose.fig')
% % savefig(fh5,'pE6_sucrose.fig')
% % savefig(fh7,'pE6_maltose.fig')

%% examine. Taking the 3rd case as an example
% clf(4001)
fh4001 = figure(4001);
% fh4001.Position = [111 367 1608 534];
fh4001.Position = [111 105 1608 840];
%
subplot(2,3,[1 2])
plot(1:34,xref(parSet4),'o-',"Color",[.7 .7 .7],"MarkerFaceColor",[.7 .7 .7],"MarkerEdgeColor",[.7 .7 .7])
hold on
plot(1:34,xAll(1,parSet4),'o-',"Color",'k',"MarkerFaceColor",'w',"MarkerEdgeColor",'k')
hold on
plot(1:34,xAll(9,parSet4),'o-',"Color",'k',"MarkerFaceColor",'k',"MarkerEdgeColor",'k')
xticks(1:34)
xticklabels(parSet4)
xlim([0 35])
ylim([-3 3])
title('estimation ref + gapdh: focus all')
%
subplot(2,3,3)
plot(1:7,xref(parSet5),'o-',"Color",[.7 .7 .7],"MarkerFaceColor",[.7 .7 .7],"MarkerEdgeColor",[.7 .7 .7])
hold on
plot(1:7,xAll(1,parSet5),'o-',"Color",'k',"MarkerFaceColor",'w',"MarkerEdgeColor",'k')
hold on
plot(1:7,xAll(9,parSet5),'o-',"Color",'k',"MarkerFaceColor",'k',"MarkerEdgeColor",'k')
xticks(1:7)
xticklabels(parSet5)
xlim([0 8])
ylim([-3 3])
title('estimation ref + gapdh: focus gapdh')
%
subplot(2,3,6)
plot(1:7,xref(parSet5),'o-',"Color",[.7 .7 .7],"MarkerFaceColor",[.7 .7 .7],"MarkerEdgeColor",[.7 .7 .7])
hold on
plot(1:7,xAll(11,parSet5),'o-',"Color",'k',"MarkerFaceColor",'w',"MarkerEdgeColor",'k')
hold on
plot(1:7,xAll(19,parSet5),'o-',"Color",'k',"MarkerFaceColor",'k',"MarkerEdgeColor",'k')
xticks(1:7)
xticklabels(parSet5)
xlim([0 8])
ylim([-3 3])
title('estimation gapdh')


%% save resulting case
x_Y3M3_3 = xAll(19,:);
save('x_Y3M3_3.mat','x_Y3M3_3')

