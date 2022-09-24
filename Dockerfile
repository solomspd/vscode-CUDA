FROM nvidia/cuda:11.7.1-devel-ubuntu20.04

# set version label
# ARG BUILD_DATE
# ARG VERSION
# ARG CODE_RELEASE
# LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="solom"
ARG DEBIAN_FRONTEND=noninteractive

# environment settings
ENV HOME="/home"

RUN \
  echo "**** install runtime dependencies ****" && \
  apt-get update && \
  apt-get install -y \
    git \
    jq \
    libatomic1 \
    nano \
    net-tools \
    sudo && \
  apt install -y nsight-systems nsight-compute && \
  apt install -y openssh-server && \
  service ssh start

RUN sed -ri 's/#* *PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -ri 's/#* *PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

RUN passwd -d root

# add local files
COPY /root /
COPY /workspace /home/workspace
COPY /README.md /home/workspace/README.md

# ports and volumes
EXPOSE 8443
EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]