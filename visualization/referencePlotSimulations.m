% % setup options
% plotMode = 1; % single simulation
% plotMode = 2; % multiple simulations on top of each other (scatter or psa-like)
% plotMode = 2_HugoCloudt % plotMode = 2, but adjusted for simulations Hugo Cloudt
% plotMode = 10; % all

% Simulations with experimental data % % % % % % % % % % % % % % % % % % % 
if isa(plotMode,'numeric')
    if((plotMode == 1)||(plotMode == 10))
        % %%
        figure(101)
        for i = 1:38
            
            %FF01
            
            a1 = ExpData.metabolites{i};
            t_sim = T_FF01;
            c_sim = Y_FF01(:,i);
            if ~isempty(a1)
                tempFF01time = a1.time;
                tempFF01conc = a1.conc;
                cip = tempFF01conc(tempFF01time<400);
                tip = tempFF01time(tempFF01time<400);
                if isfield(a1, 'stdev')
                    tempFF01std = a1.stdev;
                else
                    tempFF01std = zeros(size(tempFF01time));
                end
                c_r2 = interp1(t_sim, c_sim, tip);
                SSE = sum((cip - c_r2).^2);
                SST = sum((cip - mean(cip)).^2);
                R2 = 1 - SSE/SST;
                R_matrix = corrcoef(c_r2, cip);
                R = R_matrix(1,2);
            else
                tempFF01time = zeros(size(ExpData.metabolites{3}.time));
                tempFF01conc = zeros(size(ExpData.metabolites{3}.conc));
                tempFF01std = zeros(size(ExpData.metabolites{3}.conc));
            end
            
            
            % plotting
            subplot(7,6,i)
            h1 = errorbar(tempFF01time,tempFF01conc,tempFF01std, ':.b','MarkerSize',10, 'DisplayName', 'exp');
            %         h1.Color = 'black';
            %plot(tempFF01time,tempFF01conc,'.')
            hold on
            if i == 6
                plot(T_FF01, Y_FF01(:,i), 'Color', 'black')
            else
                plot(T_FF01, Y_FF01(:,i), 'Color', 'black', 'DisplayName', 'sim')
            end
            %     Black line at end of feed
            plot([20 20], ylim,'k')
            hold on
            xlim([0 400])
            title(metNames{i})
            %         if ~isempty(a1)
            %             xtxt = 0.5*max(xlim);
            %             ytxt = 0.8*max(ylim);
            %             text(xtxt,ytxt, ['r^2 = ', num2str(R2, '%3.2f')])
            %             xtxt = 0.7*max(xlim);
            %             ytxt = 0.4*max(ylim);
            %             text(xtxt,ytxt, ['R = ', num2str(R, '%3.2f')])
            %         end
            
            %     figco = figure(20+i);
            %     h1 = errorbar(tempFF01time,tempFF01conc,tempFF01std); hold on
            %     plot(T_FF01, Y_FF01(:,i), 'Color', 'black')
            %     title(metNames{i})
            %     xlabel('time'); ylabel('C(mM)')
            %     titl = ['metConc', num2str(i),'.jpg'];
            %
            %
            %     % % % % saveas(figco, titl)
            %     close(figco)
        end
        sgtitle('Metabolite concentrations - last cycle'); % suptitle('Metabolite concentrations - last cycle'); DOES NOT WORK IN HUGO'S MATLAB R2021a, THEREFORE HUGO REPLACED IT WITH sgtitle
        % suptitle({'Enzymatic fluxes - last cycle','Opt. cost func. incl. UDPG, G1P, T6P & TRE(cyt+vac) w=1e-2'});
        
        fig = gcf;
        set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % % % % saveas(fig,'FFLastCycle_mets.jpg')
        % close
        
        % %%
        figure(102)
        for i = 1:48
            
            bl = ExpData.fluxes{i};
            t_sim = T_FF01;
            v_sim = V_FF01(:,i);
            
            
            if isfield(bl, 'rate')
                expFF01time = bl.time;
                expFF01flux = bl.rate;
                vip = expFF01flux(expFF01time<400);
                tip = expFF01time(expFF01time<400);
                %         v_r2_exp = interp1(tip, vip, t_sim, 'pchip','extrap');
                %         SSE = sum((v_r2_exp - v_sim).^2);
                %         SST = sum((v_r2_exp - mean(v_r2_exp)).^2);
                v_r2 = interp1(t_sim, v_sim, tip);
                SSE = sum((vip - v_r2).^2);
                SST = sum((vip - mean(vip)).^2);
                R2 = 1 - SSE/SST;
                R_matrix = corrcoef(v_r2, vip);
                %         R_matrix = corrcoef(v_sim, v_r2_exp);
                R = R_matrix(1,2);
                
            else
                expFF01time = zeros(size(ExpData.fluxes{3}.time));
                expFF01flux = zeros(size(ExpData.fluxes{3}.rate));
            end
            
            
            subplot(7,7,i)
            plot(expFF01time, expFF01flux,'b.:','MarkerSize',10)
            hold on;
            plot(T_FF01, V_FF01(:,i), 'Color', 'black')
            %     Black line at end of feed
            plot([20 20], ylim,'k'); hold on;
            title(legenda.fluxes{i})
            xlim([0 400])
            if isfield(bl, 'rate')
                xtxt = 0.5*max(xlim);
                ytxt = 0.8*max(ylim);
                text(xtxt,ytxt, ['r^2 = ', num2str(R2, '%3.2f')])
                xtxt = 0.7*max(xlim);
                ytxt = 0.4*max(ylim);
                text(xtxt,ytxt, ['R = ', num2str(R, '%3.2f')])
            end
            
        end
        sgtitle('Enzymatic fluxes - last cycle'); % suptitle('Enzymatic fluxes - last cycle'); DOES NOT WORK IN HUGO'S MATLAB R2021a, THEREFORE HUGO REPLACED IT WITH sgtitle
        % suptitle({'Enzymatic fluxes - last cycle','Opt. cost func. incl. UDPG, G1P, T6P & TRE(cyt+vac) w=1e-2'});
        
        fig = gcf;
        set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % % % % saveas(fig,'FFLastCycle_fluxes_exp.jpg')
        % close
    end
    
    % Only simulations % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    if(plotMode == 10)
        
        figure(1001)
        for i = 1:38
            subplot(7,6,i)
            plot(T_FF01, Y_FF01(:,i), 'Color', 'black')
            title(metNames{i})
            xlim([0 400])
        end
        sgtitle('Metabolite concentrations - last cycle'); % suptitle('Metabolite concentrations - last cycle'); DOES NOT WORK IN HUGO'S MATLAB R2021a, THEREFORE HUGO REPLACED IT WITH sgtitle
        % suptitle({'Enzymatic fluxes - last cycle','Opt. cost func. incl. UDPG, G1P, T6P & TRE(cyt+vac) w=1e-2'});
        
        fig = gcf;
        set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % % % % saveas(fig,'FFLastCycle_fluxes.jpg')
        % close
        
        figure(1002)
        for i = 1:48
            subplot(7,7,i)
            plot(T_FF01, V_FF01(:,i), 'Color', 'black')
            title(legenda.fluxes{i})
            xlim([0 400])
        end
        sgtitle('Enzymatic fluxes - last cycle'); % suptitle('Enzymatic fluxes - last cycle'); DOES NOT WORK IN HUGO'S MATLAB R2021a, THEREFORE HUGO REPLACED IT WITH sgtitle
        % suptitle({'Enzymatic fluxes - last cycle','Opt. cost func. incl. UDPG, G1P, T6P & TRE(cyt+vac) w=1e-2'});
        
        fig = gcf;
        set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % % % % saveas(fig,'FFLastCycle_fluxes.jpg')
        % close
        
    end
    
    
    
    % Simulations with experimental data % % % % % % % % % % % % % % % % % % %
    if(plotMode == 2)
        % %%
        figure
        for i = 1:38
            
            %FF01
            
            a1 = ExpData.metabolites{i};
            %         t_sim = T_FF01;
            %         c_sim = Y_FF01(:,i);
            if ~isempty(a1)
                tempFF01time = a1.time;
                tempFF01conc = a1.conc;
                %             cip = tempFF01conc(tempFF01time<400);
                %             tip = tempFF01time(tempFF01time<400);
                if isfield(a1, 'stdev')
                    tempFF01std = a1.stdev;
                else
                    tempFF01std = zeros(size(tempFF01time));
                end
                %             c_r2 = interp1(t_sim, c_sim, tip);
                %             SSE = sum((cip - c_r2).^2);
                %             SST = sum((cip - mean(cip)).^2);
                %             R2 = 1 - SSE/SST;
                %             R_matrix = corrcoef(c_r2, cip);
                %             R = R_matrix(1,2);
            else
                tempFF01time = zeros(size(ExpData.metabolites{3}.time));
                tempFF01conc = zeros(size(ExpData.metabolites{3}.conc));
                tempFF01std = zeros(size(ExpData.metabolites{3}.conc));
            end
            
            
            % plotting
            subplot(7,6,i)
            %         h1.Color = 'black';
            %plot(tempFF01time,tempFF01conc,'.')
            
            nSims = length(selResCell);
            if nSims == 1
                colArray = [0 0 0];
            else
                colArray = cool(nSims);
            end
            for j = 1:nSims
                T_FF01 = selResCell{j}.T_FF01;
                Y_FF01 = selResCell{j}.Y_FF01;
                plot(T_FF01, Y_FF01(:,i), 'Color', colArray(j,:))
                hold on
            end
            h1 = errorbar(tempFF01time,tempFF01conc,tempFF01std, ':.b','MarkerSize',10, 'DisplayName', 'exp');
            
            
            %         if i == 6
            %             plot(T_FF01, Y_FF01(:,i), 'Color', 'black')
            %         else
            %             plot(T_FF01, Y_FF01(:,i), 'Color', 'black', 'DisplayName', 'sim')
            %         end
            
            %         [T_FF01,Y_FF01,V_FF01] = simulate_FF(xSel,canelas_SS,data,dataset,setup,NumberCycles,plotflag,IC);
            %         tempSave1{i}.T_FF01 = T_FF01;
            %         tempSave1{i}.Y_FF01 = Y_FF01;
            %         tempSave1{i}.V_FF01 = V_FF01;
            
            
            
            
            %     Black line at end of feed
            plot([20 20], ylim,'k')
            hold on
            xlim([0 400])
            title(metNames{i})
            %         if ~isempty(a1)
            %             xtxt = 0.5*max(xlim);
            %             ytxt = 0.8*max(ylim);
            %             text(xtxt,ytxt, ['r^2 = ', num2str(R2, '%3.2f')])
            %             xtxt = 0.7*max(xlim);
            %             ytxt = 0.4*max(ylim);
            %             text(xtxt,ytxt, ['R = ', num2str(R, '%3.2f')])
            %         end
            
            %     figco = figure(20+i);
            %     h1 = errorbar(tempFF01time,tempFF01conc,tempFF01std); hold on
            %     plot(T_FF01, Y_FF01(:,i), 'Color', 'black')
            %     title(metNames{i})
            %     xlabel('time'); ylabel('C(mM)')
            %     titl = ['metConc', num2str(i),'.jpg'];
            %
            %
            %     % % % % saveas(figco, titl)
            %     close(figco)
        end
        sgtitle('Metabolite concentrations - last cycle'); % suptitle('Metabolite concentrations - last cycle'); DOES NOT WORK IN HUGO'S MATLAB R2021a, THEREFORE HUGO REPLACED IT WITH sgtitle
        % suptitle({'Enzymatic fluxes - last cycle','Opt. cost func. incl. UDPG, G1P, T6P & TRE(cyt+vac) w=1e-2'});
        
        
        if isfield(setup,'glycSynthDeg_separate')
            if setup.glycSynthDeg_separate == 1
                % plotting
                subplot(7,6,40)
                %         h1.Color = 'black';
                %plot(tempFF01time,tempFF01conc,'.')
                
                nSims = length(selResCell);
                colArray = cool(nSims);
                
                for j = 1:nSims
                    T_FF01 = selResCell{j}.T_FF01;
                    Y_FF01 = selResCell{j}.Y_FF01;
                    plot(T_FF01, Y_FF01(:,40), 'Color', colArray(j,:))
                    hold on
                end
                h1 = plot([0 399],[100 100], ':.b','MarkerSize',10);
                
                %     Black line at end of feed
                plot([20 20], ylim,'k')
                hold on
                xlim([0 400])
                title('glycogen')
            end
        else
        end
        
        fig = gcf;
        set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % % % % saveas(fig,'FFLastCycle_mets.jpg')
        % close
        
        if isfield(setup,'glycSynthDeg')
            if setup.glycSynthDeg == 1
                numFlu = 49;
                legenda.fluxes{49} = 'glycSynthDeg';
                ExpData.fluxes{49}.time = ExpData.fluxes{48}.time;
            else
                numFlu = 48;
            end
        else
            numFlu = 48;
        end
        
        if isfield(setup,'glycSynthDeg_separate')
            if setup.glycSynthDeg_separate == 1
                numFlu = 51;
                legenda.fluxes{49} = 'glycSynthDeg';
                legenda.fluxes{50} = 'glycSynth';
                legenda.fluxes{51} = 'glycDeg';
                ExpData.fluxes{49}.time = ExpData.fluxes{48}.time;
                ExpData.fluxes{50}.time = ExpData.fluxes{48}.time;
                ExpData.fluxes{51}.time = ExpData.fluxes{48}.time;
                
            end
        else
        end
        %     legend(legenda.metabolites)
        % % % %     legend(namesHits1)
        
        % %%
        figure
        for i = 1:numFlu
            %     for i = 1:48
            
            bl = ExpData.fluxes{i};
            %         t_sim = T_FF01;
            %         v_sim = V_FF01(:,i);
            
            
            if isfield(bl, 'rate')
                expFF01time = bl.time;
                expFF01flux = bl.rate;
                %             vip = expFF01flux(expFF01time<400);
                %             tip = expFF01time(expFF01time<400);
                %     %         v_r2_exp = interp1(tip, vip, t_sim, 'pchip','extrap');
                %     %         SSE = sum((v_r2_exp - v_sim).^2);
                %     %         SST = sum((v_r2_exp - mean(v_r2_exp)).^2);
                %             v_r2 = interp1(t_sim, v_sim, tip);
                %             SSE = sum((vip - v_r2).^2);
                %             SST = sum((vip - mean(vip)).^2);
                %             R2 = 1 - SSE/SST;
                %             R_matrix = corrcoef(v_r2, vip);
                %     %         R_matrix = corrcoef(v_sim, v_r2_exp);
                %             R = R_matrix(1,2);
                
            else
                expFF01time = zeros(size(ExpData.fluxes{3}.time));
                expFF01flux = zeros(size(ExpData.fluxes{3}.rate));
            end
            
            
            subplot(7,8,i)
            %         hold on;
            %         plot(T_FF01, V_FF01(:,i), 'Color', 'black')
            nSims = length(selResCell);
            
            if nSims == 1
                colArray = [0 0 0];
            else
                colArray = cool(nSims);
            end
            for j = 1:nSims
                T_FF01 = selResCell{j}.T_FF01;
                V_FF01 = selResCell{j}.V_FF01;
                plot(T_FF01, V_FF01(:,i), 'Color', colArray(j,:))
                hold on
            end
            if i == 50
                expFF01time = dataset.FF01.fluxes_times;
                expFF01flux = dataset.FF01.fluxes{42}';
            elseif i == 51
                expFF01time = dataset.FF01.fluxes_times;
                %             expFF01flux = dataset.FF01.fluxes{43}' - dataset.FF01.fluxes{44}';
                expFF01flux = dataset.FF01.fluxes{43}' - dataset.FF01.fluxes{44}' + dataset.FF01.fluxes{45}';
            end
            plot(expFF01time, expFF01flux,'b.:','MarkerSize',10)
            
            
            %     Black line at end of feed
            plot([20 20], ylim,'k'); hold on;
            title(legenda.fluxes{i})
            xlim([0 400])
            if isfield(bl, 'rate')
                %             xtxt = 0.5*max(xlim);
                %             ytxt = 0.8*max(ylim);
                %             text(xtxt,ytxt, ['r^2 = ', num2str(R2, '%3.2f')])
                %             xtxt = 0.7*max(xlim);
                %             ytxt = 0.4*max(ylim);
                %             text(xtxt,ytxt, ['R = ', num2str(R, '%3.2f')])
            end
            
        end
        sgtitle('Enzymatic fluxes - last cycle'); % suptitle('Enzymatic fluxes - last cycle'); DOES NOT WORK IN HUGO'S MATLAB R2021a, THEREFORE HUGO REPLACED IT WITH sgtitle
        % suptitle({'Enzymatic fluxes - last cycle','Opt. cost func. incl. UDPG, G1P, T6P & TRE(cyt+vac) w=1e-2'});
        
        fig = gcf;
        set(fig, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % % % % saveas(fig,'FFLastCycle_fluxes_exp.jpg')
        % close
        %     legend(legenda.fluxes)
        % % % %     legend(namesHits1)
        
    end

elseif ~isa(plotMode,'numeric')
    if plotMode == "2_HugoCloudt"
        
        % Plotting metabolite concentrations
        figure
        for i = 1:1:30 % Number of metabolite concentrations to plot (see "SetOutput.m")
            
            subplot(5,6,i)
            
            % Plot simulated metabolite concentrations in the created subplots
            nSims = length(selResCell);
            if nSims == 1
                maxRGBvalMSWord = 255;
                colArray = [153/maxRGBvalMSWord 51/maxRGBvalMSWord 255/maxRGBvalMSWord];
            else
                colArray = cool(nSims);
            end
            for j = 1:nSims
                T_1 = selResCell{j}.T_1;
                Y_1 = selResCell{j}.Y_HugoCloudt_1;
                if any(Y_1(:,i)) % No plotting for metabolites for which all concentrations were found to be 0
                    plot(T_1,Y_1(:,i),'Color',colArray(j,:))
                    hold on
                end
            end
            
            % Plot the measured metabolite concentrations in the created subplots
            a1 = ExpData.metabolites{i};
            
            if ~isempty(a1)
                t_exp = a1.time;
                c_exp = a1.conc;
                stdev_exp = a1.stdev;
                sterr_exp = a1.sterr;
            else
                t_exp = NaN(size(ExpData.metabolites{17}.time));
                c_exp = NaN(size(ExpData.metabolites{17}.conc));
                stdev_exp = NaN(size(ExpData.metabolites{17}.conc));
                sterr_exp = NaN(size(ExpData.metabolites{17}.conc));
            end
            
            errorbar(t_exp,c_exp,stdev_exp,':.b','MarkerSize',10,'DisplayName','exp');
            hold on
            
            % Subplot title
            title(append(metNames_HugoCloudt{i}," ","[mM]"));
            
            % Margin between highest data point and top of graph & margin between lowest data point and bottom of graph
            ylim_subplots = ylim.*[0.90 1.1];
            
            % Plot vertical grey line to indicate the end of the feed phase
            axis(cat(2,xlim,ylim_subplots)) % ensures that every vertical grey line covers the complete y-range in a subplot
            plot([20 20],ylim_subplots,'Color','#808080') % draws vertical grey line at t = 20
            xlim([0 400]);
            
        end
        sgtitle('Metabolite concentrations - last cycle');
        
        % Show that in experiments the Glyc concentration stays constant at approximately 100 mM
        if isfield(setup,'glycSynthDeg_separate')
            if setup.glycSynthDeg_separate == 1
                
                % Plot the simulated Glyc concentration
                subplot(5,6,13)
                
                % Clear subplot for Glyc & plot again
                cla reset
                
                nSims = length(selResCell);
                if nSims == 1
                    maxRGBvalMSWord = 255;
                    colArray = [153/maxRGBvalMSWord 51/maxRGBvalMSWord 255/maxRGBvalMSWord];
                else
                    colArray = cool(nSims);
                end
                for j = 1:nSims
                    T_1 = selResCell{j}.T_1;
                    Y_1 = selResCell{j}.Y_HugoCloudt_1;
                    if any(Y_1(:,13))   % No plotting when all Glyc concentrations are found to be 0
                        plot(T_1,Y_1(:,13),'Color',colArray(j,:))
                        hold on
                    end
                end
                
                % Plot Glyc = 100
                plot([1 399],[100 100],':.b','MarkerSize',10);
                hold on
                
                % Subplot title
                title(append(metNames_HugoCloudt{13}," ","[mM]"));
                
                % Margin between highest data point and top of graph & margin between lowest data point and bottom of graph
                ylim_Glycplot = ylim.*[0.99999 1+1e-5];
                
                % Plot vertical grey line to indicate the end of the feed phase
                axis(cat(2,xlim,ylim_Glycplot)) % ensures that every vertical grey line covers the complete y-range in a subplot
                plot([20 20],ylim_Glycplot,'Color','#808080') % draws vertical grey line at t = 20
                xlim([0 400])
                
            end
        end
        
        fig1 = gcf;
        set(fig1, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % exportgraphics(fig,'FFLastCycle_mets.tif')
        
        % Plotting enzymatic fluxes
        figure
        for i = 1:1:47 % Number of enzymatic fluxes to plot (see "SetOutput.m")
            
            subplot(7,7,i)
            
            % Plot simulated enzymatic fluxes in the created subplots
            nSims = length(selResCell);
            if nSims == 1
                maxRGBvalMSWord = 255;
                colArray = [153/maxRGBvalMSWord 51/maxRGBvalMSWord 255/maxRGBvalMSWord];
            else
                colArray = cool(nSims);
            end
            for j = 1:nSims
                T_1 = selResCell{j}.T_1;
                V_1 = selResCell{j}.V_HugoCloudt_1;
                if any(V_1(:,i)) % No plotting for enzymatic fluxes that were found to be 0 at every t
                    plot(T_1,V_1(:,i),'Color',colArray(j,:))
                    hold on
                end
            end
            
            % Plot the measured enzymatic fluxes in the created subplots
            if ~isempty(ExpData.fluxes)
                
                b1 = ExpData.fluxes{i};
                
                if ~isempty(b1)
                    t_exp = b1.time;
                    if isfield(b1,'rate')
                        v_exp = b1.rate;
                    else
                        v_exp = NaN;
                    end
                else
                    t_exp = NaN;
                    v_exp = NaN;
                end
                
                if i == 26
                    t_exp = dataset.FF01.fluxes_times;
                    v_exp = dataset.FF01.fluxes{42}';
                elseif i == 27
                    t_exp = dataset.FF01.fluxes_times;
                    v_exp = dataset.FF01.fluxes{43}' - dataset.FF01.fluxes{44}' + dataset.FF01.fluxes{45}';
                end
                
                plot(t_exp,v_exp,':.b','MarkerSize',10,'DisplayName','exp');
                hold on
            end
            
            % Additional subplot settings
            ax = gca; set(ax,'FontSize',7.5);
            title(append(reactNames_HugoCloudt{i}," ","[mM s^{-1}]"),'FontSize',8.5)
            
            % Margin between highest data point and top of graph & margin between lowest data point and bottom of graph
            % CANNOT GET IT CODED HERE, BECAUSE THIS REQUIRES USE OF
            % "ylim" AND DUE TO SOME REASON EVERY CODE WITH "ylim" CRASHES
            % WHEN SUBPLOT 21 IS CONSTRUCTED
            
            % Plot vertical grey line to indicate the end of the feed phase
            xline(20,'Color','#808080'); % draws vertical grey line at t = 20
            xlim([0 400]);
            
        end
        sgtitle('Enzymatic fluxes - last cycle');
        
        fig2 = gcf;
        set(fig2, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
        % exportgraphics(fig,'FFLastCycle_fluxes_exp.tif')
        
    end
end