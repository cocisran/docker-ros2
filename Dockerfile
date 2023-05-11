FROM ubuntu:22.04
ARG SUDO_PSW
# User ros
RUN apt-get update && apt-get install -y sudo
RUN useradd -m ros && echo "ros:"$SUDO_PSW | chpasswd && adduser ros sudo

ENV SUDO_FORCE_REMOVE yes

# Set locale
RUN sudo apt update 
RUN sudo apt install locales 

RUN sudo locale-gen en_US en_US.UTF-8 \
    && sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && export LANG=en_US.UTF-8

# Setup Sources
RUN sudo apt install software-properties-common -y
RUN sudo add-apt-repository universe -y

RUN sudo apt update && apt install curl -y \
    && sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

RUN apt update \
    && apt upgrade -y

# Configuraciones pre-instalacion de la zona horaria
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends tzdata 

ENV TZ=America/Mexico_City
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

# Install ros2
RUN  sudo apt install ros-humble-desktop -y

RUN sudo echo source /opt/ros/humble/setup.bash >> ~/.bashrc

USER ros