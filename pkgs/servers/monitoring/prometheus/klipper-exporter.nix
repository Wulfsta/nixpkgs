{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nixosTests,
}:

buildGoModule rec {
  pname = "prometheus-klipper-exporter";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "Wulfsta";
    repo = pname;
    rev = "e6c830d4f40edf8443d4cc9bc648f58e6759849c";
    sha256 = "sha256-DOwfvyg2KAqGLxrNT2oS/juj6Tbtacma/WN3jNAyl3E=";
  };

  vendorHash = "sha256-0nbLHZ2WMLMK0zKZuUYz355K01Xspn9svmlFCtQjed0=";

  doCheck = true;

  passthru.tests = {
    inherit (nixosTests.prometheus-exporters) process;
  };

  meta = with lib; {
    description = " Prometheus Exporter for Klipper ";
    homepage = "https://github.com/scross01/prometheus-klipper-exporter";
    license = licenses.mit;
    maintainers = with maintainers; [ wulfsta ];
    platforms = platforms.linux;
  };
}
