%% ---- local helper ----

function th = wrapToPi_local(theta)
% Wrap angle to [-pi, pi] without toolboxes.
    th = mod(theta + pi, 2*pi) - pi;
end