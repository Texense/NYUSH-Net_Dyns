function G = make_ws_graph(n, K, beta, seed)
%MAKE_WS_GRAPH Generate a Watts-Strogatz small-world graph.
%
% Each node starts connected to K neighbors on each side of a ring lattice,
% so the degree is 2*K when beta = 0.
%
% G = MAKE_WS_GRAPH(n, K, beta)
% G = MAKE_WS_GRAPH(n, K, beta, seed)

if nargin >= 4 && ~isempty(seed)
    rng(seed);
end

if K >= n/2
    error('K must satisfy K < n/2.');
end

A = sparse(n, n);

% Ring lattice initialization.
for k = 1:K
    i = (1:n).';
    j = mod(i - 1 + k, n) + 1;
    A = A + sparse(i, j, 1, n, n);
    A = A + sparse(j, i, 1, n, n);
end
A = spones(A);

% Rewire each "clockwise" edge with probability beta.
for i = 1:n
    for k = 1:K
        j = mod(i - 1 + k, n) + 1;

        if A(i, j) && rand < beta
            % Remove current edge.
            A(i, j) = 0;
            A(j, i) = 0;

            nbrs = find(A(i, :));
            forbidden = false(1, n);
            forbidden(i) = true;
            forbidden(nbrs) = true;

            candidates = find(~forbidden);
            if isempty(candidates)
                % Restore original edge if no alternative exists.
                A(i, j) = 1;
                A(j, i) = 1;
            else
                newj = candidates(randi(numel(candidates)));
                A(i, newj) = 1;
                A(newj, i) = 1;
            end
        end
    end
end

[s, t] = find(triu(A, 1));
G = graph(s, t, [], n);
end
