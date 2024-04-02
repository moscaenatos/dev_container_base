#!/bin/bash

# Set the token, it is passed as an arguent to the script
TOKEN=$GH_TOKEN

# Check if the token is set
if [ -z "$TOKEN" ]; then
    echo "The GH_TOKEN environment variable is not set."
    exit 1
    fi
# Set the URLs of your repositories
repo1="https://$TOKEN@github.com/repo1.git"
repo2="https://$TOKEN@github.com/repo2.git"
repo3="https://$TOKEN@github.com/repo3.git"

## Configure git by reading the user's name and email from the environment
git config --global user.name "$GIT_USER_NAME" \ && git config --global user.email "$GIT_USER_EMAIL"

# Set the directory where you want to clone the repositories
DIR="$HOME/repos"

# Clone the repositories
git clone "$repo1" "$DIR/repo1"
git clone "$repo2" "$DIR/repo2"
git clone "$repo3" "$DIR/repo3"

# copy the $HOME/.workspace inside "$DIR/repo1"

cp -r "$HOME/.workspace" "$DIR/repo1"
WORKSPACE_FILE_PATH="$DIR/repo1/.workspace/base.code-workspace" 

# replace the placeholder with the actual value in the base.code-workspace file

# ENTRYPOINT_USERNAME_REPO_1
sed -i "s/\"ENTRYPOINT_USERNAME_REPO_1\"/\"$ENTRYPOINT_USERNAME_REPO_1\"/g" "$WORKSPACE_FILE_PATH"
# ENTRYPOINT_PASSWORD_REPO_1
sed -i "s/\"ENTRYPOINT_PASSWORD_REPO_1\"/\"$ENTRYPOINT_PASSWORD_REPO_1\"/g" "$WORKSPACE_FILE_PATH"


# run the scripts to install repo1
cd "$DIR/repo1"
./install_project.sh "$DIR/repo1"

# run the scripts to install repo2
cd "$DIR/repo2"
mv "$HOME/repo2.env" "$DIR/repo2/.env"
nvm use 18.18.0
yarn install

# run the scripts to install repo3
cd "$DIR/repo3"
pyenv install 3.9.18
pyenv local 3.9.18

./install_project.sh "$DIR/repo3"