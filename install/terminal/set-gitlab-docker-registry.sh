
# Main script
gum style \
    --foreground 4 --border-foreground 4 --border double \
    --align center --width 50 --margin "1 2" --padding "2 4" \
    'Welcome to the Gitlab Docker Registry Configuration Script!'

if gum confirm "Do you want to configure it?"; then
    gum style --foreground 3 "Opening Gitlab URL https://gitlab.com/-/user_settings/personal_access_tokens"
    gum style --foreground 3 "Get a token (read_api + read_repository + read_registry) and use your username from gitlab (not the email) and the token you just created"
    docker login registry.gitlab.com
    gum style --foreground 3 "Gitlab Docker Registry configuration completed."
else
    gum style --foreground 3 "Gitlab Docker Registry configuration cancelled."
fi
