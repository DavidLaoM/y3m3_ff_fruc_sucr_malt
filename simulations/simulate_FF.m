function [T,Y,V] = simulate_FF(x,canelas,data,dataset,setup,n, plotflag, IC0)

% recall labels
[legenda] = legendaFull; %legenda for the names needed
metNames = legenda.metabolites;
FluxNames = legenda.fluxes;

% preprocessing
d = 0.1; % silution rate
PvHoek_EnzymeExpressionData; % protein levels
setParameterStructure_Y3M1; % sets paraemter values based on the x-array
IC = IC0; % useful for later
tspan= [0:1:20000]; % time to reach SS
f.GLCo = IC(36); % adjusted to specific FF regime
f.FRCo = IC(34); % adjusted to specific FF regime

% clamping options
if setup.clamp.Pi == 1 % clamp Pi
    IC(27)     = 10; %PI
end
if setup.clamp.TRE == 1 % trehalose
    if setup.GPdataset.GP400WT        == 1
        IC(25)     = dataset.FF01.metabolites.ICtreh.conc(1); %TRE
        IC(26)     = dataset.FF01.metabolites.ICT6P.conc(1); %T6P
        IC(21)     = dataset.FF01.metabolites.ICG1P.conc(1);%G1P
    elseif setup.GPdataset.GP1800WT   == 1
        IC(25)     = dataset.FF03.metabolites.ICtreh.conc(1); %TRE
        IC(26)     = dataset.FF03.metabolites.ICT6P.conc(1); %T6P
        IC(21)     = dataset.FF03.metabolites.ICG1P.conc(1);%G1P
    elseif setup.GPdataset.GP400M     == 1
        IC(25)     = dataset.FF04.metabolites.ICtreh.conc(1); %TRE
        IC(26)     = dataset.FF04.metabolites.ICT6P.conc(1); %T6P
        IC(21)     = dataset.FF04.metabolites.ICG1P.conc(1);%G1P
    end
end
if setup.clamp.NADX == 1 % NADX
    disp('No data for NADX is provided in the CA suarez datasets. Clamped to values in the IC(...).m file');
end
if setup.clamp.AXP == 1 % AXP
    if setup.GPdataset.GP400WT        == 1
        IC(9)     = dataset.FF01.metabolites.ICATP.conc(1); %ATP
        IC(15)    = dataset.FF01.metabolites.ICADP.conc(1); %ADP
        IC(16)    = dataset.FF01.metabolites.ICAMP.conc(1); %AMP
    elseif setup.GPdataset.GP1800WT   == 1
        IC(9)     = dataset.FF03.metabolites.ICATP.conc(1); %ATP
        IC(15)    = dataset.FF03.metabolites.ICADP.conc(1); %ADP
        IC(16)    = dataset.FF03.metabolites.ICAMP.conc(1); %AMP
    elseif setup.GPdataset.GP400M     == 1
        IC(9)     = dataset.FF04.metabolites.ICATP.conc(1); %ATP
        IC(15)    = dataset.FF04.metabolites.ICADP.conc(1); %ADP
        IC(16)    = dataset.FF04.metabolites.ICAMP.conc(1); %AMP
    end
end
if setup.clamp.IXP == 1 % IXP
   IC(28)    = 0; 
   IC(29)    = 0; 
   IC(30)    = 0; 
end

% simulation 1. Simulation until SS @ growth rate 0.1 h^{-1}, ic2ss0
setup.stage = 1; % needed for optional clamping
options=odeset('RelTol',1e-4,'RelTol',1e-4 ,'NonNegative',ones(1,37));
[T_ic2ss,Y_ic2ss] = ode15s(@ODE_model_Y3M1_FFsims,tspan,IC,options,p,f,d,setup, dataset);

% Reaction rates calculation (still ongoing)
Y = Y_ic2ss;
calcFluxes_consensus_Y3M1;
V_ic2ss = v;
T0 = T_ic2ss(1);
Tt = T_ic2ss(end);

% option for intermediate plots
if plotflag == 1
    % metabolite concentrations
    figure(1)
    for i = 1:38
        if (Y_ic2ss(end,i) >= 0.95*IC0(i)) &&   (Y_ic2ss(end,i) <= 1.05*IC0(i))
            col = 'g-';
        else
            col = 'r.-';
        end
        subplot(7,6,i)
        plot(T_ic2ss, Y_ic2ss(:,i), 'k', 'LineWidth', 1.5); hold on
        plot([T0 Tt], [IC0(i) IC0(i)], 'r.-')
        title(metNames{i})
    end
    sgtitle('Concentrations chemostat')
    fig = gcf;
    set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
    % reaction rates
    figure(2)
    for i = 1:48
        subplot(7,7,i)
        plot(T_ic2ss, V_ic2ss(:,i))
        title(FluxNames{i})
    end
    sgtitle('Fluxes chemostat') 
    fig = gcf;
    set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
    % reaction rates
    figure(3)
    for i = 1:38
        subplot(7,6,i)
        plot(T_ic2ss, v_met(:,i), 'k', 'LineWidth', 1.5); hold on
        if abs(v_met(end,i)) <= 1e-6
            col = 'g-';
        else
            col = 'r.-';
        end
        plot([T0 Tt], [0 0], col)
        title(metNames{i})
    end
    sgtitle('Metabolite fluxes chemostat')
    fig = gcf;
    set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
end

% setup for first GP and FF simulations
if setup.GPdataset.GP400WT        == 1 % time profile
    tspan = [0:1:400];
elseif setup.GPdataset.GP1800WT 	== 1
    tspan = [0:1:1800];
elseif setup.GPdataset.GP400M     == 1
    tspan = [0:1:400];
elseif setup.GPdataset.Fruc     == 1
    tspan = [0:1:400];
elseif setup.GPdataset.Sucr     == 1
    tspan = [0:1:400];
elseif setup.GPdataset.Malt     == 1
    tspan = [0:1:400];
end

% clamps
if setup.GPdataset.GP400WT        == 1
    setup.clamp.Pi_GSvalues         = 10; % PI
    setup.clamp.UDP_GLC_GPvalues    = interp1(dataset.FF01.time_mets,dataset.FF01.metabolites.ICUDPG.conc,tspan,'pchip','extrap');% UDP_glc
    setup.clamp.treh_GPvalues       = interp1(dataset.FF01.time_mets,dataset.FF01.metabolites.ICtreh.conc,tspan,'pchip','extrap');% TRE
    setup.clamp.T6P_GPvalues        = interp1(dataset.FF01.time_mets,dataset.FF01.metabolites.ICT6P.conc,tspan,'pchip','extrap');% T6P
    setup.clamp.G1P_GPvalues        = interp1(dataset.FF01.time_mets,dataset.FF01.metabolites.ICG1P.conc,tspan,'pchip','extrap');% G1P
    setup.clamp.ATP_GPvalues        = interp1(dataset.FF01.time_mets,dataset.FF01.metabolites.ICATP.conc,tspan,'pchip','extrap');% ATP
    setup.clamp.ADP_GPvalues        = interp1(dataset.FF01.time_mets,dataset.FF01.metabolites.ICADP.conc,tspan,'pchip','extrap');% ADP
    setup.clamp.AMP_GPvalues        = interp1(dataset.FF01.time_mets,dataset.FF01.metabolites.ICAMP.conc,tspan,'pchip','extrap');% AMP
elseif setup.GPdataset.GP1800WT   == 1
    setup.clamp.Pi_GSvalues         = 10;
    setup.clamp.UDP_GLC_GPvalues    = interp1(dataset.FF03.time_mets,dataset.FF03.metabolites.ICUDPG.conc,tspan,'pchip','extrap');% UDP_glc
    setup.clamp.treh_GPvalues       = interp1(dataset.FF03.time_mets,dataset.FF03.metabolites.ICtreh.conc,tspan,'pchip','extrap');% TRE
    setup.clamp.T6P_GPvalues        = interp1(dataset.FF03.time_mets,dataset.FF03.metabolites.ICT6P.conc,tspan,'pchip','extrap');% T6P
    setup.clamp.G1P_GPvalues        = interp1(dataset.FF03.time_mets,dataset.FF03.metabolites.ICG1P.conc,tspan,'pchip','extrap');% G1P
    setup.clamp.ATP_GPvalues        = interp1(dataset.FF03.time_mets,dataset.FF03.metabolites.ICATP.conc,tspan,'pchip','extrap');% ATP
    setup.clamp.ADP_GPvalues        = interp1(dataset.FF03.time_mets,dataset.FF03.metabolites.ICADP.conc,tspan,'pchip','extrap');% ADP
    setup.clamp.AMP_GPvalues        = interp1(dataset.FF03.time_mets,dataset.FF03.metabolites.ICAMP.conc,tspan,'pchip','extrap');% AMP
elseif setup.GPdataset.GP400M     == 1
    setup.clamp.Pi_GSvalues         = 10;
    setup.clamp.UDP_GLC_GPvalues    = interp1(dataset.FF04.time_mets,dataset.FF04.metabolites.ICUDPG.conc,tspan,'pchip','extrap');% UDP_glc
    setup.clamp.treh_GPvalues       = interp1(dataset.FF04.time_mets,dataset.FF04.metabolites.ICtreh.conc,tspan,'pchip','extrap');% TRE
    setup.clamp.T6P_GPvalues        = interp1(dataset.FF04.time_mets,dataset.FF04.metabolites.ICT6P.conc,tspan,'pchip','extrap');% T6P
    setup.clamp.G1P_GPvalues        = interp1(dataset.FF04.time_mets,dataset.FF04.metabolites.ICG1P.conc,tspan,'pchip','extrap');% G1P
    setup.clamp.ATP_GPvalues        = interp1(dataset.FF04.time_mets,dataset.FF04.metabolites.ICATP.conc,tspan,'pchip','extrap');% ATP
    setup.clamp.ADP_GPvalues        = interp1(dataset.FF04.time_mets,dataset.FF04.metabolites.ICADP.conc,tspan,'pchip','extrap');% ADP
    setup.clamp.AMP_GPvalues        = interp1(dataset.FF04.time_mets,dataset.FF04.metabolites.ICAMP.conc,tspan,'pchip','extrap');% AMP
end
setup.tspan = tspan;

% first GP simulation. ss02gs. GS 100 mM GLCo, 340 s, 0.1 h-1.
% (This might be unnecessary for now. But checking that the model does not
% reach some unexpected state)
setup.stage = 2;
IC = IC0; 
IC = IC';
[T_gp,Y_gp] = ode15s(@ODE_model_Y3M1_FFsims,tspan,IC,options,p,f,d,setup, dataset);

% calculate reaction rates
T = T_gp;
Y = Y_gp; 
calcFluxes_consensus_Y3M1;

% option to clamp concentrations
if setup.clamp.TRE == 1 % trehalose
    Y_gp(:,21) = setup.clamp.G1P_GPvalues;      % G1P       21
    Y_gp(:,24) = setup.clamp.UDP_GLC_GPvalues;  % UDP_Glc   24
    Y_gp(:,26) = setup.clamp.T6P_GPvalues;      % Tre6P     26
    Y_gp(:,25) = setup.clamp.treh_GPvalues;      % Tre       25    
end
if setup.clamp.AXP == 1 % axp
    Y_gp(:,9)  = setup.clamp.ATP_GPvalues;      % ATP       9
    Y_gp(:,15) = setup.clamp.ADP_GPvalues;      % ADP       15
    Y_gp(:,16) = setup.clamp.AMP_GPvalues;      % AMP       16
end
% option to clamp reaction rates
if setup.clamp.TRE == 1 % trehalose
    if setup.GPdataset.GP400WT        == 1
        v(:,17)  = interp1(dataset.FF01.fluxes_times, dataset.FF01.fluxes{39} - dataset.FF01.fluxes{40}, T_gp, 'pchip', 'extrap'); %v_PGM1; 39-40
        v(:,19)  = interp1(dataset.FF01.fluxes_times, dataset.FF01.fluxes{12} - dataset.FF01.fluxes{13}, T_gp, 'pchip', 'extrap'); %v_TPS2; 12 - 13
        v(:,20)  = interp1(dataset.FF01.fluxes_times, dataset.FF01.fluxes{14},                           T_gp, 'pchip', 'extrap'); %v_NTH1; 14
        v(:,21)  = interp1(dataset.FF01.fluxes_times, dataset.FF01.fluxes{11},                           T_gp, 'pchip', 'extrap'); %v_TPS1; 11
        v(:,18)  = interp1(dataset.FF01.fluxes_times, dataset.FF01.fluxes{41},                           T_gp, 'pchip', 'extrap'); %v_UGP; 41
    elseif setup.GPdataset.GP1800WT 	== 1
        v(:,17)  = interp1(dataset.FF03.fluxes_times, dataset.FF03.fluxes{39} - dataset.FF03.fluxes{40}, T_gp, 'pchip', 'extrap'); %v_PGM1; 39-40
        v(:,19)  = interp1(dataset.FF03.fluxes_times, dataset.FF03.fluxes{12} - dataset.FF03.fluxes{13}, T_gp, 'pchip', 'extrap'); %v_TPS2; 12 - 13
        v(:,20)  = interp1(dataset.FF03.fluxes_times, dataset.FF03.fluxes{14},                           T_gp, 'pchip', 'extrap'); %v_NTH1; 14
        v(:,21)  = interp1(dataset.FF03.fluxes_times, dataset.FF03.fluxes{11},                           T_gp, 'pchip', 'extrap'); %v_TPS1; 11
        v(:,18)  = interp1(dataset.FF01.fluxes_times, dataset.FF01.fluxes{41},                           T_gp, 'pchip', 'extrap'); %v_UGP; 41
    elseif setup.GPdataset.GP400M     == 1
        v(:,17)  = 0; %v_PGM1; 39-40
        v(:,19)  = 0; %v_TPS2; 12 - 13
        v(:,20)  = 0; %v_NTH1; 14
        v(:,21)  = 0; % v_TPS1
    end
end

% Feast famine cycle simulations
T_gp = [];
Y_gp = [];
t0 = 0;
IC = IC0; IC = IC'; %IC = Y_ic2ss(end,:);
for xx = 1:(n-1)
    tic
    [T,Y] = ode15s(@ODE_model_Y3M1_FFsims,tspan,IC,options,p,f,d,setup, dataset );
    temp = toc;
    T_gp = [T_gp; T + t0];
    Y_gp = [Y_gp; Y]; 
    t0 = t0 + T(end);
    IC = Y(end,:);
end
[T,Y] = ode15s(@ODE_model_Y3M1_FFsims,[0 400],IC,options,p,f,d,setup,dataset);
T_gp = [T_gp; T + t0];
Y_gp = [Y_gp; Y]; 
t0 = t0 + T(end);
IC = Y(end,:);


UDP_GLC_exp = interp1(dataset.FF01.metabolites.ICUDPG.time,dataset.FF01.metabolites.ICUDPG.conc,T,'pchip','extrap');

% calculate fluxes
calcFluxes_consensus_Y3M1;
V_gp = v;

% option for intermediate plots
if plotflag == 1
    figure()
    for i = 1:38
        subplot(7,6,i)
        plot(T_gp, Y_gp(:,i))
        title(metNames{i})
    end
    fig = gcf;
    set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
    saveas(fig,'FFallCycles.jpg')
    close
        
    figure()
    jfirst = (find(T_gp <= 2000)); 
    for i = 1:38
        subplot(7,6,i)
        plot(T_gp(jfirst), Y_gp(jfirst,i))
        title(metNames{i})
    end
    suptitle('First 5 cycles')
    fig = gcf;
    set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
    saveas(fig,'First5.jpg')
    close
    calcFluxes_consensus_Y3M1;
    
    figure()
    plot(T_gp, Y_gp(:,39))
    title('Reactor volume')
    fig = gcf;
    set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
    saveas(fig,'Volume.jpg')
    close
elseif plotflag == 2
    % 
    figure
    plot(itVars_time,'.-','markersize',2)
    title('time per iteration')
    %
    [~,temp_m] = size(itVars_mets);
    figure
    for o = 1:temp_m
        subplot(6,7,o)
        plot(itVars_mets(:,o),'.-','markersize',2)
        title(sprintf('met.num.%d',o))
    end
end

% Prepare output
V = V_gp;

end
