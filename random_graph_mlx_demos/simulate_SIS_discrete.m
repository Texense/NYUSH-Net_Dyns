function Ifrac = simulate_SIS_discrete(G, beta, mu, Tmax, seedFrac, seedType, seed)
%SIMULATE_SIS_DISCRETE Discrete-time SIS simulation on a static graph.
%
% Infection rule:
%   susceptible node with m infected neighbors becomes infected with
%   probability 1 - (1-beta)^m
%
% Recovery rule:
%   infected node recovers (becomes susceptible again) with probability mu
%
% Ifrac(t) is the infected fraction at time t-1.

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
infected = false(n, 1);

switch lower(seedType)
    case 'random'
        infected(randperm(n, k0)) = true;
    case 'hub'
        [~, ord] = sort(degree(G), 'descend');
        infected(ord(1:k0)) = true;
    otherwise
        error('Unknown seedType. Use ''random'' or ''hub''.');
end

Ifrac = zeros(Tmax + 1, 1);
Ifrac(1) = mean(infected);

for t = 1:Tmax
    infectedNbrs = full(A * double(infected));
    pInf = 1 - (1 - beta) .^ infectedNbrs;

    newInf = (~infected) & (rand(n, 1) < pInf);
    recov = infected & (rand(n, 1) < mu);

    infected = (infected & ~recov) | newInf;
    Ifrac(t + 1) = mean(infected);
end
end
