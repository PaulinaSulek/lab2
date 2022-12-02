# syntax=docker/dockerfile:1.2

# to build the image:
# docker build --ssh github=$HOME/.ssh/gh_osx_ed25519 -f Dockerfile -t spr3 --no-cache . 

FROM node:alpine

# install ssh client and git
RUN apk add --no-cache openssh-client git
# download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
# clone our private repository

WORKDIR /usr/app
RUN --mount=type=ssh,id=github git clone git@github.com:PaulinaSulek/lab2.git .

RUN npm install
EXPOSE 8080

# Default command
CMD ["npm", "start"]
