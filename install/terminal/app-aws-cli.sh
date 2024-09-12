# AWS Command Line Interface is a tool that enables you to interact with AWS services.

sudo snap install aws-cli --classic

configure_aws_cli() {
    gum style --foreground 2 "Configuring AWS CLI..."
    aws configure set aws_access_key_id $(gum input --prompt "Enter your AWS Access Key ID: ")
    aws configure set aws_secret_access_key $(gum input --prompt "Enter your AWS Secret Access Key: ")
    aws configure set default.region eu-west-1
    aws configure set default.output text
    gum style --foreground 2 "AWS CLI has been successfully configured."
}

if gum confirm "Do you want to configure AWS CLI?"; then
    configure_aws_cli
else
    gum style --foreground 3 "AWS CLI configuration cancelled."
fi
