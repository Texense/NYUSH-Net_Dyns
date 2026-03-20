function frac = largest_component_fraction_after_removal(G, removedNodes)
%LARGEST_COMPONENT_FRACTION_AFTER_REMOVAL Relative size of largest component.
%
% frac is measured relative to the ORIGINAL graph size numnodes(G).

n = numnodes(G);

if isempty(removedNodes)
    bins = conncomp(G);
    compSizes = accumarray(bins.', 1);
    frac = max(compSizes) / n;
    return;
end

keep = true(n, 1);
keep(removedNodes) = false;

if ~any(keep)
    frac = 0;
    return;
end

H = subgraph(G, find(keep));
bins = conncomp(H);
compSizes = accumarray(bins.', 1);
frac = max(compSizes) / n;
end
