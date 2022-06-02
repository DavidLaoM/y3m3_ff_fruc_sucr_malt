% % RUN_SIMULATIONS.M
% 
selResCell = cell(1,nSims);
% parfor i = 1:nSims
% fprintf("FF cycle simulation %d in progress \n",i);
[T_1,Y_1,V_1] = simulate_FF(x,canelas_SS,data,dataset,setup,NumberCycles,plotflag,IC);
% for  error
T_2 = T_1;
Y_2 = Y_1;
V_2 = V_1;
% for plotting
[selResCell{1}] = SetOutput(plotMode,T_1,Y_1,V_1);
% end

% 
SetLegend;
if((plotflag == 10)||(plotflag == 11))
    referencePlotSimulations;
end