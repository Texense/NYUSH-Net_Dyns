function [x, ccdf] = empirical_ccdf(values)
%EMPIRICAL_CCDF Empirical complementary CDF for integer-valued data.

values = values(:);
x = unique(sort(values));
n = numel(values);

ccdf = zeros(size(x));
for i = 1:numel(x)
    ccdf(i) = sum(values >= x(i)) / n;
end
end
