%% read_ssdataFF01 (Hugo Cloudt, 29-11-2021)
% Function to load the steady state (ss) data of the FF01 experiment
% from Excel into MATLAB
% Input:
% z = mL intracellular volume/g cell dry weight
%
% Output:
% ssdataFF01 = steady state measurements during the FF01 experiment

function [ssdataFF01] = read_ssdataFF01(z)
    
    % Loading ss data FF01 from its Excel file
%     FF01MetsData_ss = readmatrix('FF01_ssdata_for_project_HugoCloudt','Range','A8:DX8','Sheet',"Rearranged by HC");
%     MetNames = readmatrix('FF01_ssdata_for_project_HugoCloudt','Range','A6:DX6','OutputType','string','Sheet',"Rearranged by HC");
    load("FF01MetsData_ss.mat","FF01MetsData_ss")
    load("MetNames_glucose.mat","MetNames")

    % Construct a structure with the loaded ss data
    ssdataFF01 = struct();
    ssdataFF01.metabolites_ss = struct();
    ssdataFF01.legenda_mets = {};
    ssdataFF01.fluxes_ss = {};
    ssdataFF01.legenda_fluxes = {};
    
    NumberOfECmets = 5;    % Number of extracellular metabolites measured in the experiment
    
    iter = 0; % Initialise iteration counter
    
    for i = 1:4:size(FF01MetsData_ss,2)
        
        iter = iter + 1;
        
        MetName = MetNames(i);
        ssdataFF01.legenda_mets{iter,1} = MetName;
        
        Met_ss = FF01MetsData_ss(:,i:i+3);
        
        if i <= NumberOfECmets*4
            ssdataFF01.metabolites_ss.(MetName).time = "ss";
            ssdataFF01.metabolites_ss.(MetName).conc = Met_ss(:,2)/1000;
            ssdataFF01.metabolites_ss.(MetName).stdev = Met_ss(:,3)/1000;
            ssdataFF01.metabolites_ss.(MetName).sterr = Met_ss(:,4)/1000;
        else
            ssdataFF01.metabolites_ss.(MetName).time = "ss";
            ssdataFF01.metabolites_ss.(MetName).conc = (Met_ss(:,2)/1000)*(1/(z*1e-3));
            ssdataFF01.metabolites_ss.(MetName).stdev = (Met_ss(:,3)/1000)*(1/(z*1e-3));
            ssdataFF01.metabolites_ss.(MetName).sterr = (Met_ss(:,4)/1000)*(1/(z*1e-3));
        end
        
    end
    
    ssdataFF01.time_ICmets = ssdataFF01.metabolites_ss.Glc_ic.time;
    ssdataFF01.time_ECmets = ssdataFF01.metabolites_ss.Glc_ec.time;
    ssdataFF01.time_fluxes = [];
    
end