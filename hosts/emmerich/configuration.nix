# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, ... }:

let

  hostname = "emmerich";
  # supports laptop and desktop
  platform = "desktop";

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # base host configuration
      (inputs.self + /modules/base-configuration/default.nix)
      # platform specific configuration
      (inputs.self + /modules/platform/${platform}.nix)
      # use sway
      (inputs.self + /modules/sway/${hostname}.nix)
      # use our wallpapers
      (inputs.self + /modules/wallpapers/default.nix)
      # use zsh4humans
      (inputs.self + /modules/zsh/default.nix)
      # use alacritty
      (inputs.self + /modules/alacritty/${platform}.nix)
      # general application configs
      (inputs.self + /modules/applications/default.nix)
      (inputs.self + /modules/applications/heavy.nix)
      (inputs.self + /modules/applications/syncthing.nix)
      (inputs.self + /modules/applications/zoom.nix)
    ];

  networking.hostName = "${hostname}"; # Define your hostname.

}
