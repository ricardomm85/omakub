# OpenVPN is a open-source VPN software that enables secure connections

install_dependencies() {
    sudo apt install -y openvpn network-manager-openvpn-gnome
}

import_ovpn_to_networkmanager() {
    i=1
    while [ $i -le 3 ]; do
        ovpn_path=$(gum input --prompt "Enter the full path to your .ovpn file: " --placeholder "/path/to/your/config.ovpn")
        if [ -f "$ovpn_path" ]; then
            gum style --foreground 2 "File found. Importing the configuration to NetworkManager..."
            connection_name=$(basename "$ovpn_path" .ovpn)
            if sudo nmcli connection import type openvpn file "$ovpn_path"; then
                gum style --foreground 2 "VPN configuration '$connection_name' has been successfully imported to NetworkManager."
                gum style --foreground 2 "NOTE: Go to VPN > Settings > '$connection_name' > Disable Automatic DNS > Add: 172.31.0.2, 1.1.1.1, 8.8.8.8"
                return 0
            else
                gum style --foreground 1 "Failed to import the VPN configuration. Please check the file and try again."
            fi
        else
            gum style --foreground 1 "Error: File not found at the specified path. Please check the path and try again."
        fi
        i=$((i + 1))
    done
    gum style --foreground 1 "Failed to provide a valid file path after 3 attempts. Exiting."
    return 1
}

# Main script
gum style \
    --foreground 4 --border-foreground 4 --border double \
    --align center --width 50 --margin "1 2" --padding "2 4" \
    'Welcome to the OpenVPN setup script!'

if gum confirm "Do you want to configure an OpenVPN connection?"; then
    install_dependencies
    import_ovpn_to_networkmanager
else
    gum style --foreground 3 "OpenVPN configuration cancelled."
fi
