% Load your FIS
fis = readfis('tractor_torque_controller.fis');

% Open the FIS diagram in a standard figure window
figure('Color', 'w');
plotfis(fis);
exportgraphics(gcf, 'Figure_3_FIS_Structure.png', 'Resolution', 300);