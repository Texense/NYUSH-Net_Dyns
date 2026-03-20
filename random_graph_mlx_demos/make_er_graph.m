function G = make_er_graph(n, p, seed)
%MAKE_ER_GRAPH Generate an undirected Erdos-Renyi graph G(n,p).
%
% G = MAKE_ER_GRAPH(n, p)
% G = MAKE_ER_GRAPH(n, p, seed)

if nargin >= 3 && ~isempty(seed)
    rng(seed);
end

A = triu(rand(n) < p, 1);
[s, t] = find(A);
G = graph(s, t, [], n);
end
