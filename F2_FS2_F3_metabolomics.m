% % PEST5_
% simplify almost all inside the cost function. Outside just the initial
% parameter set, estimation setup and later visualization

%% Initial recall
clear; close all; clc;
set_paths;
dbstop if error

% initial setup
setup.clamp10.FBP = 0;
setup.sameKm = 1;
plotflag = 0; 

% parameter set
% % load('x1_initial.mat','x1BSucr','x1AFruct')
% % x = x1BSucr;
% load('x_Y3M3_2.mat','x_Y3M3_2')
% x = x_Y3M3_2;
load('x_Y3M3_3.mat','x_Y3M3_3')
x = x_Y3M3_3;

% reference parameter set
load('pset_pE10_xres.mat','x_pE10_end'); 
xref = zeros(1,184); xref(1:165) = x_pE10_end;

% testSimulation + available experimental data
plotflag = 11; 
simulate_all
plotflag = 0;


%% extraction of experimental data
fh_1 = figure(1);
fh_3 = figure(3);
fh_5 = figure(5);
fh_7 = figure(7);
close(2)
close(4)
close(6)
close(8)
%
names = {'Glc_{ec} [mM]',... % 1 % 1
        'Fruc_{ec} [mM]',... % 2 % 1
        'Malt_{ec} [mM]',... % 3 % 1
        'Tre_{ic} [mM]',... % 4 % 1
        'T6P [mM]',... % 5 % 1
        'G6P [mM]',... % 6 % 1
        'F6P [mM]',... % 7 % 1
        'FBP [mM]',... % 8 % 1
        'DHAP [mM]',... % 9 % 1
        'GAP [mM]',... % 10 % 1
        '3PG [mM]',... % 11 % 1
        '2PG [mM]',... % 12 % 1
        'PEP [mM]',... % 13 % 1
        'ATP [mM]',... % 14 % 1
        'ADP [mM]',... % 15 % 1
        'AMP [mM]',... % 16 % 1
        'NADH [mM]',... % 17 % 1
        'NAD [mM]',... % 18 % 1
        };
nt = length(names);
data2plot = cell(4,nt);
no = length(fh_1.Children);
% loop to import each metabolite in the previous list
for i = 1:nt
    % 
    for j = 2:no % 1 was the title
        if strcmp(fh_1.Children(j).Title.String,names{i}) % if it matches
            % extract time and concentration for each metabolite
            data2plot{1,i} = [fh_1.Children(j).Children(2).XData',...
                              fh_1.Children(j).Children(2).YData'];
            data2plot{2,i} = [fh_3.Children(j).Children(2).XData',...
                              fh_3.Children(j).Children(2).YData'];
            data2plot{3,i} = [fh_5.Children(j).Children(2).XData',...
                              fh_5.Children(j).Children(2).YData'];
            data2plot{4,i} = [fh_7.Children(j).Children(2).XData',...
                              fh_7.Children(j).Children(2).YData'];
        end
    end
end
close(1)
close(3)
close(5)
close(7)


%% plotting the data in the desired way

% color
colGluc = [0 0.4470 0.7410];
colFruc = [0.8500 0.3250 0.0980];
colSucr = [0.9290 0.6940 0.1250];
colMalt = [0.4940 0.1840 0.5560];
colGluc_dark = colGluc/2;
colFruc_dark = colFruc/2;
colSucr_dark = colSucr/2;
colMalt_dark = colMalt/2;
colGluc_soft = colGluc + ([1 1 1] - colGluc)/3;
colFruc_soft = colFruc + ([1 1 1] - colFruc)/3;
colSucr_soft = colSucr + ([1 1 1] - colSucr)/3;
colMalt_soft = colMalt + ([1 1 1] - colMalt)/3;

% figures
if exist('fh_60002','var')
    clf(fh_60002)
end
fh_60002 = figure(60002);
fh_60002.Position = [1921 257 1536 747];
for i = 1:nt
    % splines
    temp1 = data2plot{1,i}(:,1); temp1_noNAN = temp1((all((~isnan(temp1)),2)),:);
    temp2 = data2plot{1,i}(:,2); temp2_noNAN = temp2((all((~isnan(temp2)),2)),:);
    temp3 = data2plot{2,i}(:,1); temp3_noNAN = temp3((all((~isnan(temp3)),2)),:);
    temp4 = data2plot{2,i}(:,2); temp4_noNAN = temp4((all((~isnan(temp4)),2)),:);
    temp5 = data2plot{3,i}(:,1); temp5_noNAN = temp5((all((~isnan(temp5)),2)),:);
    temp6 = data2plot{3,i}(:,2); temp6_noNAN = temp6((all((~isnan(temp6)),2)),:);
    temp7 = data2plot{4,i}(:,1); temp7_noNAN = temp7((all((~isnan(temp7)),2)),:);
    temp8 = data2plot{4,i}(:,2); temp8_noNAN = temp8((all((~isnan(temp8)),2)),:);
    xx = 0:10:400;
    % gluc
    sp = subplot(3,6,i);
    if((i == 10)||(i == 4)||(i == 14)||(i == 15)||(i == 16))
        psmoooth1 = 0.00001;
        psmoooth2 = 0.00001;
        psmoooth3 = 0.00001;
        psmoooth4 = 0.00001;
    elseif((i == 17)||(i == 18))
        psmoooth1 = 0.000001;
        psmoooth2 = 0.000001;
        psmoooth3 = 0.000001;
        psmoooth4 = 0.000001;
    elseif((i == 11)||(i == 12)||(i == 13))
        psmoooth1 = 0.0001;
        psmoooth2 = 0.00001;
        psmoooth3 = 0.00001;
        psmoooth4 = 0.00001;
    else
        psmoooth1 = 0.0001;
        psmoooth2 = 0.0001;
        psmoooth3 = 0.0001;
        psmoooth4 = 0.0001;
    end
    if ~isempty(temp2_noNAN)
        plot(xx,csaps(temp1_noNAN,temp2_noNAN,psmoooth1,xx),...% plot(xx,spline(temp1_noNAN,temp2_noNAN,xx),'LineWidth',1.5,'Color',colGluc)
            'LineWidth',3,'Color',colGluc_soft)
    end
    hold on
    if ~isempty(temp4_noNAN)
        plot(xx,csaps(temp3_noNAN,temp4_noNAN,psmoooth2,xx),...
            'LineWidth',3,'Color',colFruc_soft)
    end
    if ~isempty(temp6_noNAN)
        plot(xx,csaps(temp5_noNAN,temp6_noNAN,psmoooth3,xx),...
            'LineWidth',3,'Color',colSucr_soft)
    end
    if ~isempty(temp8_noNAN)
        plot(xx,csaps(temp7_noNAN,temp8_noNAN,psmoooth4,xx),...
            'LineWidth',3,'Color',colMalt_soft)
    end
    p1 = plot(data2plot{1,i}(:,1),data2plot{1,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colGluc_dark,...
        'MarkerFaceColor',colGluc);
    hold on
    % fruc
    p2 = plot(data2plot{2,i}(:,1),data2plot{2,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colFruc_dark,...
        'MarkerFaceColor',colFruc);
    % sucr
    p3 = plot(data2plot{3,i}(:,1),data2plot{3,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colSucr_dark,...
        'MarkerFaceColor',colSucr);
    % malt
    p4 = plot(data2plot{4,i}(:,1),data2plot{4,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colMalt_dark,...
        'MarkerFaceColor',colMalt);
    % adjusting y-limits
    if i == 1
        ylim([0 1])
    elseif i == 2
        ylim([0 1])
    elseif i == 3
        ylim([0 1])
    elseif i == 4
        ylim([30 90])
    elseif i == 5
        ylim([0 1.25])
    elseif i == 6
        ylim([0 8])
    elseif i == 7
        ylim([0 2])
    elseif i == 8
        ylim([0 0.8])
    elseif i == 9
        ylim([0 0.6])
    elseif i == 10
        ylim([0 0.035])
    elseif i == 11
        ylim([0 6])
    elseif i == 12
        ylim([0 0.6])
    elseif i == 13
        ylim([0 2.75])
    elseif i == 14
        ylim([2 6])
    elseif i == 15
        ylim([0 2.5])
    elseif i == 16
        ylim([0 0.6])
    elseif i == 17
        ylim([0 0.015])
    elseif i == 18
        ylim([30 60])
    end
    if i == 13 % add xlabel and ylabel for only case i == 13
       ylabel('Concentration (mM)')
       xlabel('Time (s)')
    end
    if i == 7 % legend
       legend([p1 p2 p3 p4],'Glucose','Fructose','Sucrose','Maltose')
    end
    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,erase(names{i}," [mM]"),...
        'HorizontalAlignment','Center')
    box on
end
hold off


%% experimenal data without the splines
% figures
if exist('fh_60003','var')
    clf(fh_60003)
end
fh_60003 = figure(60003);
fh_60003.Position = [1921 257 1536 747];
for i = 1:nt
    sp = subplot(3,6,i);
    % gluc
    p1 = plot(data2plot{1,i}(:,1),data2plot{1,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colGluc_dark,...
        'MarkerFaceColor',colGluc);
    hold on
    % fruc
    p2 = plot(data2plot{2,i}(:,1),data2plot{2,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colFruc_dark,...
        'MarkerFaceColor',colFruc);
    % sucr
    p3 = plot(data2plot{3,i}(:,1),data2plot{3,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colSucr_dark,...
        'MarkerFaceColor',colSucr);
    % malt
    p4 = plot(data2plot{4,i}(:,1),data2plot{4,i}(:,2),'o',...
        'MarkerSize',5,...
        'MarkerEdgeColor',colMalt_dark,...
        'MarkerFaceColor',colMalt);
    % adjusting y-limits
    if i == 1
        ylim([0 1])
    elseif i == 2
        ylim([0 1])
    elseif i == 3
        ylim([0 1])
    elseif i == 4
        ylim([30 90])
    elseif i == 5
        ylim([0 1.25])
    elseif i == 6
        ylim([0 8])
    elseif i == 7
        ylim([0 2])
    elseif i == 8
        ylim([0 0.8])
    elseif i == 9
        ylim([0 0.6])
    elseif i == 10
        ylim([0 0.035])
    elseif i == 11
        ylim([0 6])
    elseif i == 12
        ylim([0 0.6])
    elseif i == 13
        ylim([0 2.75])
    elseif i == 14
        ylim([2 6])
    elseif i == 15
        ylim([0 2.5])
    elseif i == 16
        ylim([0 0.6])
    elseif i == 17
        ylim([0 0.015])
    elseif i == 18
        ylim([30 60])
    end
    if i == 13 % add xlabel and ylabel for only case i == 13
       ylabel('Concentration (mM)')
       xlabel('Time (s)')
    end
    if i == 7 % legend
       legend([p1 p2 p3 p4],'Glucose','Fructose','Sucrose','Maltose')
    end
    % add name metabolite
    xval = sp.XLim(1) + 0.8 * (sp.XLim(2) - sp.XLim(1));
    yval = sp.YLim(1) + 0.9 * (sp.YLim(2) - sp.YLim(1));
    text(xval,yval,erase(names{i}," [mM]"),...
        'HorizontalAlignment','Center')
    box on
end
hold off


%% reaction rates plot
load('FF01sugars_rates.mat',"time_rates","rate_gluc","rate_fruc","rate_sucr","rate_malt")
% 
if exist('fh_60004','var')
    clf(fh_60004)
end
fh_60004 = figure(60004);
fh_60004.Position = [2051 707 289 248];
% splines
xx = 0:10:400;
plot(time_rates,rate_gluc,...
    'LineWidth',3,'Color',colGluc_soft)
hold on
plot(time_rates,rate_fruc,...
    'LineWidth',3,'Color',colFruc_soft)
plot(time_rates,rate_sucr,...
    'LineWidth',3,'Color',colSucr_soft)
plot(time_rates,rate_malt,...
    'LineWidth',3,'Color',colMalt_soft)
% data points
p1 = plot(time_rates,rate_gluc,'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor',colGluc_dark,...
    'MarkerFaceColor',colGluc);
hold on
% fruc
p2 = plot(time_rates,rate_fruc,'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor',colFruc_dark,...
    'MarkerFaceColor',colFruc);
% sucr
p3 = plot(time_rates,rate_sucr,'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor',colSucr_dark,...
    'MarkerFaceColor',colSucr);
% malt
p4 = plot(time_rates,rate_malt,'o',...
    'MarkerSize',6,...
    'MarkerEdgeColor',colMalt_dark,...
    'MarkerFaceColor',colMalt);
legend([p1 p2 p3 p4],'Glucose','Fructose','Sucrose','Maltose')
ylabel('Estimated sugar uptake rate (mM s^{-1})')
xlabel('Time (s)')
ylim([0 1.75])

