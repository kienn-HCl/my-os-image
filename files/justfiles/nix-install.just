nix-install:
    test -e /var/nix || sudo mkdir /var/nix
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install ostree --persistence=/var/nix
