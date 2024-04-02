FROM mcr.microsoft.com/devcontainers/base:debian
# FROM mcr.microsoft.com/devcontainers/base:jammy

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=vscode

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y build-essential --no-install-recommends make \
        ca-certificates \
        git \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncurses5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev \
        zsh \
        fontconfig \
        exa 

# # -- UNCOMMENT ME IF YOU ARE ON WINDOWS -- # #  
RUN apt-get install -y dos2unix
# # -- UNCOMMENT ME IF YOU ARE ON WINDOWS -- # #  


# Python and poetry installation 
USER $USER
ARG HOME="/home/$USER"
ARG PYTHON_VERSION=3.11
# ARG PYTHON_VERSION=3.10

# Node.js and Yarn installation
ARG NODE_VERSION=18.18.0
USER root
RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
# Install nvm
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

RUN chown -R 1000:1000 "/home/vscode/.npm"

USER $USER

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v
# Install Yarn
RUN npm install -g yarn

# confirm yarn
RUN yarn -v

ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${HOME}/.local/bin:$PATH"

RUN echo "done 0" \
    && curl https://pyenv.run | bash \
    && echo "done 1" \
    && pyenv install ${PYTHON_VERSION} \
    && echo "done 2" \
    && pyenv global ${PYTHON_VERSION} \
    && echo "done 3" \
    && curl -sSL https://install.python-poetry.org | python3 - \
    && poetry config virtualenvs.in-project true




# copy .workspaces to home directory
COPY .workspace $HOME/.workspace
COPY env_files/repo2.env $HOME/repo2.env

# # -- UNCOMMENT ME IF YOU ARE ON WINDOWS -- # # 
USER root
COPY /scripts/ $HOME/scripts/
# change ownership of the files in the .devcontainer/scripts folder

RUN chown -R $USER:$USER $HOME/scripts/

# copy the .p10k.zsh file inside theme folder,  to home directory
COPY /theme/.p10k.zsh $HOME/.p10k.zsh
# change ownership of the .p10k.zsh file
RUN chown -R $USER:$USER $HOME/.p10k.zsh

USER $USER
# # this is to convert the line endings of the scripts to unix
RUN find $HOME/scripts/ -type f -print0 | xargs -0 dos2unix --
# we need to do the same for .p10k.zsh
RUN dos2unix $HOME/.p10k.zsh
# # -- UNCOMMENT ME IF YOU ARE ON WINDOWS -- # # 