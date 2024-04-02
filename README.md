
# Dev Container Base

- [Dev Container Base](#dev-container-base)
  - [Folder structure](#folder-structure)
  - [How to run the functions locally](#how-to-run-the-functions-locally)

Base dev container for running multiple projects using python, node and the beautiful [oh-my-zsh](https://ohmyz.sh/) terminal.

## Folder structure

- `README.md`: This file
- 📁`.devcontainer`: The folder containing the devcontainer configuration
  - 📁`.workspace`: The workspace file to be used in the container
    - 📝`base.code-workspace`: Example workspace file to be used in the container
      - Provides examples to use:
        - *folders*
        - *python.defaultInterpreterPath*
        - *launch*
        - *compounds*
        - *tasks*
  - 📁`env_files`: Environment files to be used in the container
    - 📝`devcontainer.env`: Example environment variables to be used in the container (TO BE CREATED)
    - 📝`repo2.env`: Example environment variables to be used in the container
  - 📁`scripts`: Scripts to be run in the container
    - ⚙️`postCreateCommand.sh`: Script to be run after the container is created
    - ⚙️`init.sh`: Script to be run when the container is started. Provide an example to
      - Read variables from `.env` file to
        - set up the git user
        - git clone repo using `GH_TOKEN`
        - replace sensible information in `workspace` launch tasks
      - Run scripts to install python and node packages
    - ⚙️`install_ohmyzsh_font.sh`: Script to install the fonts needed for oh-my-zsh
      - set alias to use exa instead of ls
      - set powerlevel10k theme for zsh with bobby russell's powerlevel10k
  - 📁`theme`: The theme for the terminal
    - ⚙️`.p10k.zsh`: The configuration file for powerlevel10k
  - 🔨`devcontainer.json`: The configuration file for the devcontainer
  - 🔨`Dockerfile`: The dockerfile to build the image
  
## How to run the functions locally

1. [Install Docker](https://docs.docker.com/get-docker/)
2. [Install VsCode](https://code.visualstudio.com/)
3. Make sure to install [Docker extension for vscode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
4. [Create a personal access token in github](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token)
5. In the `.devcontainer\env_files` folder create a file called `devcontainer.env` and add the following content

  ```bash
  GH_TOKEN="COPY THE TOKEN YOU JUST CREATED"
  ENTRYPOINT_USERNAME_REPO_1="ANY USERNAME YOU WANT"
  ENTRYPOINT_PASSWORD_REPO_1="ANY USERNAME YOU WANT"
  GIT_USER_EMAIL="YOUR EMAIL"
  GIT_USER_NAME="YOUR NAME"
  ```

6. Download your services accounts from the google cloud console
   1. Go to the [google cloud console](https://console.cloud.google.com/)
   2. Click on the project you are working on
   3. Go to the `IAM & Admin` section
   4. Click on `Service accounts`
   5. Click on the service account you want to download
   6. Click on `Keys`
   7. Click on `Add key` and select `JSON`

7. Save the file  on your local machine
   1. If you are using windows you must copy it at `C:\Users\<your_user>\.config\gcloud`
   2. If you are on linux you must copy it at `~/.config/gcloud`
8. Open the `.devcontainer/devcontainer.json` file in vscode
9. Go to the `mounts` settings and uncomment the setting related to your system:
  i.e if you are UNIX based you must use `"source=${localEnv:HOME}/.config/gcloud/services_account,target=/home/vscode/.config/gcloud/services_account,type=bind,consistency=cached"`. If you are Windows base you need to use `source=${localEnv:USERPROFILE}\\.config\\gcloud\\services_account,target=/home/vscode/.config/gcloud/services_account,type=bind,consistency=cached`
1. If you are on windows you must also convert the files in the `scripts` folder from `LF` to `CRLF`.\
    To do this uncomment the block inside the `# # -- UNCOMMENT ME IF YOU ARE ON WINDOWS -- # #` in the Dockerfile

2. Press `F1` and select `Dev Container: Rebuild and Reopen in Container`
3. **NB**: this will take a while the first time you run it.
4. After it is build you can simply press `F1` and select `Dev Container: Reopen in Container`
5. Once the container is up and running in the terminal type `code ~/repos/repo1/.workspace/base.code-workspace` and press enter
    1. this open a workspace with the functions you need to run locally and some tasks to run them
6. On the Left side of the screen you should see a `Run and Debug` tab, click on it
7. Select the `Test: e2e` option and press the green play button
8. Go to [localhost:8080/](http://localhost:8080/) and verify that everything works as expected
