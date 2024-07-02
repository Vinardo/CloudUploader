#!/bin/bash

setup() {
    # Function to check if AWS CLI is installed and install it if not
    function check_and_install_aws_cli {
        if command -v aws &> /dev/null
        then
            echo "AWS CLI is already installed."
            exit 0
        else
            echo "AWS CLI is not installed. Installing AWS CLI..."
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
                unzip awscliv2.zip
                sudo ./aws/install
                rm awscliv2.zip
                rm -r aws
            elif [[ "$OSTYPE" == "darwin"* ]]; then
                curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
                sudo installer -pkg AWSCLIV2.pkg -target /
                rm AWSCLIV2.pkg
            elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
                echo "Please install AWS CLI manually from https://aws.amazon.com/cli/"
                exit 1
            else
                echo "Unsupported OS type: $OSTYPE"
                exit 1
            fi
        fi
    }

    # Check and install AWS CLI if necessary
    check_and_install_aws_cli

    # Login
    echo "Please login using the AWS CLI."
    aws configure
    echo "Login Initiated."
}

setup

