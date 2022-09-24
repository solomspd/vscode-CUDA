#!/bin/bash
echo "**** Setting up VScode on host machine ****" && \
sudo sh -c 'echo 2 >/proc/sys/kernel/perf_event_paranoid' && \ # set higher paranoid level for deeper nsight profiling
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