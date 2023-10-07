{
  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];

  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
  # Enable WireGuard
  networking.wireguard.interfaces = {
    # "wg0" is the network interface name. You can name the interface arbitrarily.
    wg-mlvd = {
      # Determines the IP address and subnet of the client's end of the tunnel interface.
      ips = [ "10.64.223.152/32" ];
      listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

      # Path to the private key file.
      #
      # Note: The private key can also be included inline via the privateKey option,
      # but this makes the private key world-readable; thus, using privateKeyFile is
      # recommended.
      privateKeyFile = "/home/user/.config/mlvd/private_key";

      peers = [
        {
          # Public key of the server (not a file path).
          publicKey = "+Xx2mJnoJ+JS11Z6g8mp6aUZV7p6DAN9ZTAzPaHakhM=";

          # Forward all the traffic via VPN.
          allowedIPs = [ "0.0.0.0/0" ];

          # Set this to the server IP and port.
          endpoint = "87.249.134.1:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

          # As recommended by mlvd
          persistentKeepalive = 0;
        }
      ];
    };
  };
}

