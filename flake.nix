{
  description = "Supernote Inkflow for Wayland via libinput quirks and hwdb";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (system: {
      nixosModules.supernoteWaylandFix = {
        config = {
          environment.etc."libinput/local-overrides.quirks".text = ''
            [Supernote Supernote Nomad]
            MatchVendor=0x2207
            MatchProduct=0x07
            AttrEventCode=+BTN_STYLUS
            AttrPressureRange=197:194
          '';

          services.udev.extraHwdb = ''
            evdev:input:b0003v2207p0007*
             EVDEV_ABS_00=::20
             EVDEV_ABS_01=::20
          '';
        };
      };
    });
}
