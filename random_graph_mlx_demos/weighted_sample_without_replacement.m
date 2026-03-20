function idx = weighted_sample_without_replacement(weights, m)
%WEIGHTED_SAMPLE_WITHOUT_REPLACEMENT Weighted sampling without replacement.
%
% idx = WEIGHTED_SAMPLE_WITHOUT_REPLACEMENT(weights, m)
%
% weights must be nonnegative.

weights = double(weights(:));

if any(weights < 0)
    error('Weights must be nonnegative.');
end

if m > nnz(weights > 0)
    error('Not enough positive-weight entries to sample without replacement.');
end

idx = zeros(m, 1);

for r = 1:m
    totalWeight = sum(weights);
    if totalWeight <= 0
        error('Total weight became nonpositive during sampling.');
    end

    c = cumsum(weights);
    x = rand * totalWeight;
    j = find(c >= x, 1, 'first');

    idx(r) = j;
    weights(j) = 0;
end
end
