function [meanPathLength, diameterValue, H] = path_length_stats(G, useLargestComponent)
%PATH_LENGTH_STATS Mean shortest path length and diameter.
%
% [L, D, H] = PATH_LENGTH_STATS(G)
% [L, D, H] = PATH_LENGTH_STATS(G, useLargestComponent)
%
% If useLargestComponent is true, statistics are computed on the largest
% connected component.

if nargin < 2
    useLargestComponent = true;
end

if useLargestComponent
    [H, ~] = giant_component_subgraph(G);
else
    H = G;
end

if numnodes(H) <= 1
    meanPathLength = 0;
    diameterValue = 0;
    return;
end

D = distances(H);
vals = D(isfinite(D) & D > 0);

if isempty(vals)
    meanPathLength = 0;
    diameterValue = 0;
else
    meanPathLength = mean(vals);
    diameterValue = max(vals);
end
end
