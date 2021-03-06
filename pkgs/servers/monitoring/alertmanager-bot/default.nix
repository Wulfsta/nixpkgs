{ lib, stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  pname = "alertmanager-bot";
  version = "0.4.0";

  goPackagePath = "github.com/metalmatze/alertmanager-bot";

  src = fetchFromGitHub {
    owner = "metalmatze";
    repo = pname;
    rev = version;
    sha256 = "10v0fxxcs5s6zmqindr30plyw7p2yg0a64rdw1b2cj2mc1m3byx3";
  };

  goDeps = ./deps.nix;

  meta = with lib; {
    description = "Bot for Prometheus' Alertmanager";
    homepage = "https://github.com/metalmatze/alertmanager-bot";
    license = licenses.mit;
    maintainers = with maintainers; [ mmahut ];
  };
}
