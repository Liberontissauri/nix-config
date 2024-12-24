useful command: CHECK IF THE DISK IS RIGHT

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode mount ./nixos/disko.nix --arg device '"/dev/sdc"'