FROM ros:foxy

SHELL ["/bin/bash", "-c"]

RUN apt-get update

# Install necessary packages
RUN apt-get install -y git curl clang build-essential tmux vim

# Install packages for CycloneDDS
RUN apt-get install -y maven default-jdk

RUN git clone https://github.com/evshary/zenoh-plugin-dds.git; \
    cd zenoh-plugin-dds; \
    ./config.sh; \
    source $HOME/.cargo/env; \
    rustup default nightly; \
    cargo build --release --all-targets

# Install ROS necessary packages
RUN apt-get install -y \
      ros-${ROS_DISTRO}-rmw-cyclonedds-cpp \
      ros-${ROS_DISTRO}-demo-nodes-cpp \
      ros-${ROS_DISTRO}-demo-nodes-py

# Environment
ENV LD_LIBRARY_PATH /usr/local/lib/
WORKDIR /zenoh-plugin-dds
