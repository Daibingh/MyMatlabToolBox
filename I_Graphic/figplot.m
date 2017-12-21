function figplot(x,y,XLabel,YLabel)
%figplot(x,y,XLabel,YLabel)
FigurePosition = [12 5 15 12]; 
set(gcf, ...
'Units', 'centimeters', ...        % [ inches | centimeters | normalized | points | {pixels} | characters ]
'Position',FigurePosition, ...
'PaperPositionMode','auto');        % ATTENTION: if PaperPositionMode is not 'auto' the saved file could have different dimensions from the one shown on the screen!
%------------------------------------------------------------------------------------------------------------------------------------------------------------
% set axis property
% general properties
FontSize = 12;
FontUnit = 'points'; % [{points} | normalized | inches | centimeters | pixels]
FontName = 'Times'; % [Times | Courier | ] TODO complete the list
FontWeight = 'normal'; % [light | {normal} | demi | bold]
FontAngle = 'normal'; % [{normal} | italic | oblique] ps: only for axes
Interpreter = 'latex'; % [{tex} | latex]
LineWidth = 2.0; % width of the line of the axes

set(gca, ...
'Units','normalized', ...
'Position',[0.15 0.2 0.75 0.7], ...
'XGrid', 'off', ... [on | {off}]
'YGrid', 'off', ... [on | {off}]
'GridLineStyle', ':', ... [- | -- | {:} | -. | none]
'XMinorGrid', 'off' , ... [on | {off}]
'YMinorGrid', 'off', ... [on | {off}]
'MinorGridLineStyle', ':', ... [- | -- | {:} | -. | none]
...
'XMinorTick', 'off' , ... [on | {off}]
'YMinorTick', 'off', ... [on | {off}]
'TickDir', 'out', ... [{in} | out] inside or outside (for 2D)
'TickLength', [.01 .01], ... length of the ticks
...
'XColor', [.1 .1 .1], ... color of x axis
'YColor', [.1 .1 .1], ... color of y axis
'XAxisLocation', 'bottom', ... where labels have to be printed [top | {bottom}]
'YAxisLocation', 'left', ... where labels have to be printed [left | {right}]
'XDir', 'normal', ... axis increasement direction [{normal} | reverse]
'YDir', 'normal', ... axis increasement direction [{normal} | reverse]
...
'FontName', FontName, ... kind of fonts of labels
'FontSize', FontSize, ... size of fonts of labels
'FontUnits', FontUnit, ... units of the size of fonts
'FontWeight', FontWeight, ... weight of fonts of labels
'FontAngle', FontAngle, ... inclination of fonts of labels
...
'LineWidth', LineWidth); % width of the line of the axes
%以下单独设置，若不想设置注释即可
%
% set(gca, ...
% 'XLim', [-10 10], ... 
% 'YLim', [-1.2 1.2])   
% set(gca, ...
% 'XTickLabel', { }, ...
% 'YTickLabel', { })
% set(gca, ...
% 'XTick', -10:10, ... 
% 'YTick', 0:.2:1.2)
%--------------------------------------------------------------------------------------------------------------------------------------------------------------
% set axis labels
%
% fonts properties
FontSize = 20;
FontUnit = 'points'; % [{points} | normalized | inches | centimeters | pixels]
FontName = 'Times'; % [Times | Courier | ] TODO complete the list
FontWeight = 'normal'; % [light | {normal} | demi | bold]
FontAngle = 'normal'; % [{normal} | italic | oblique] ps: only for axes
Interpreter = 'latex'; % [{tex} | latex]
%
% XLabel = 'label of x axis';
% YLabel = 'label of y axis';
%
XLabelRotation = 0.0;
YLabelRotation = 90.0;
xlabel( XLabel, ...
'FontName', FontName, ...
'FontUnit', FontUnit, ...
'FontSize', FontSize, ...
'FontWeight', FontWeight, ...
'Interpreter', Interpreter);
%
ylabel( YLabel, ...
'FontName', FontName, ...
'FontUnit', FontUnit, ...
'FontSize', FontSize, ...
'FontWeight', FontWeight, ...
'Interpreter', Interpreter);
%
set(get(gca, 'XLabel'), 'Rotation', XLabelRotation);
set(get(gca, 'YLabel'), 'Rotation', YLabelRotation);
% in order to make matlab to do not "cut" latex-interpreted axes labels
set(gca, 'Units', 'normalized', ...
'Position', [0.15 0.2 0.75 0.7]);
%------------------------------------------------------------------------------------------------------------------------------------------------------------------------
% set plots properties
%
% we want to plot several curves
hold on;
%
plot( ...
x, ...
y, ...
'LineStyle', '-', ... [ -.| : | - | -- ]
'LineWidth', 1.2, ...
'Color', [1 0 0], ...
'Marker', 'diamond', ... [ + | o | * | . | x | square | diamond | > | < | ^ | v | pentagram | hexagram | {none}]
'MarkerSize', 2, ...
'MarkerFaceColor', [0 1 0], ...
'MarkerEdgeColor', [0 1 0]);
end
