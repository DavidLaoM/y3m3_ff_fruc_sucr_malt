%% redefine_dataFF01 (Hugo Cloudt, 18-10-2021)
% Function that redefines the structure "dataFF01" as such that it can be correctly plotted
% by the code in "referencePlotSimulations" when "plotMode" is set to "2_HugoCloudt" (Hugo Cloudt's plotMode)
% Futhermore, the structure "ssdataFF01" is redefined and merged into the redefined "dataFF01".
%
% Inputs:
% dataFF01 = old dataFF01, which needs to be redefined.
% ssdataFF01 = old ssdataFF01, which needs to be redefined and merged into the redefined dataFF01.
% 
% Outputs:
% dataFF01_redefined = redefined dataFF01

function [dataFF01_redefined] = redefine_dataFF01(dataFF01,ssdataFF01)
    
    % Loading the old dataFF01
    dataFF01_redefined = dataFF01;
    
    % Replacing the cell array in the "metabolites" field of the old
    % dataFF01 with a new cell array
    dataFF01_redefined.metabolites = cell(42,1);
    
    % Filling the created cell array with the metabolite concentrations of FF01
    dataFF01_redefined.metabolites{1} = dataFF01.metabolites{36};
    dataFF01_redefined.metabolites{2} = dataFF01.metabolites{34};
    dataFF01_redefined.metabolites{3} = dataFF01.metabolites{35};
    dataFF01_redefined.metabolites{4} = [];
    dataFF01_redefined.metabolites{5} = dataFF01.metabolites{37};
    dataFF01_redefined.metabolites{6} = dataFF01.metabolites{6};
    dataFF01_redefined.metabolites{7} = dataFF01.metabolites{33};
    dataFF01_redefined.metabolites{8} = [];
    dataFF01_redefined.metabolites{9} = dataFF01.metabolites{25};
    dataFF01_redefined.metabolites{10} = dataFF01.metabolites{38};
    dataFF01_redefined.metabolites{11}.time = dataFF01.metabolites{25}.time; dataFF01_redefined.metabolites{11}.conc = dataFF01.metabolites{25}.conc + dataFF01.metabolites{38}.conc; dataFF01_redefined.metabolites{11}.stdev = dataFF01.metabolites{25}.stdev + dataFF01.metabolites{38}.stdev; dataFF01_redefined.metabolites{11}.sterr = dataFF01.metabolites{25}.sterr + dataFF01.metabolites{38}.sterr; 
    dataFF01_redefined.metabolites{12} = dataFF01.metabolites{26};
    dataFF01_redefined.metabolites{13} = [];
    dataFF01_redefined.metabolites{14} = dataFF01.metabolites{21};
    dataFF01_redefined.metabolites{15} = dataFF01.metabolites{24};
    dataFF01_redefined.metabolites{16} = dataFF01.metabolites{5};
    dataFF01_redefined.metabolites{17} = dataFF01.metabolites{4};
    dataFF01_redefined.metabolites{18} = dataFF01.metabolites{3};
    dataFF01_redefined.metabolites{19} = dataFF01.metabolites{17};
    dataFF01_redefined.metabolites{20} = dataFF01.metabolites{14};
    dataFF01_redefined.metabolites{21} = dataFF01.metabolites{11};
    dataFF01_redefined.metabolites{22} = dataFF01.metabolites{10};
    dataFF01_redefined.metabolites{23} = dataFF01.metabolites{12};
    dataFF01_redefined.metabolites{24} = dataFF01.metabolites{13};
    dataFF01_redefined.metabolites{25} = dataFF01.metabolites{18};
    dataFF01_redefined.metabolites{26} = dataFF01.metabolites{8};
    dataFF01_redefined.metabolites{27} = dataFF01.metabolites{7};
    dataFF01_redefined.metabolites{28} = dataFF01.metabolites{9};
    dataFF01_redefined.metabolites{29} = dataFF01.metabolites{15};
    dataFF01_redefined.metabolites{30} = dataFF01.metabolites{16};
    dataFF01_redefined.metabolites{31} = dataFF01.metabolites{22};
    dataFF01_redefined.metabolites{32} = dataFF01.metabolites{23};
    dataFF01_redefined.metabolites{33} = dataFF01.metabolites{1};
    dataFF01_redefined.metabolites{34} = dataFF01.metabolites{2};
    dataFF01_redefined.metabolites{35} = dataFF01.metabolites{19};
    dataFF01_redefined.metabolites{36} = dataFF01.metabolites{20};
    dataFF01_redefined.metabolites{37} = dataFF01.metabolites{27};
    dataFF01_redefined.metabolites{38} = dataFF01.metabolites{28};
    dataFF01_redefined.metabolites{39} = dataFF01.metabolites{29};
    dataFF01_redefined.metabolites{40} = dataFF01.metabolites{30};
    dataFF01_redefined.metabolites{41} = dataFF01.metabolites{31};
    dataFF01_redefined.metabolites{42} = dataFF01.metabolites{32};
    
    % Setting the new dataFF01 to have a cell array in the "metabolites_ss" field
    dataFF01_redefined.metabolites_ss = cell(42,1);
    
    % Filling the created cell array with the steady state concentrations of FF01
    dataFF01_redefined.metabolites_ss{1} = ssdataFF01.metabolites_ss.Glc_ec;
    dataFF01_redefined.metabolites_ss{2} = ssdataFF01.metabolites_ss.Fruc_ec;
    dataFF01_redefined.metabolites_ss{3} = ssdataFF01.metabolites_ss.Sucr_ec;
    dataFF01_redefined.metabolites_ss{4} = ssdataFF01.metabolites_ss.Malt_ec;
    dataFF01_redefined.metabolites_ss{5} = ssdataFF01.metabolites_ss.Tre_ec;
    dataFF01_redefined.metabolites_ss{6} = ssdataFF01.metabolites_ss.Glc_ic;
    dataFF01_redefined.metabolites_ss{7} = ssdataFF01.metabolites_ss.Fruc_ic;
    dataFF01_redefined.metabolites_ss{8} = ssdataFF01.metabolites_ss.Malt_ic;
    dataFF01_redefined.metabolites_ss{9} = ssdataFF01.metabolites_ss.Tre_cyt;
    dataFF01_redefined.metabolites_ss{10} = ssdataFF01.metabolites_ss.Tre_vac;
    dataFF01_redefined.metabolites_ss{11} = ssdataFF01.metabolites_ss.Tre_ic; 
    dataFF01_redefined.metabolites_ss{12} = ssdataFF01.metabolites_ss.T6P;
    dataFF01_redefined.metabolites_ss{13} = ssdataFF01.metabolites_ss.Glyc;
    dataFF01_redefined.metabolites_ss{14} = ssdataFF01.metabolites_ss.G1P;
    dataFF01_redefined.metabolites_ss{15} = ssdataFF01.metabolites_ss.UDPGlc;
    dataFF01_redefined.metabolites_ss{16} = ssdataFF01.metabolites_ss.G6P;
    dataFF01_redefined.metabolites_ss{17} = ssdataFF01.metabolites_ss.F6P;
    dataFF01_redefined.metabolites_ss{18} = ssdataFF01.metabolites_ss.FBP;
    dataFF01_redefined.metabolites_ss{19} = ssdataFF01.metabolites_ss.DHAP;
    dataFF01_redefined.metabolites_ss{20} = ssdataFF01.metabolites_ss.GAP;
    dataFF01_redefined.metabolites_ss{21} = ssdataFF01.metabolites_ss.threePG;
    dataFF01_redefined.metabolites_ss{22} = ssdataFF01.metabolites_ss.twoPG;
    dataFF01_redefined.metabolites_ss{23} = ssdataFF01.metabolites_ss.PEP;
    dataFF01_redefined.metabolites_ss{24} = ssdataFF01.metabolites_ss.Pyr;
    dataFF01_redefined.metabolites_ss{25} = ssdataFF01.metabolites_ss.G3P;
    dataFF01_redefined.metabolites_ss{26} = ssdataFF01.metabolites_ss.NADH;
    dataFF01_redefined.metabolites_ss{27} = ssdataFF01.metabolites_ss.NAD;
    dataFF01_redefined.metabolites_ss{28} = ssdataFF01.metabolites_ss.ATP;
    dataFF01_redefined.metabolites_ss{29} = ssdataFF01.metabolites_ss.ADP;
    dataFF01_redefined.metabolites_ss{30} = ssdataFF01.metabolites_ss.AMP;
    dataFF01_redefined.metabolites_ss{31} = ssdataFF01.metabolites_ss.UTP;
    dataFF01_redefined.metabolites_ss{32} = ssdataFF01.metabolites_ss.UDP;
    
    % Replacing the cell array in the "fluxes" field of the old dataFF01
    % with a new cell array
    dataFF01_redefined.fluxes = cell(54,1);
    
    % Filling the created cell array with the fluxes of FF01
    dataFF01_redefined.fluxes{1} = [];
    dataFF01_redefined.fluxes{2} = dataFF01.fluxes{1};
    dataFF01_redefined.fluxes{3} = dataFF01.fluxes{43};
    dataFF01_redefined.fluxes{4} = [];
    dataFF01_redefined.fluxes{5} = [];
    dataFF01_redefined.fluxes{6} = dataFF01.fluxes{2};
    dataFF01_redefined.fluxes{7} = dataFF01.fluxes{3};
    dataFF01_redefined.fluxes{8} = dataFF01.fluxes{44};
    dataFF01_redefined.fluxes{9} = dataFF01.fluxes{4};
    dataFF01_redefined.fluxes{10} = dataFF01.fluxes{5};
    dataFF01_redefined.fluxes{11} = dataFF01.fluxes{7};
    dataFF01_redefined.fluxes{12} = dataFF01.fluxes{8};
    dataFF01_redefined.fluxes{13} = dataFF01.fluxes{9};
    dataFF01_redefined.fluxes{14} = dataFF01.fluxes{10};
    dataFF01_redefined.fluxes{15} = dataFF01.fluxes{11};
    dataFF01_redefined.fluxes{16} = dataFF01.fluxes{12};
    dataFF01_redefined.fluxes{17} = dataFF01.fluxes{21};
    dataFF01_redefined.fluxes{18} = dataFF01.fluxes{19};
    dataFF01_redefined.fluxes{19} = dataFF01.fluxes{20};
    dataFF01_redefined.fluxes{20} = dataFF01.fluxes{48};
    dataFF01_redefined.fluxes{21} = dataFF01.fluxes{46};
    dataFF01_redefined.fluxes{22} = dataFF01.fluxes{47};
    dataFF01_redefined.fluxes{23} = dataFF01.fluxes{45};
    dataFF01_redefined.fluxes{24} = dataFF01.fluxes{17};
    dataFF01_redefined.fluxes{25} = dataFF01.fluxes{18};
    dataFF01_redefined.fluxes{26} = [];
    dataFF01_redefined.fluxes{27} = [];
    dataFF01_redefined.fluxes{28} = dataFF01.fluxes{6};
    dataFF01_redefined.fluxes{29} = dataFF01.fluxes{15};
    dataFF01_redefined.fluxes{30} = dataFF01.fluxes{24};
    dataFF01_redefined.fluxes{31} = dataFF01.fluxes{13};
    dataFF01_redefined.fluxes{32} = dataFF01.fluxes{41};
    dataFF01_redefined.fluxes{33} = dataFF01.fluxes{25};
    dataFF01_redefined.fluxes{34} = dataFF01.fluxes{23};
    dataFF01_redefined.fluxes{35} = dataFF01.fluxes{26};
    dataFF01_redefined.fluxes{36} = dataFF01.fluxes{14};
    dataFF01_redefined.fluxes{37} = dataFF01.fluxes{27};
    dataFF01_redefined.fluxes{38} = dataFF01.fluxes{28};
    dataFF01_redefined.fluxes{39} = dataFF01.fluxes{42};
    dataFF01_redefined.fluxes{40} = dataFF01.fluxes{29};
    dataFF01_redefined.fluxes{41} = dataFF01.fluxes{34};
    dataFF01_redefined.fluxes{42} = dataFF01.fluxes{35};
    dataFF01_redefined.fluxes{43} = dataFF01.fluxes{36};
    dataFF01_redefined.fluxes{44} = dataFF01.fluxes{37};
    dataFF01_redefined.fluxes{45} = dataFF01.fluxes{38};
    dataFF01_redefined.fluxes{46} = dataFF01.fluxes{39};
    dataFF01_redefined.fluxes{47} = dataFF01.fluxes{40};
    dataFF01_redefined.fluxes{48} = [];
    dataFF01_redefined.fluxes{49} = dataFF01.fluxes{16};
    dataFF01_redefined.fluxes{50} = dataFF01.fluxes{22};
    dataFF01_redefined.fluxes{51} = dataFF01.fluxes{30};
    dataFF01_redefined.fluxes{52} = dataFF01.fluxes{31};
    dataFF01_redefined.fluxes{53} = dataFF01.fluxes{32};
    dataFF01_redefined.fluxes{54} = dataFF01.fluxes{33};
end