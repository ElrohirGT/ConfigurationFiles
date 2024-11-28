{lib, ...}:
with lib; let
  # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
  getDir = dir:
    mapAttrs
    (
      file: type:
        if type == "directory"
        then getDir "${dir}/${file}"
        else type
    )
    (builtins.readDir dir);

  # Collects all files of a directory as a list of strings of paths
  files = dir: collect isString (mapAttrsRecursive (path: _type: concatStringsSep "/" path) (getDir dir));

  # Filters out directories that don't end with .nix or are this file, also makes the strings absolute
  validFiles = dir:
    map
    (file: "${dir}/${file}")
    (
      filter
      (file: let
        fileIsNixFile = hasSuffix ".nix" file;
        fileIsNotCustomPlugin = !(hasSuffix ".plugin.nix" file);
        fileIsNotModuleIndex = file != "default.nix";
        fileIsNotMinimalConfig = file != "minimal.nix";
      in
        fileIsNixFile && fileIsNotCustomPlugin && fileIsNotModuleIndex && fileIsNotMinimalConfig)
      (files dir)
    );
in {
  # Imports everything...
  # imports = (validFiles ./elements) ++ (validFiles ./atoms);
  # imports = debug.traceValSeq (validFiles ./.);
  imports = validFiles ./.;
}
