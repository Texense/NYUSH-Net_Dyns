function [Sfrac, Ifrac, Rfrac] = simulate_SIR_discrete(G, beta, mu, Tmax, seedFrac, seedType, seed)
%SIMULATE_SIR_DISCRETE Discrete-time SIR simulation on a static graph.
%
% States:
%   0 = susceptible
%   1 = infected
%   2 = removed / recovered

if nargin < 7 || isempty(seed)
    % no-op
else
    rng(seed);
end

if nargin < 6 || isempty(seedType)
    seedType = 'random';
end
if nargin < 5 || isempty(seedFrac)
    seedFrac = 0.01;
end

n = numnodes(G);
A = spones(adjacency(G));

k0 = max(1, round(seedFrac * n));
state = zeros(n, 1);

switch lower(seedType)
    case 'random'
        state(randperm(n, k0)) = 1;
    case 'hub'
        [~, ord] = sort(degree(G), 'descend');
        state(ord(1:k0)) = 1;
    otherwise
        error('Unknown seedType. Use ''random'' or ''hub''.');
end

Sfrac = zeros(Tmax + 1, 1);
Ifrac = zeros(Tmax + 1, 1);
Rfrac = zeros(Tmax + 1, 1);

Sfrac(1) = mean(state == 0);
Ifrac(1) = mean(state == 1);
Rfrac(1) = mean(state == 2);

for t = 1:Tmax
    infected = (state == 1);
    susceptible = (state == 0);

    infectedNbrs = full(A * double(infected));
    pInf = 1 - (1 - beta) .^ infectedNbrs;

    newInf = susceptible & (rand(n, 1) < pInf);
    recov = infected & (rand(n, 1) < mu);

    state(recov) = 2;
    state(newInf) = 1;

    Sfrac(t + 1) = mean(state == 0);
    Ifrac(t + 1) = mean(state == 1);
    Rfrac(t + 1) = mean(state == 2);

    if ~any(state == 1)
        Sfrac((t + 2):end) = Sfrac(t + 1);
        Ifrac((t + 2):end) = 0;
        Rfrac((t + 2):end) = Rfrac(t + 1);
        break;
    end
end
end
