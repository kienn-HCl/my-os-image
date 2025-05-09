nix-install:
    curl --proto '=https' --tlsv1.2 -sSf -L https://github.com/DeterminateSystems/nix-installer/releases/download/v0.35.0/nix-installer.sh | sh -s -- install ostree --no-confirm
