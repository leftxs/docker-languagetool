Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provider :virtualbox do |v|
    v.gui = true
    v.memory = 4048
  end

  # Currently "ubuntu/focal64" on VirtualBox requires `type: "virtualbox"`
  # to make synced folder works.
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Add Google Chrome repository
  config.vm.provision :shell, inline: "wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub|sudo apt-key add -"
  config.vm.provision :shell, inline: "sudo sh -c 'echo \"deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main\" > /etc/apt/sources.list.d/google.list'"

  # Update repositories
  config.vm.provision :shell, inline: "sudo apt update -y"

  # Upgrade installed packages
  config.vm.provision :shell, inline: "sudo apt upgrade -y"

  # Add desktop environment
  config.vm.provision :shell, inline: "sudo apt install -y --no-install-recommends ubuntu-desktop"
  config.vm.provision :shell, inline: "sudo apt install -y --no-install-recommends virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11 git vim"

  # Add `vagrant` to Administrator
  config.vm.provision :shell, inline: "sudo usermod -a -G sudo vagrant"

  # Add Docker
  config.vm.provision "shell", path: "https://raw.githubusercontent.com/docker/docker-install/master/install.sh"

  # Configure Docker
  #config.vm.provision :shell, inline: "sudo groupadd docker"
  config.vm.provision :shell, inline: "sudo usermod -aG docker vagrant"
  config.vm.provision :shell, inline: "sudo systemctl enable docker.service"
  config.vm.provision :shell, inline: "sudo systemctl enable containerd.service"

  # Add Google Chrome
  #config.vm.provision :shell, inline: "sudo apt install -y google-chrome-stable"

  # Add Chromium
  #config.vm.provision :shell, inline: "sudo apt install -y chromium-browser"

  # Add Firefox
  config.vm.provision :shell, inline: "sudo apt install -y firefox"

  # Restart
  config.vm.provision :shell, inline: "sudo shutdown -r now"
end
