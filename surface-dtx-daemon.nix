{stdenv, fetchurl, rustPlatform, pkgconfig, dbus}:
rustPlatform.buildRustPackage rec {
  name = "surface-dtx-daemon-${version}";
  version = "0.1.4";
  src = fetchurl {
    url = "https://github.com/linux-surface/surface-dtx-daemon/archive/v${version}.tar.gz";
    sha256 = "1h4k8js6qwdbj4y2xqiayc45jiym8zmh1l6wl85nq3i2zls3xb11";
  };

  patches = [ ./path.patch ];

  buildInputs = [ pkgconfig dbus ];

  cargoSha256 = "1jr5l3rbfpgii1y4z29rx1vwqbsf4spqyddjpiyh4w9q7y82s7pp";

  postInstall = ''
    mkdir -p $out/etc/udev/rules.d
    cp etc/udev/40-surface_dtx.rules $out/etc/udev/rules.d/

    mkdir -p $out/etc/systemd/system
    cp etc/systemd/*.service $out/etc/systemd/system/

    mkdir -p $out/etc/dbus-1/system.d
    cp etc/dbus/org.surface.dtx.conf $out/etc/dbus-1/system.d/
  '';
}
