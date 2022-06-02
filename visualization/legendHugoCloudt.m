%% legendHugoCloudt (Hugo Cloudt, 11-10-2021)
% Function that sets the legend used by Hugo Cloudt.
%
% Inputs:
% -
%
% Outputs:
% legend = the desired legend
%

function [legend] = legendHugoCloudt
    
    % Legend for metabolite concentrations
    legend.metabolites = {'Glc_{ec}';
        'Fruc_{ec}';
        'Sucr_{ec}';
        'Malt_{ec}';
        'Tre_{ec}';
        'Glc_{ic}';
        'Fruc_{ic}';
        'Malt_{ic}';
        'Tre_{cyt}';
        'Tre_{vac}';
        'Tre_{ic}';
        'T6P';
        'Gly';
        'G1P';
        'UDPgluc';
        'G6P';
        'F6P';
        'FBP';
        'DHAP';
        'GAP';
        '3PG';
        '2PG';
        'PEP';
        'PYR';
        'G3P';
        'NADH';
        'NAD';
        'ATP';
        'ADP';
        'AMP';
        'UTP';
        'UDP';
        'ACE'; % From here on: metabolite concentrations that are not plotted
        'BPG';
        'Glycerol';
        'EtOH';
        'PI';
        'IMP';
        'INO';
        'HYP';
        'EtOH_{ec}';
        'Glyce_{ec}';
        };
    
    % Legend for reaction rates/fluxes
    legend.fluxes = {'v_{inv}';
        'v_{hxt,Glc}';
        'v_{hxt,Fruc}';
        'v_{mat}';
        'v_{malx2}';
        'v_{hxk+glk,Glc}';
        'v_{pgi}';
        'v_{hxk,Fruc}';
        'v_{pfk}';
        'v_{ald}';
        'v_{tpi}';
        'v_{tdh}';
        'v_{pgk}';
        'v_{pgm}';
        'v_{eno}';
        'v_{pyk}';
        'v_{tps1}';
        'v_{tps2}';
        'v_{nth1}';
        'v_{vacT}';
        'v_{ath1vac}';
        'v_{agt1}';
        'v_{ath1ec}';
        'v_{pgm1}';
        'v_{udpg}';
        'v_{Glysynth}';
        'v_{Glydeg}';
        'v_{gpd}';
        'v_{hor2}';
        'v_{glyceT}';
        'v_{pdc}';
        'v_{adh}';
        'v_{pdh}';
        'v_{EtOHT}';
        'v_{mitoNADH}';
        'v_{adk1}';
        'v_{ATPase}';
        'v_{mitoATP}';
        'v_{vacuolePI}';
        'v_{amd1}';
        'v_{sinkG6P}';
        'v_{sinkF6P}';
        'v_{sinkGAP}';
        'v_{sink3PG}';
        'v_{sinkPEP}';
        'v_{sinkPyr}';
        'v_{sinkACE}';
        'v_{Glysynthdeg}'; % From here on: enzymatic fluxes that are not plotted
        'v_{rhr2}';
        'v_{ACE}';
        'v_{ade13ade12}';
        'v_{isn1}';
        'v_{pnp1}';
        'v_{hpt1}';
        };
end