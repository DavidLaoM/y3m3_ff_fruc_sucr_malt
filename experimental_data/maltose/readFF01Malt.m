%% readFF01Malt (Hugo Cloudt, 22-12-2021)
% Function to load the data of the FF01Malt experiment (FF experiment conducted in
% the same way as FF01, but with maltose as substrate) from Excel into MATLAB
% 
% Input:
% z = mL intracellular volume/g cell dry weight
%
% Output:
% dataFF01Malt = data of the FF01Malt experiment

function [dataFF01Malt] = readFF01Malt(z)
    
    % Loading FF01Malt data from its Excel file
%     FF01MaltMetsData = readmatrix('FF01Malt_data_for_project_HugoCloudt','Range','A10:DX26');
%     FF01MaltMetsData_ss = readmatrix('FF01Malt_data_for_project_HugoCloudt','Range','A9:DX9');
%     MetNames = readmatrix('FF01Malt_data_for_project_HugoCloudt','Range','A7:DX7','OutputType','string');
    load("FF01MaltMetsData.mat","FF01MaltMetsData")
    load("FF01MaltMetsData_ss.mat","FF01MaltMetsData_ss")
    load("MetNames_maltose.mat","MetNames")

    % Construct a structure with the loaded FF01Malt data
    dataFF01Malt = struct();
    dataFF01Malt.metabolites = struct();
    dataFF01Malt.metabolites_ss = struct();
    dataFF01Malt.legenda_mets = {};
    dataFF01Malt.fluxes = {};
    dataFF01Malt.legenda_fluxes = {};
    
    NumberOfECmets = 5;    % Number of extracellular metabolites measured in the experiment
    
    iter = 0; % Initialise iteration counter
    
    for i = 1:4:size(FF01MaltMetsData,2)
        
        iter = iter + 1;
        
        MetName = MetNames(i);
        dataFF01Malt.legenda_mets{iter,1} = MetName;
        
        Met = FF01MaltMetsData(:,i:i+3);
        
        if i <= NumberOfECmets*4
            dataFF01Malt.metabolites.(MetName).time = Met(:,1);
            dataFF01Malt.metabolites.(MetName).conc = Met(:,2)/1000;
            dataFF01Malt.metabolites.(MetName).stdev = Met(:,3)/1000;
            dataFF01Malt.metabolites.(MetName).sterr = Met(:,4)/1000;
        else
            dataFF01Malt.metabolites.(MetName).time = Met(:,1);
            dataFF01Malt.metabolites.(MetName).conc = (Met(:,2)/1000)*(1/(z*1e-3));
            dataFF01Malt.metabolites.(MetName).stdev = (Met(:,3)/1000)*(1/(z*1e-3));
            dataFF01Malt.metabolites.(MetName).sterr = (Met(:,4)/1000)*(1/(z*1e-3));
        end
        
    end
    
    iter = 0; % Initialise iteration counter
    
    for i = 1:4:size(FF01MaltMetsData_ss,2)
        
        iter = iter + 1;
        
        MetName = MetNames(i);
        dataFF01Malt.legenda_mets{iter,1} = MetName;
        
        Met_ss = FF01MaltMetsData_ss(:,i:i+3);
        
        if i <= NumberOfECmets*4
            dataFF01Malt.metabolites_ss.(MetName).time = "ss";
            dataFF01Malt.metabolites_ss.(MetName).conc = Met_ss(:,2)/1000;
            dataFF01Malt.metabolites_ss.(MetName).stdev = Met_ss(:,3)/1000;
            dataFF01Malt.metabolites_ss.(MetName).sterr = Met_ss(:,4)/1000;
        else
            dataFF01Malt.metabolites_ss.(MetName).time = "ss";
            dataFF01Malt.metabolites_ss.(MetName).conc = (Met_ss(:,2)/1000)*(1/(z*1e-3));
            dataFF01Malt.metabolites_ss.(MetName).stdev = (Met_ss(:,3)/1000)*(1/(z*1e-3));
            dataFF01Malt.metabolites_ss.(MetName).sterr = (Met_ss(:,4)/1000)*(1/(z*1e-3));
        end
        
    end
    
    dataFF01Malt.time_ICmets = dataFF01Malt.metabolites.Glc_ic.time;
    dataFF01Malt.time_ECmets = dataFF01Malt.metabolites.Glc_ec.time;
    dataFF01Malt.time_fluxes = [];

end