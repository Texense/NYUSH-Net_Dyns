function run_all_demos_mlx
%RUN_ALL_DEMOS_MLX Open and run each live script separately from the package root.
%
% This helper simply opens each .mlx file name in the current folder.
% You can also open any one of them manually and click Run.

liveFiles = {
    'demo_ER_properties.mlx'
    'demo_WS_q_sweep.mlx'
    'demo_BA_growth_and_degree.mlx'
    'demo_BA_diameter_scaling.mlx'
    'demo_scalefree_fractal_uvflower.mlx'
    'demo_scalefree_robustness.mlx'
    'demo_SIS_compare_topologies.mlx'
    'demo_SIR_compare_topologies.mlx'
    };

disp('Open these files one by one and press Run in the Live Editor:');
disp(string(liveFiles));
end
