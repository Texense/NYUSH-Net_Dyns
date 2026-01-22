function plot_branch(r, xbranch, fprime)
% Plot a branch of equilibria with stability based on f'(x*).
% Inputs:
%   r      : parameter vector
%   xbranch: equilibrium values (NaN where not defined)
%   fprime : derivative f_x evaluated on xbranch (same size as r)
%
% Convention:
%   stable if fprime < 0  (solid)
%   unstable if fprime > 0 (dashed)

    valid = ~isnan(xbranch);
    r = r(valid);
    xbranch = xbranch(valid);
    fprime = fprime(valid);

    if isempty(r), return; end

    stable = fprime < 0;
    if any(stable)
        plot(r(stable), xbranch(stable), 'LineWidth',2);
    end
    if any(~stable)
        plot(r(~stable), xbranch(~stable), '--', 'LineWidth',2);
    end
end

function out = ternary(cond, a, b)
% Simple ternary helper for printing.
    if cond, out = a; else, out = b; end
end
