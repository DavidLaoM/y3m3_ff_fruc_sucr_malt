%% redefine_dataFF01Sucr (Hugo Cloudt, 19-10-2021)
% Function that redefines the structure "dataFF01Sucr" as such that it gets a similar structure as
% the structures "dataFF01", "dataFF03", and "dataFF04", which makes it possible to plot the data in
% "dataFF01Sucr" in the same easy way as used for plotting the data in the structures "dataFF01", 
% "dataFF03", and "dataFF04" (i.e. storing the structure in "ExpData" and using it to plot in 
% "referencePlotSimulations.m").
%
% Input:
% dataFF01Sucr = old dataFF01Sucr, which needs to be redefined.
% 
% Output:
% dataFF01Sucr_redefined = redefined dataFF01Sucr

function [dataFF01Sucr_redefined] = redefine_dataFF01Sucr(dataFF01Sucr)
    
    % Loading the old dataFF01Sucr
    dataFF01Sucr_redefined = dataFF01Sucr;
    
    % Replacing the structure in the "metabolites" field of the old dataFF01Sucr with a cell
    dataFF01Sucr_redefined.metabolites = cell(numel(fieldnames(dataFF01Sucr.metabolites)),1);
    
    % Filling the created cell with the metabolite concentrations
    dataFF01Sucr_redefined.metabolites{1} = dataFF01Sucr.metabolites.Glc_ec;
    dataFF01Sucr_redefined.metabolites{2} = dataFF01Sucr.metabolites.Fruc_ec;
    dataFF01Sucr_redefined.metabolites{3} = dataFF01Sucr.metabolites.Sucr_ec;
    dataFF01Sucr_redefined.metabolites{4} = dataFF01Sucr.metabolites.Malt_ec;
    dataFF01Sucr_redefined.metabolites{5} = dataFF01Sucr.metabolites.Tre_ec;
    dataFF01Sucr_redefined.metabolites{6} = dataFF01Sucr.metabolites.Glc_ic;
    dataFF01Sucr_redefined.metabolites{7} = dataFF01Sucr.metabolites.Fruc_ic;
    dataFF01Sucr_redefined.metabolites{8} = dataFF01Sucr.metabolites.Malt_ic;
    dataFF01Sucr_redefined.metabolites{9} = dataFF01Sucr.metabolites.Tre_cyt;
    dataFF01Sucr_redefined.metabolites{10} = dataFF01Sucr.metabolites.Tre_vac;
    dataFF01Sucr_redefined.metabolites{11} = dataFF01Sucr.metabolites.Tre_ic;
    dataFF01Sucr_redefined.metabolites{12} = dataFF01Sucr.metabolites.T6P;
    dataFF01Sucr_redefined.metabolites{13} = dataFF01Sucr.metabolites.Glyc;
    dataFF01Sucr_redefined.metabolites{14} = dataFF01Sucr.metabolites.G1P;
    dataFF01Sucr_redefined.metabolites{15} = dataFF01Sucr.metabolites.UDPGlc;
    dataFF01Sucr_redefined.metabolites{16} = dataFF01Sucr.metabolites.G6P;
    dataFF01Sucr_redefined.metabolites{17} = dataFF01Sucr.metabolites.F6P;
    dataFF01Sucr_redefined.metabolites{18} = dataFF01Sucr.metabolites.FBP;
    dataFF01Sucr_redefined.metabolites{19} = dataFF01Sucr.metabolites.DHAP;
    dataFF01Sucr_redefined.metabolites{20} = dataFF01Sucr.metabolites.GAP;
    dataFF01Sucr_redefined.metabolites{21} = dataFF01Sucr.metabolites.threePG;
    dataFF01Sucr_redefined.metabolites{22} = dataFF01Sucr.metabolites.twoPG;
    dataFF01Sucr_redefined.metabolites{23} = dataFF01Sucr.metabolites.PEP;
    dataFF01Sucr_redefined.metabolites{24} = dataFF01Sucr.metabolites.Pyr;
    dataFF01Sucr_redefined.metabolites{25} = dataFF01Sucr.metabolites.G3P;
    dataFF01Sucr_redefined.metabolites{26} = dataFF01Sucr.metabolites.NADH;
    dataFF01Sucr_redefined.metabolites{27} = dataFF01Sucr.metabolites.NAD;
    dataFF01Sucr_redefined.metabolites{28} = dataFF01Sucr.metabolites.ATP;
    dataFF01Sucr_redefined.metabolites{29} = dataFF01Sucr.metabolites.ADP;
    dataFF01Sucr_redefined.metabolites{30} = dataFF01Sucr.metabolites.AMP;
    dataFF01Sucr_redefined.metabolites{31} = dataFF01Sucr.metabolites.UTP;
    dataFF01Sucr_redefined.metabolites{32} = dataFF01Sucr.metabolites.UDP;
    
    % Replacing the structure in the "metabolites_ss" field of the old dataFF01Sucr with a cell
    dataFF01Sucr_redefined.metabolites_ss = cell(numel(fieldnames(dataFF01Sucr.metabolites_ss)),1);
    
    % Filling the created cell with the metabolite concentrations
    dataFF01Sucr_redefined.metabolites_ss{1} = dataFF01Sucr.metabolites_ss.Glc_ec;
    dataFF01Sucr_redefined.metabolites_ss{2} = dataFF01Sucr.metabolites_ss.Fruc_ec;
    dataFF01Sucr_redefined.metabolites_ss{3} = dataFF01Sucr.metabolites_ss.Sucr_ec;
    dataFF01Sucr_redefined.metabolites_ss{4} = dataFF01Sucr.metabolites_ss.Malt_ec;
    dataFF01Sucr_redefined.metabolites_ss{5} = dataFF01Sucr.metabolites_ss.Tre_ec;
    dataFF01Sucr_redefined.metabolites_ss{6} = dataFF01Sucr.metabolites_ss.Glc_ic;
    dataFF01Sucr_redefined.metabolites_ss{7} = dataFF01Sucr.metabolites_ss.Fruc_ic;
    dataFF01Sucr_redefined.metabolites_ss{8} = dataFF01Sucr.metabolites_ss.Malt_ic;
    dataFF01Sucr_redefined.metabolites_ss{9} = dataFF01Sucr.metabolites_ss.Tre_cyt;
    dataFF01Sucr_redefined.metabolites_ss{10} = dataFF01Sucr.metabolites_ss.Tre_vac;
    dataFF01Sucr_redefined.metabolites_ss{11} = dataFF01Sucr.metabolites_ss.Tre_ic;
    dataFF01Sucr_redefined.metabolites_ss{12} = dataFF01Sucr.metabolites_ss.T6P;
    dataFF01Sucr_redefined.metabolites_ss{13} = dataFF01Sucr.metabolites_ss.Glyc;
    dataFF01Sucr_redefined.metabolites_ss{14} = dataFF01Sucr.metabolites_ss.G1P;
    dataFF01Sucr_redefined.metabolites_ss{15} = dataFF01Sucr.metabolites_ss.UDPGlc;
    dataFF01Sucr_redefined.metabolites_ss{16} = dataFF01Sucr.metabolites_ss.G6P;
    dataFF01Sucr_redefined.metabolites_ss{17} = dataFF01Sucr.metabolites_ss.F6P;
    dataFF01Sucr_redefined.metabolites_ss{18} = dataFF01Sucr.metabolites_ss.FBP;
    dataFF01Sucr_redefined.metabolites_ss{19} = dataFF01Sucr.metabolites_ss.DHAP;
    dataFF01Sucr_redefined.metabolites_ss{20} = dataFF01Sucr.metabolites_ss.GAP;
    dataFF01Sucr_redefined.metabolites_ss{21} = dataFF01Sucr.metabolites_ss.threePG;
    dataFF01Sucr_redefined.metabolites_ss{22} = dataFF01Sucr.metabolites_ss.twoPG;
    dataFF01Sucr_redefined.metabolites_ss{23} = dataFF01Sucr.metabolites_ss.PEP;
    dataFF01Sucr_redefined.metabolites_ss{24} = dataFF01Sucr.metabolites_ss.Pyr;
    dataFF01Sucr_redefined.metabolites_ss{25} = dataFF01Sucr.metabolites_ss.G3P;
    dataFF01Sucr_redefined.metabolites_ss{26} = dataFF01Sucr.metabolites_ss.NADH;
    dataFF01Sucr_redefined.metabolites_ss{27} = dataFF01Sucr.metabolites_ss.NAD;
    dataFF01Sucr_redefined.metabolites_ss{28} = dataFF01Sucr.metabolites_ss.ATP;
    dataFF01Sucr_redefined.metabolites_ss{29} = dataFF01Sucr.metabolites_ss.ADP;
    dataFF01Sucr_redefined.metabolites_ss{30} = dataFF01Sucr.metabolites_ss.AMP;
    dataFF01Sucr_redefined.metabolites_ss{31} = dataFF01Sucr.metabolites_ss.UTP;
    dataFF01Sucr_redefined.metabolites_ss{32} = dataFF01Sucr.metabolites_ss.UDP;
   
end