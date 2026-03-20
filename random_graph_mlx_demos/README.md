# Random graph live-script demos (`.mlx`)

This package rewrites the demo set into **separate MATLAB Live Scripts** so you can run each demo on its own.

## Files to run

Open the package folder in MATLAB and run any of these files individually:

- `demo_ER_properties.mlx`
- `demo_WS_q_sweep.mlx`
- `demo_BA_growth_and_degree.mlx`
- `demo_BA_diameter_scaling.mlx`
- `demo_scalefree_fractal_uvflower.mlx`
- `demo_scalefree_robustness.mlx`
- `demo_SIS_compare_topologies.mlx`
- `demo_SIR_compare_topologies.mlx`

## Important notes

- Keep the helper `.m` files in the same folder as the `.mlx` files.
- Run each live script **from this package folder** so the helper functions are on the MATLAB path.
- I could not execute the live scripts here because this environment does **not** have MATLAB or Octave installed.

## Fallback if a packaged `.mlx` does not open cleanly

I also included plain source versions of every demo in:

- `source_scripts/`

and a MATLAB-side converter:

- `convert_all_source_scripts_to_native_mlx.m`

If needed, open MATLAB in this folder and run:

```matlab
convert_all_source_scripts_to_native_mlx
```

That will regenerate each `demo_*.mlx` directly inside your local MATLAB installation.

## Suggested classroom order

1. `demo_ER_properties.mlx`
2. `demo_WS_q_sweep.mlx`
3. `demo_BA_growth_and_degree.mlx`
4. `demo_BA_diameter_scaling.mlx`
5. `demo_scalefree_fractal_uvflower.mlx`
6. `demo_scalefree_robustness.mlx`
7. `demo_SIS_compare_topologies.mlx`
8. `demo_SIR_compare_topologies.mlx`
