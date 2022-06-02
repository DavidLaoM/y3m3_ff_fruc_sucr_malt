%% SetOutput, Hugo Cloudt (21-10-2021)
% Function that sets the simulation output in the desired order for plotting when "plotMode" is set at 
% "2_HugoCloudt" or leaves it in the original order if any other "plotMode" is set.
%
% Inputs:
% plotMode   = number or string that indicates how to plot in "referencePlotSimulations.m"
% T_1        = points in time obtained as output of the simulation
% Y_1        = metabolite concentrations obtained as output of the simulation
% V_1        = fluxes/reaction rates obtained as output of the simulation
%
% Output:
% selResCell = cell in which the simulation output is stored
%

function [selResCell] = SetOutput(plotMode,T_1,Y_1,V_1)

    % Desired output Hugo Cloudt
    if ~isa(plotMode,'numeric')
    
        if plotMode == "2_HugoCloudt"
        
            % Declaring a new Y with the same structure as the old Y
            Y_HugoCloudt_1 = zeros(length(T_1),43); % put the total number of Y's here
        
            % Storing the columns of the old Y (calculated metabolite concentrations) in the new Y in the desired order
        
            % 1. Y's Hugo wants to plot:
            Y_HugoCloudt_1(:,1) = Y_1(:,36);                                    % Glc_{ec}
            Y_HugoCloudt_1(:,2) = Y_1(:,34);                                    % Fruc_{ec}
            Y_HugoCloudt_1(:,3) = Y_1(:,35);                                    % Sucr_{ec}
            Y_HugoCloudt_1(:,4) = Y_1(:,41);                                    % Malt_{ec}
            Y_HugoCloudt_1(:,5) = Y_1(:,37);                                    % Tre_{ec}
            Y_HugoCloudt_1(:,6) = Y_1(:,6);                                     % Glc_{ic}
            Y_HugoCloudt_1(:,7) = Y_1(:,33);                                    % Fruc_{ic}
            Y_HugoCloudt_1(:,8) = Y_1(:,42);                                    % Malt_{ic}
            Y_HugoCloudt_1(:,9) = Y_1(:,25);                                    % Tre_{cyt}
            Y_HugoCloudt_1(:,10) = Y_1(:,38);                                   % Tre_{vac}
            Y_HugoCloudt_1(:,11) = Y_HugoCloudt_1(:,9) + Y_HugoCloudt_1(:,10);  % Tre_{ic}        % Note that Tre_ic = Tre_cyt + Tre_vac
            Y_HugoCloudt_1(:,12) = Y_1(:,26);                                   % T6P
            Y_HugoCloudt_1(:,13) = Y_1(:,40);                                   % Glyc
            Y_HugoCloudt_1(:,14) = Y_1(:,21);                                   % G1P
            Y_HugoCloudt_1(:,15) = Y_1(:,24);                                   % UDPGlc
            Y_HugoCloudt_1(:,16) = Y_1(:,5);                                    % G6P
            Y_HugoCloudt_1(:,17) = Y_1(:,4);                                    % F6P
            Y_HugoCloudt_1(:,18) = Y_1(:,3);                                    % FBP
            Y_HugoCloudt_1(:,19) = Y_1(:,17);                                   % DHAP
            Y_HugoCloudt_1(:,20) = Y_1(:,14);                                   % GAP
            Y_HugoCloudt_1(:,21) = Y_1(:,11);                                   % 3PG
            Y_HugoCloudt_1(:,22) = Y_1(:,10);                                   % 2PG
            Y_HugoCloudt_1(:,23) = Y_1(:,12);                                   % PEP
            Y_HugoCloudt_1(:,24) = Y_1(:,13);                                   % Pyr
            Y_HugoCloudt_1(:,25) = Y_1(:,18);                                   % G3P
            Y_HugoCloudt_1(:,26) = Y_1(:,8);                                    % NADH
            Y_HugoCloudt_1(:,27) = Y_1(:,7);                                    % NAD
            Y_HugoCloudt_1(:,28) = Y_1(:,9);                                    % ATP
            Y_HugoCloudt_1(:,29) = Y_1(:,15);                                   % ADP
            Y_HugoCloudt_1(:,30) = Y_1(:,16);                                   % AMP
        
            % 2. Other Y's:
            Y_HugoCloudt_1(:,31) = Y_1(:,22);                                   % UTP
            Y_HugoCloudt_1(:,32) = Y_1(:,23);                                   % UDP
            Y_HugoCloudt_1(:,33) = Y_1(:,1);                                    % ACE
            Y_HugoCloudt_1(:,34) = Y_1(:,2);                                    % BPG
            Y_HugoCloudt_1(:,35) = Y_1(:,19);                                   % Glycerol
            Y_HugoCloudt_1(:,36) = Y_1(:,20);                                   % EtOH
            Y_HugoCloudt_1(:,37) = Y_1(:,27);                                   % PI
            Y_HugoCloudt_1(:,38) = Y_1(:,28);                                   % IMP
            Y_HugoCloudt_1(:,39) = Y_1(:,29);                                   % INO
            Y_HugoCloudt_1(:,40) = Y_1(:,30);                                   % HYP
            Y_HugoCloudt_1(:,41) = Y_1(:,31);                                   % EtOH_{ec}
            Y_HugoCloudt_1(:,42) = Y_1(:,32);                                   % Glycerol_{ec}
            Y_HugoCloudt_1(:,43) = Y_1(:,39);                                   % Volume of broth (Vbroth)
        
            % Declaring a new V with the same structure as the old V
            V_HugoCloudt_1 = zeros(length(T_1),54); % put the total number of V's here
        
            % Storing the columns of the old V (calculated enzymatic fluxes) in the new V in the desired order
        
            % Glycolysis
            V_HugoCloudt_1(:,1) = V_1(:,52);                                    % v_{Inv}
            V_HugoCloudt_1(:,2) = V_1(:,1);                                     % v_{Hxt,Glc}
            V_HugoCloudt_1(:,3) = V_1(:,43);                                    % v_{Hxt,Fruc}
            V_HugoCloudt_1(:,4) = V_1(:,53);                                    % v_{Mat}
            V_HugoCloudt_1(:,5) = V_1(:,54);                                    % v_{Malx2}
            V_HugoCloudt_1(:,6) = V_1(:,2);                                     % v_{HxkGlk,Glc}
            V_HugoCloudt_1(:,7) = V_1(:,3);                                     % v_{Pgi}
            V_HugoCloudt_1(:,8) = V_1(:,44);                                    % v_{Hxk,Fruc}
            V_HugoCloudt_1(:,9) = V_1(:,4);                                     % v_{Pfk}
            V_HugoCloudt_1(:,10) = V_1(:,5);                                    % v_{Ald}
            V_HugoCloudt_1(:,11) = V_1(:,7);                                    % v_{Tpi}
            V_HugoCloudt_1(:,12) = V_1(:,8);                                    % v_{Tdh}
            V_HugoCloudt_1(:,13) = V_1(:,9);                                    % v_{Pgk}
            V_HugoCloudt_1(:,14) = V_1(:,10);                                   % v_{Pgm}
            V_HugoCloudt_1(:,15) = V_1(:,11);                                   % v_{Eno}
            V_HugoCloudt_1(:,16) = V_1(:,12);                                   % v_{Pyk}
        
            % Trehalose metabolism
            V_HugoCloudt_1(:,17) = V_1(:,21);                                   % v_{Tps1}
            V_HugoCloudt_1(:,18) = V_1(:,19);                                   % v_{Tps2}
            V_HugoCloudt_1(:,19) = V_1(:,20);                                   % v_{Nth1}
            V_HugoCloudt_1(:,20) = V_1(:,48);                                   % v_{vacT}
            V_HugoCloudt_1(:,21) = V_1(:,46);                                   % v_{Ath1vac}
            V_HugoCloudt_1(:,22) = V_1(:,47);                                   % v_{Agt1}
            V_HugoCloudt_1(:,23) = V_1(:,45);                                   % v_{Ath1ec}
        
            % Glycogen metabolism
            V_HugoCloudt_1(:,24) = V_1(:,17);                                   % v_{Pgm1}
            V_HugoCloudt_1(:,25) = V_1(:,18);                                   % v_{Udpg}
            V_HugoCloudt_1(:,26) = V_1(:,50);                                   % v_{GlycSynth}
            V_HugoCloudt_1(:,27) = V_1(:,51);                                   % v_{GlycDeg}
        
            % Glycerol synthesis
            V_HugoCloudt_1(:,28) = V_1(:,6);                                    % v_{G3Pdh}
            V_HugoCloudt_1(:,29) = V_1(:,15);                                   % v_{Hor2)
            V_HugoCloudt_1(:,30) = V_1(:,24);                                   % v_{GlycerolT}
        
            % Ethanol fermentation
            V_HugoCloudt_1(:,31) = V_1(:,13);                                   % v_{Pdc}
            V_HugoCloudt_1(:,32) = V_1(:,41);                                   % v_{Adh}
            V_HugoCloudt_1(:,33) = V_1(:,25);                                   % v_{Pdh}
            V_HugoCloudt_1(:,34) = V_1(:,23);                                   % v_{EtOHT}
        
            % Cofactor metabolism
            V_HugoCloudt_1(:,35) = V_1(:,26);                                   % v_{mitoNADH}
        
            % ATP metabolism
            V_HugoCloudt_1(:,36) = V_1(:,14);                                   % v_{Adk1}
            V_HugoCloudt_1(:,37) = V_1(:,27);                                   % v_{ATPase}
            V_HugoCloudt_1(:,38) = V_1(:,28);                                   % v_{mitoATP}
            V_HugoCloudt_1(:,39) = V_1(:,42);                                   % v_{vacuolePI}
        
            % IXP cycle
            V_HugoCloudt_1(:,40) = V_1(:,29);                                   % v_{Amd1}
        
            % Sink reactions (biomass)
            V_HugoCloudt_1(:,41) = V_1(:,34);                                   % v_{sinkG6P}
            V_HugoCloudt_1(:,42) = V_1(:,35);                                   % v_{sinkF6P}
            V_HugoCloudt_1(:,43) = V_1(:,36);                                   % v_{sinkGAP}
            V_HugoCloudt_1(:,44) = V_1(:,37);                                   % v_{sink3PG}
            V_HugoCloudt_1(:,45) = V_1(:,38);                                   % v_{sinkPEP}
            V_HugoCloudt_1(:,46) = V_1(:,39);                                   % v_{sinkPyr}
            V_HugoCloudt_1(:,47) = V_1(:,40);                                   % v_{sinkACE}
            
            % V's Hugo doesn't want to plot:
            V_HugoCloudt_1(:,48) = V_1(:,49);                                   % v_{GlycSynthDeg}
            V_HugoCloudt_1(:,49) = V_1(:,16);                                   % v_{Rhr2}
            V_HugoCloudt_1(:,50) = V_1(:,22);                                   % v_{ACE}
            V_HugoCloudt_1(:,51) = V_1(:,30);                                   % v_{Ade13Ade12}
            V_HugoCloudt_1(:,52) = V_1(:,31);                                   % v_{Isn1}
            V_HugoCloudt_1(:,53) = V_1(:,32);                                   % v_{Pnp1}
            V_HugoCloudt_1(:,54) = V_1(:,33);                                   % v_{Hpt1}
            
            % Storing output in selResCell
            selResCell.T_1 = T_1;
            selResCell.Y_HugoCloudt_1 = Y_HugoCloudt_1;
            selResCell.V_HugoCloudt_1 = V_HugoCloudt_1;
        
        end
    
    % Output in original code
    elseif isa(plotMode,'numeric')
        T_FF01_1 = T_1;
        Y_FF01_1 = Y_1;
        V_FF01_1 = V_1;
    
        % Storing output in selResCell
        selResCell.T_FF01 = T_FF01_1;
        selResCell.Y_FF01 = Y_FF01_1;
        selResCell.V_FF01 = V_FF01_1;
    end
end