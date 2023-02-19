{ stdenv
, fetchFromGitHub
, cmake
, pkg-config
, boost
, python3
, tbb
, libGL
, libGLU
, glew
, opensubdiv
, openexr
, openimageio
, opencolorio
, osl
, ptex
, xorg
}:

let
  python = python3.withPackages (p: with p; [
    jinja2
    pyopengl
    pyside2
    pyside2-tools
  ]);

in
stdenv.mkDerivation rec {
  pname = "usd";
  version = "23.02";

  src = fetchFromGitHub {
    owner = "PixarAnimationStudios";
    repo = "USD";
    rev = "5c5ebddff35012461a2b0ba773c47f05730cbab4";
    sha256 = "sha256-njgLK0bl9HfX0FfSgVOib2X1QSjQuQIjxqPpAtH4BZs=";
  };

  outputs = [ "out" "dev" ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    (boost.override { enablePython = true; inherit python; })
    python
    tbb
    libGL
    libGLU
    glew
    opensubdiv
    openexr
    openimageio
    opencolorio
    osl
    ptex
    xorg.libX11
  ];
}
