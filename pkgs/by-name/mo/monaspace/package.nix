{ lib, stdenvNoCC, fetchFromGitHub, xorg }:
let 
  pname = "monaspace";
  version = "1.000";
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "githubnext";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Zo56r0QoLwxwGQtcWP5cDlasx000G9BFeGINvvwEpQs=";
  };

  nativeBuildInputs = [ xorg.mkfontdir ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts

    mv fonts/otf      $out/share/fonts/opentype
    mv fonts/variable $out/share/fonts/variable
    mv fonts/webfonts $out/share/fonts/woff

    mkfontdir $out/share/fonts

    runHook postInstall
  '';

  meta = with lib; {
    description = "An innovative superfamily of fonts for code";
    homepage = "https://monaspace.githubnext.com/";
    license = licenses.ofl;
    maintainers = with maintainers; [ mehbark ];
    platforms = platforms.all;
  };
}

