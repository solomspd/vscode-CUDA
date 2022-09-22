#!/bin/bash
echo "**** fixing nvidia runtime ****"
find . -type f -exec sudo sed -i '/developer\.download\.nvidia\.com\/compute\/cuda\/repos/d' {} && # remove most likely borken mirrors and keys
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb && # get new keyring
sudo apt install ./cuda-keyring_1.0-1_all.deb && # install new keyring
sudo apt update &&
sudo apt install cuda-gdb-11-7 && # install latest version of the cuda debugger
sudo apt remove nvidia-cuda-gdb && # default version is too old and borked
echo "**** Setting up VScode on host machine ****" && \
if ! command -v code &> /dev/null # if vscode is not installed, install it
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
echo "Copying starter workspace" && \
cp -r workspace ~/GPU-computing-workspace && \
echo "GPU environment is ready!" && \
echo "Installation complete"