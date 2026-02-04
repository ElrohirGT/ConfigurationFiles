{
  lib,
  stdenv,
  fetchurl,
  dpkg,
  qt5,
}:
stdenv.mkDerivation {
  name = "hpe-aruba-networking";
  version = "1.6.0";

  src = fetchurl {
    url = "https://h30326.www3.hpe.com/hpn/Aruba_Onboard_Installer.deb?merchantId=ASP_DROPBOX";
    hash = "sha256-Ujx613JBaq7ozABu7fHT9s4As4/hUN92S2gG1Y+KpHs=";
  };

  buildInputs = [dpkg];

  unpackCmd = ''
    dpkg-deb -R "$curSrc" debPkg
  '';

  installPhase = ''
    		runHook preInstall

    		echo Current: "$(ls)"
    		mkdir -p "$out"

    # Do not install the onboard-srv systemd
    # service mv lib "$out/lib"
    		mv usr/share/aruba-onboard/bin "$out/bin"
    		mv usr/share "$out/share"

    		echo "Fixing desktop shortcut..."
    		CURRENT="\/usr\/share\/aruba-onboard\/bin\/onboard-ui %u"
    		REPLACE="\/run\/current-system\/sw\/bin\/onboard-ui %u"
    		sed -i "s/$CURRENT/$REPLACE/g" "$out/share/applications/onboard-launcher.desktop"

    		echo "Final: $out"

    		runHook postInstall
  '';

  preFixup = let
    # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
    libPath = lib.makeLibraryPath [
      qt5.qtbase # libQt5PrintSupport.so.5
      qt5.qtsvg # libQt5Svg.so.5
      stdenv.cc.cc.lib # libstdc++.so.6
    ];
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/bin/onboard-ui

    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/bin/onboard-cli

    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/bin/onboard-srv
  '';
}
