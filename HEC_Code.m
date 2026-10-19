% Code for calculating constrained future SCE and its uncertainty using HEC

warning off
close all
clear
clc

% Load observed SCE mean and between-product standard deviation
load ob_ave_SCE
load ob_un_SCE

% Load simulated historical and future SCE
% Dimensions: longitude × latitude × model
% Historical and future arrays must contain the same models in the same order
load Sim_SCE_his
load Sim_SCE_future

% Determine the number of models
nModels = size(Sim_SCE_his, 3);

% Constrained future SCE mean and standard deviation
Future_SCE_ave_after_HEC = zeros(720, 360);
Future_SCE_std_after_HEC = zeros(720, 360);

for lon = 1:720
    for lat = 1:360

        x = Sim_SCE_his(lon, lat, :);
        y = Sim_SCE_future(lon, lat, :);

        uo = ob_ave_SCE(lon, lat);
        sigmao = ob_un_SCE(lon, lat);

        X = zeros(1, nModels);
        for i = 1:nModels
            X(1, i) = x(1, 1, i);
        end

        Y = zeros(1, nModels);
        for i = 1:nModels
            Y(1, i) = y(1, 1, i);
        end

        [r, m, b] = regression(X, Y);
        Corr_R = r;

        mean_x = mean(X(1, :));
        sigma_x = std(X(1, :));

        mean_y = mean(Y(1, :));
        std_y = std(Y(1, :));

        SNR1 = sigma_x^2;
        SNR2 = sigmao^2;
        SNR = SNR1 ./ SNR2;

        % Posterior mean
        Data1 = Corr_R .* std_y ./ sigma_x;
        Data2 = uo - mean_x;
        Data3 = sigma_x^2 + sigmao^2;
        Data4 = Data1 .* Data2 ./ Data3 .* sigma_x^2;

        Best_after = mean_y + Data4;

        Future_SCE_ave_after_HEC(lon, lat) = Best_after;

        % Posterior standard deviation
        val1 = 1 - Corr_R^2 ./ (1 + 1 ./ SNR);
        val2 = sqrt(val1 .* std_y^2);

        Future_SCE_std_after_HEC(lon, lat) = real(val2);

    end
end

save Future_SCE_ave_after_HEC Future_SCE_ave_after_HEC
save Future_SCE_std_after_HEC Future_SCE_std_after_HEC