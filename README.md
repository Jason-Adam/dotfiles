# Dot Files  
Repository for setting up my development enviornment on a new Mac.  

## Install  
The full install can be handled by Nix.  

Install Nix with the following command:  

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Add Nix Channels:  

```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixos-21.11
```

Clone the repo:  

```sh
git clone https://github.com/Jason-Adam/dotfiles.git
```

From within the `dotfiles` folder:

```sh
./syms.sh
./hooks.sh
```

Init Home Manager:  

```sh
nix-shell '<home-manager>' -A install
```

## Manual Installs Still to Automate  
* Keeper Password  
* Alfred  
* Rectangle  
* Brave Browser
