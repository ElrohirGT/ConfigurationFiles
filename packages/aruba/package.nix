{
  stdenv,
  fetchurl,
  dpkg,
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
    echo Current: $(ls)
    mkdir -p $out

    mv lib "$out/lib"
    mv usr/bin "$out/bin"
    mv usr/share "$out/share"

    runHook postInstall
    echo "Final: $out"
  '';
}
