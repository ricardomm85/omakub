if [ -f ~/.ssh/config ]; then
    gum style --foreground 1 "config file already exists. Skipping..."
else
    cp ~/.local/share/omakub/configs/ssh-ec2/config ~/.ssh/config
fi

if [ -f ~/.ssh/ssh-ec2 ]; then
    gum style --foreground 1 "ssh-ec2 file already exists. Skipping..."
else
    cp ~/.local/share/omakub/configs/ssh-ec2/ssh-ec2 ~/.ssh/ssh-ec2
fi

# SSH Key Configuration Script
check_ssh_keys() {
    if [ -f "$HOME/.ssh/id_rsa" ] && [ -f "$HOME/.ssh/id_rsa.pub" ]; then
        gum style --foreground 2 "SSH keys already exist in ~/.ssh directory."
        return 0
    else
        gum style --foreground 1 "SSH keys not found in ~/.ssh directory."
        return 1
    fi
}

generate_ssh_keys() {
    gum style --foreground 2 "Generating new SSH keys..."
    ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/id_rsa" -N ""
    gum style --foreground 2 "SSH keys generated successfully."
}

import_ssh_keys() {
    i=1
    while [ $i -le 3 ]; do
        private_key_path=$(gum input --prompt "Enter the full path to your private key file: " --placeholder "/path/to/your/id_rsa")
        public_key_path=$(gum input --prompt "Enter the full path to your public key file: " --placeholder "/path/to/your/id_rsa.pub")
        if [ -f "$private_key_path" ] && [ -f "$public_key_path" ]; then
            gum style --foreground 2 "Files found. Importing the SSH keys..."
            cp "$private_key_path" "$HOME/.ssh/id_rsa"
            cp "$public_key_path" "$HOME/.ssh/id_rsa.pub"
            chmod 600 "$HOME/.ssh/id_rsa"
            chmod 644 "$HOME/.ssh/id_rsa.pub"
            gum style --foreground 2 "SSH keys imported successfully."
            return 0
        else
            gum style --foreground 1 "Error: One or both files not found at the specified paths. Please check the paths and try again."
        fi
        i=$((i + 1))
    done
    gum style --foreground 1 "Failed to provide valid file paths after 3 attempts. Exiting."
    return 1
}

# Main script
gum style \
    --foreground 4 --border-foreground 4 --border double \
    --align center --width 50 --margin "1 2" --padding "2 4" \
    'Welcome to the SSH Key Configuration Script!'

if gum confirm "Do you want to configure SSH keys?"; then
    install_dependencies
    if check_ssh_keys; then
        gum style --foreground 3 "SSH key configuration completed."
    else
        if gum confirm "Do you want to provide the location of existing SSH keys?"; then
            import_ssh_keys
        else
            generate_ssh_keys
        fi
    fi
else
    gum style --foreground 3 "SSH key configuration cancelled."
fi
