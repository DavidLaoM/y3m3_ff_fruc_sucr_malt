% % F0_reference_simulations
% This code reproduces the simulations of the FF cycles for fructose,
% sucrose and maltose.

% select parameter set
load('x_Y3M3_3.mat','x_Y3M3_3')
x = x_Y3M3_3;

% simulation 
plotflag = 11; % 11 = Plot all results after simulations, 0 = no plots, 1 = plot concentrations and fluxes during each FF cycle, 2 = plot concentrations and fluxes after each cycle
simulate_all
plotflag = 0;

