function convert_all_source_scripts_to_native_mlx
%CONVERT_ALL_SOURCE_SCRIPTS_TO_NATIVE_MLX Rebuild the demo live scripts from source .m files.
%
% This is a fallback helper for cases where the packaged .mlx files do not
% open cleanly on a particular MATLAB release. It recreates each live script
% from the corresponding file in source_scripts/ using MATLAB's Live Editor.
%
% Usage:
%   1) Open MATLAB in the package folder.
%   2) Run:
%         convert_all_source_scripts_to_native_mlx
%   3) Open any demo_*.mlx file and run it.
%
% Note: this uses MATLAB's internal Live Editor API.

pkgRoot = fileparts(mfilename('fullpath'));
srcDir = fullfile(pkgRoot, 'source_scripts');
if ~isfolder(srcDir)
    error('Source folder not found: %s', srcDir);
end

srcFiles = dir(fullfile(srcDir, 'demo_*.m'));
if isempty(srcFiles)
    error('No source demo scripts found in %s', srcDir);
end

for k = 1:numel(srcFiles)
    srcPath = fullfile(srcFiles(k).folder, srcFiles(k).name);
    txt = fileread(srcPath);
    matlab.internal.liveeditor.openAsLiveCode(txt);
    activeDoc = matlab.desktop.editor.getActive();

    [~, base] = fileparts(srcFiles(k).name);
    outPath = fullfile(pkgRoot, [base '.mlx']);
    activeDoc.saveAs(outPath);
    activeDoc.close();

    fprintf('Created %s\n', outPath);
end
end
