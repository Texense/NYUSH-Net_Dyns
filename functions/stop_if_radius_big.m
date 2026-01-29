function [value,isterminal,direction] = stop_if_radius_big(~,z,Rmax)
% Event: stop integration if radius exceeds Rmax.
    r = hypot(z(1),z(2));
    value = Rmax - r;      % stop when value=0 (r=Rmax)
    isterminal = 1;
    direction = -1;
end