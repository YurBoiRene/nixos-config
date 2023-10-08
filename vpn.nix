
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  # Enable WireGuard
  networking.wg-quick.interfaces = {
    wg-mlvd = {
      address = [ "10.64.223.152/32" ];
      listenPort = 51820;
      privateKeyFile = "/home/user/.config/mlvd/private_key";

      peers = [
        {
          publicKey = "+Xx2mJnoJ+JS11Z6g8mp6aUZV7p6DAN9ZTAzPaHakhM=";
          # Forward all the traffic
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "87.249.134.1:51820";
          persistentKeepalive = 0;
        }
      ];
    };
  };
}

