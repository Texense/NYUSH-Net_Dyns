function G = make_ba_graph(n, m0, m, seed)
%MAKE_BA_GRAPH Generate a Barabasi-Albert preferential-attachment graph.
%
% G = MAKE_BA_GRAPH(n, m0, m)
% G = MAKE_BA_GRAPH(n, m0, m, seed)
%
% - Start from a complete graph on m0 nodes.
% - Add one node at a time.
% - Each new node connects to m existing nodes with probability proportional
%   to their current degree.
%
% Typical choice: m0 >= m >= 1.

if nargin >= 4 && ~isempty(seed)
    rng(seed);
end

if m0 < m
    error('Need m0 >= m.');
end
if n < m0
    error('Need n >= m0.');
end

A = sparse(n, n);

% Initial complete graph on m0 nodes.
for i = 1:(m0 - 1)
    A(i, (i+1):m0) = 1;
end
A = A + A.';
deg = full(sum(A, 2));

for newNode = (m0 + 1):n
    targets = weighted_sample_without_replacement(deg(1:newNode-1), m);

    A(newNode, targets) = 1;
    A(targets, newNode) = 1;

    deg(targets) = deg(targets) + 1;
    deg(newNode) = m;
end

[s, t] = find(triu(A, 1));
G = graph(s, t, [], n);
end
