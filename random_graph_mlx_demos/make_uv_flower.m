function G = make_uv_flower(u, v, generation)
%MAKE_UV_FLOWER Generate a deterministic (u,v)-flower scale-free network.
%
% G = MAKE_UV_FLOWER(u, v, generation)
%
% Generation 1 is a cycle of length u + v.
% Each later generation replaces every edge by two parallel paths:
% one of length u and one of length v.
%
% For u > 1 these networks are fractal / finite-dimensional.
% For u = 1 they are transfractal / small-world.

if generation < 1 || floor(generation) ~= generation
    error('generation must be a positive integer.');
end
if u < 1 || v < 1 || floor(u) ~= u || floor(v) ~= v
    error('u and v must be positive integers.');
end

% Generation 1: cycle with u+v nodes.
n0 = u + v;
s = (1:n0).';
t = [2:n0 1].';
G = graph(s, t);

nextNode = n0 + 1;

for g = 2:generation
    oldEdges = G.Edges.EndNodes;
    sNew = [];
    tNew = [];

    for e = 1:size(oldEdges, 1)
        a = oldEdges(e, 1);
        b = oldEdges(e, 2);

        [sPathU, tPathU, nextNode] = make_path_between(a, b, u, nextNode);
        [sPathV, tPathV, nextNode] = make_path_between(a, b, v, nextNode);

        sNew = [sNew; sPathU; sPathV]; %#ok<AGROW>
        tNew = [tNew; tPathU; tPathV]; %#ok<AGROW>
    end

    G = graph(sNew, tNew);
end
end

function [s, t, nextNode] = make_path_between(a, b, L, nextNode)
% Helper: create one path of length L between a and b.

if L == 1
    s = a;
    t = b;
    return;
end

internal = nextNode:(nextNode + L - 2);
nextNode = nextNode + L - 1;

nodes = [a internal b];
s = nodes(1:end-1).';
t = nodes(2:end).';
end
