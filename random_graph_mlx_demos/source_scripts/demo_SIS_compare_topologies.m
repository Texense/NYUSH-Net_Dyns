%% SIS dynamics on ER, small-world, and BA networks
% Run this live script from the package folder so the helper functions are on the MATLAB path.
clearvars; close all; clc;

%DEMO_SIS_COMPARE_TOPOLOGIES SIS dynamics on ER / WS / BA graphs.
%
% Uses a discrete-time synchronous approximation:
%   S -> I with probability 1 - (1-beta)^m where m is the number of infected neighbors
%   I -> S with probability mu

rng(6);

n = 1000;
kbar = 6;

Ger = make_er_graph(n, kbar / (n - 1));
Gws = make_ws_graph(n, kbar / 2, 0.05);
Gba = make_ba_graph(n, 5, kbar / 2);

fprintf('\nAverage degrees:\n');
fprintf('  ER: %.2f\n', mean(degree(Ger)));
fprintf('  WS: %.2f\n', mean(degree(Gws)));
fprintf('  BA: %.2f\n', mean(degree(Gba)));

%% Time series at one parameter choice
beta = 0.05;
mu = 0.20;
Tmax = 150;
runs = 15;
seedFrac = 0.01;

Ier = zeros(Tmax + 1, runs);
Iws = zeros(Tmax + 1, runs);
Iba = zeros(Tmax + 1, runs);

for r = 1:runs
    Ier(:, r) = simulate_SIS_discrete(Ger, beta, mu, Tmax, seedFrac, 'random');
    Iws(:, r) = simulate_SIS_discrete(Gws, beta, mu, Tmax, seedFrac, 'random');
    Iba(:, r) = simulate_SIS_discrete(Gba, beta, mu, Tmax, seedFrac, 'random');
end

figure('Name', 'SIS prevalence over time');
plot(0:Tmax, mean(Ier, 2), 'LineWidth', 1.8);
hold on;
plot(0:Tmax, mean(Iws, 2), 'LineWidth', 1.8);
plot(0:Tmax, mean(Iba, 2), 'LineWidth', 1.8);
hold off;
xlabel('time step');
ylabel('infected fraction');
title(sprintf('SIS time series, beta = %.2f, mu = %.2f', beta, mu));
legend('ER', 'WS', 'BA', 'Location', 'best');
grid on;

%% Approximate endemic prevalence versus beta
betaVals = linspace(0.01, 0.12, 10);
rhoER = zeros(size(betaVals));
rhoWS = zeros(size(betaVals));
rhoBA = zeros(size(betaVals));

Tburn = 250;
tailWindow = 50;
runsSweep = 8;

for i = 1:numel(betaVals)
    b = betaVals(i);

    tmpER = 0;
    tmpWS = 0;
    tmpBA = 0;

    for r = 1:runsSweep
        I = simulate_SIS_discrete(Ger, b, mu, Tburn, seedFrac, 'random');
        tmpER = tmpER + mean(I(end-tailWindow+1:end));

        I = simulate_SIS_discrete(Gws, b, mu, Tburn, seedFrac, 'random');
        tmpWS = tmpWS + mean(I(end-tailWindow+1:end));

        I = simulate_SIS_discrete(Gba, b, mu, Tburn, seedFrac, 'random');
        tmpBA = tmpBA + mean(I(end-tailWindow+1:end));
    end

    rhoER(i) = tmpER / runsSweep;
    rhoWS(i) = tmpWS / runsSweep;
    rhoBA(i) = tmpBA / runsSweep;
end

figure('Name', 'SIS endemic prevalence vs infection rate');
plot(betaVals / mu, rhoER, 'o-', 'LineWidth', 1.8, 'MarkerSize', 7);
hold on;
plot(betaVals / mu, rhoWS, 's-', 'LineWidth', 1.8, 'MarkerSize', 7);
plot(betaVals / mu, rhoBA, 'd-', 'LineWidth', 1.8, 'MarkerSize', 7);
hold off;
xlabel('effective infection rate \lambda = \beta / \mu');
ylabel('approx. endemic prevalence');
title('SIS: topology changes the onset and steady prevalence');
legend('ER', 'WS', 'BA', 'Location', 'best');
grid on;

fprintf('\nSIS demo finished.\n');
fprintf('With the same approximate mean degree, the topology still matters.\n');
fprintf('BA typically sustains infection more easily because hubs amplify transmission.\n\n');
