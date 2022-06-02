%% readFF01Sucr (Hugo Cloudt, 19-10-2021)
% Function to load the data of the FF01Sucr experiment (FF experiment conducted in
% the same way as FF01, but with sucrose as substrate) from Excel into MATLAB
% 
% Input:
% z = mL intracellular volume/g cell dry weight
%
% Output:
% dataFF01Sucr = data of the FF01Sucr experiment

function [dataFF01Sucr] = readFF01Sucr(z)
    
    % Loading FF01Sucr data from its Excel file
%     FF01SucrMetsData = readmatrix('FF01Sucr_data_for_project_HugoCloudt','Range','A10:DX26');
%     FF01SucrMetsData_ss = readmatrix('FF01Sucr_data_for_project_HugoCloudt','Range','A9:DX9');
%     MetNames = readmatrix('FF01Sucr_data_for_project_HugoCloudt','Range','A7:DX7','OutputType','string');
    load("FF01SucrMetsData.mat","FF01SucrMetsData")
    load("FF01SucrMetsData_ss.mat","FF01SucrMetsData_ss")
    load("MetNames_sucrose.mat","MetNames")
    
    % Construct a structure with the loaded FF01Sucr data
    dataFF01Sucr = struct();
    dataFF01Sucr.metabolites = struct();
    dataFF01Sucr.metabolites_ss = struct();
    dataFF01Sucr.legenda_mets = {};
    dataFF01Sucr.fluxes = {};
    dataFF01Sucr.legenda_fluxes = {};
    
    NumberOfECmets = 5;    % Number of extracellular metabolites measured in the experiment
    
    iter = 0; % Initialise iteration counter
    
    for i = 1:4:size(FF01SucrMetsData,2)
        
        iter = iter + 1;
        
        MetName = MetNames(i);
        dataFF01Sucr.legenda_mets{iter,1} = MetName;
        
        Met = FF01SucrMetsData(:,i:i+3);
        
        if i <= NumberOfECmets*4
            dataFF01Sucr.metabolites.(MetName).time = Met(:,1);
            dataFF01Sucr.metabolites.(MetName).conc = Met(:,2)/1000;
            dataFF01Sucr.metabolites.(MetName).stdev = Met(:,3)/1000;
            dataFF01Sucr.metabolites.(MetName).sterr = Met(:,4)/1000;
        else
            dataFF01Sucr.metabolites.(MetName).time = Met(:,1);
            dataFF01Sucr.metabolites.(MetName).conc = (Met(:,2)/1000)*(1/(z*1e-3));
            dataFF01Sucr.metabolites.(MetName).stdev = (Met(:,3)/1000)*(1/(z*1e-3));
            dataFF01Sucr.metabolites.(MetName).sterr = (Met(:,4)/1000)*(1/(z*1e-3));
        end
        
    end
    
    iter = 0; % Initialise iteration counter
    
    for i = 1:4:size(FF01SucrMetsData_ss,2)
        
        iter = iter + 1;
        
        MetName = MetNames(i);
        dataFF01Sucr.legenda_mets{iter,1} = MetName;
        
        Met_ss = FF01SucrMetsData_ss(:,i:i+3);
        
        if i <= NumberOfECmets*4
            dataFF01Sucr.metabolites_ss.(MetName).time = "ss";
            dataFF01Sucr.metabolites_ss.(MetName).conc = Met_ss(:,2)/1000;
            dataFF01Sucr.metabolites_ss.(MetName).stdev = Met_ss(:,3)/1000;
            dataFF01Sucr.metabolites_ss.(MetName).sterr = Met_ss(:,4)/1000;
        else
            dataFF01Sucr.metabolites_ss.(MetName).time = "ss";
            dataFF01Sucr.metabolites_ss.(MetName).conc = (Met_ss(:,2)/1000)*(1/(z*1e-3));
            dataFF01Sucr.metabolites_ss.(MetName).stdev = (Met_ss(:,3)/1000)*(1/(z*1e-3));
            dataFF01Sucr.metabolites_ss.(MetName).sterr = (Met_ss(:,4)/1000)*(1/(z*1e-3));
        end
        
    end
    
    dataFF01Sucr.time_ICmets = dataFF01Sucr.metabolites.Glc_ic.time;
    dataFF01Sucr.time_ECmets = dataFF01Sucr.metabolites.Glc_ec.time;
    dataFF01Sucr.time_fluxes = [];
    
end