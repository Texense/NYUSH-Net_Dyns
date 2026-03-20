function c = local_clustering_coefficients(G)
%LOCAL_CLUSTERING_COEFFICIENTS Local clustering coefficient for each node.
%
% c(i) = number of edges among neighbors of i / maximum possible such edges.

A = spones(adjacency(G));
n = size(A, 1);
deg = full(sum(A, 2));

c = zeros(n, 1);

for i = 1:n
    k = deg(i);

    if k < 2
        c(i) = 0;
        continue;
    end

    nbr = find(A(i, :));
    subA = A(nbr, nbr);
    e = nnz(triu(subA, 1));

    c(i) = 2 * e / (k * (k - 1));
end
end
