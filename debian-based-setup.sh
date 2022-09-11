#!/bin/bash
echo "**** Installing Nvidia Docker runtime ****" && \
curl https://get.docker.com | sh && sudo systemctl --now enable docker &&
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list && \
sudo apt-get update && \
sudo apt-get install -y nvidia-docker2 && \
sudo systemctl restart docker && \
echo "**** Installing GPU computing docker image ****" && \
docker-compose up -d && \
echo "**** Setting up VScode on host machine ****" && \
if ! command -v code &> /dev/null
then
      sudo apt-get install wget gpg
      wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
      sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
      sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
      rm -f packages.microsoft.gpg
      sudo apt install apt-transport-https
      sudo apt update
      sudo apt install code
fi && \
echo "**** Installing VScode extensions ****" && \
code --install-extension ms-vscode-remote.remote-containers && \
code --install-extension ms-vscode.cpptools && \
code --install-extension VisualStudioExptTeam.vscodeintellicode && \
code --install-extension ms-azuretools.vscode-docker && \
code --install-extension ms-vscode-remote.remote-containers && \
code --install-extension redhat.vscode-yaml && \
code --install-extension NVIDIA.nsight-vscode-edition && \
echo "GPU environment is ready!" && \
echo "Installation complete" && \