function [H, idx, componentSizes] = giant_component_subgraph(G)
%GIANT_COMPONENT_SUBGRAPH Extract the largest connected component.

bins = conncomp(G);
componentSizes = accumarray(bins.', 1);
[~, giantID] = max(componentSizes);

idx = find(bins == giantID);
H = subgraph(G, idx);
end
