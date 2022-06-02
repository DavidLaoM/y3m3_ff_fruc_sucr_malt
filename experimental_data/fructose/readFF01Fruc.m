%% readFF01Fruc (Hugo Cloudt, 7-10-2021)
% Function to load the data of the FF01Fruc experiment (FF experiment conducted in
% the same way as FF01, but with fructose as substrate) from Excel into MATLAB
% 
% Input:
% z = mL intracellular volume/g cell dry weight
%
% Output:
% dataFF01Fruc = data of the FF01Fruc experiment

function [dataFF01Fruc] = readFF01Fruc(z)
    
    % Loading FF01Fruc data from its Excel file
%     FF01FrucMetsData = readmatrix('FF01Fruc_data_for_project_HugoCloudt','Range','A10:DX25');
%     FF01FrucMetsData_ss = readmatrix('FF01Fruc_data_for_project_HugoCloudt','Range','A9:DX9');
%     MetNames = readmatrix('FF01Fruc_data_for_project_HugoCloudt','Range','A7:DX7','OutputType','string');
    load("FF01FrucMetsData.mat","FF01FrucMetsData")
    load("FF01FrucMetsData_ss.mat","FF01FrucMetsData_ss")
    load("MetNames_fructose.mat","MetNames")

    % Construct a structure with the loaded FF01Fruc data
    dataFF01Fruc = struct();
    dataFF01Fruc.metabolites = struct();
    dataFF01Fruc.metabolites_ss = struct();
    dataFF01Fruc.legenda_mets = {};
    dataFF01Fruc.fluxes = {};
    dataFF01Fruc.legenda_fluxes = {};
    
    NumberOfECmets = 5;    % Number of extracellular metabolites measured in the experiment
    
    iter = 0; % Initialise iteration counter
    
    for i = 1:4:size(FF01FrucMetsData,2)
        
        iter = iter + 1;
        
        MetName = MetNames(i);
        dataFF01Fruc.legenda_mets{iter,1} = MetName;
        
        Met = FF01FrucMetsData(:,i:i+3);
        
        if i <= NumberOfECmets*4
            dataFF01Fruc.metabolites.(MetName).time = Met(:,1);
            dataFF01Fruc.metabolites.(MetName).conc = Met(:,2)/1000;
            dataFF01Fruc.metabolites.(MetName).stdev = Met(:,3)/1000;
            dataFF01Fruc.metabolites.(MetName).sterr = Met(:,4)/1000;
        else
            dataFF01Fruc.metabolites.(MetName).time = Met(:,1);
            dataFF01Fruc.metabolites.(MetName).conc = (Met(:,2)/1000)*(1/(z*1e-3));
            dataFF01Fruc.metabolites.(MetName).stdev = (Met(:,3)/1000)*(1/(z*1e-3));
            dataFF01Fruc.metabolites.(MetName).sterr = (Met(:,4)/1000)*(1/(z*1e-3));
        end
        
    end
    
    iter = 0; % Initialise iteration counter
    
    for i = 1:4:size(FF01FrucMetsData_ss,2)
        
        iter = iter + 1;
        
        MetName = MetNames(i);
        dataFF01Fruc.legenda_mets{iter,1} = MetName;
        
        Met_ss = FF01FrucMetsData_ss(:,i:i+3);
        
        if i <= NumberOfECmets*4
            dataFF01Fruc.metabolites_ss.(MetName).time = "ss";
            dataFF01Fruc.metabolites_ss.(MetName).conc = Met_ss(:,2)/1000;
            dataFF01Fruc.metabolites_ss.(MetName).stdev = Met_ss(:,3)/1000;
            dataFF01Fruc.metabolites_ss.(MetName).sterr = Met_ss(:,4)/1000;
        else
            dataFF01Fruc.metabolites_ss.(MetName).time = "ss";
            dataFF01Fruc.metabolites_ss.(MetName).conc = (Met_ss(:,2)/1000)*(1/(z*1e-3));
            dataFF01Fruc.metabolites_ss.(MetName).stdev = (Met_ss(:,3)/1000)*(1/(z*1e-3));
            dataFF01Fruc.metabolites_ss.(MetName).sterr = (Met_ss(:,4)/1000)*(1/(z*1e-3));
        end
        
    end
    
    dataFF01Fruc.time_ICmets = dataFF01Fruc.metabolites.Glc_ic.time;
    dataFF01Fruc.time_ECmets = dataFF01Fruc.metabolites.Glc_ec.time;
    dataFF01Fruc.time_fluxes = [];
    
end