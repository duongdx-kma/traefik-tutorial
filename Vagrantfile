NUM_TRAEFIK_NODE = 1

IP_NW = "192.168.56."
TRAEFIK_IP_START = 110
TRAEFIK_HOST_PORT = 5555

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false

  (1..NUM_TRAEFIK_NODE).each do |i|
    config.vm.define "traefik0#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "traefik0#{i}"
        vb.memory = 3072
        vb.cpus = 3
      end
      node.vm.hostname = "traefik0#{i}"
      node.vm.synced_folder "./traefik", "/tmp/traefik", :mount_options => ["dmode=777", "fmode=666"]
      node.vm.network :private_network, ip: IP_NW + "#{TRAEFIK_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{TRAEFIK_HOST_PORT + i}"
      # node.vm.provision "setup-dns", type: "shell", :path => "../ubuntu/update-dns.sh"
    end
  end

  config.vm.provision "setup-deployment-user", type: "shell" do |s|
      ssh_pub_key = File.readlines("./client.pem.pub").first.strip
      s.inline = <<-SHELL
          # create deploy user
          useradd -s /bin/bash -d /home/deploy/ -m -G sudo deploy
          echo 'deploy ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
          mkdir -p /home/deploy/.ssh && chown -R deploy /home/deploy/.ssh
          echo #{ssh_pub_key} >> /home/deploy/.ssh/authorized_keys
          chown -R deploy /home/deploy/.ssh/authorized_keys
          # config timezone
          timedatectl set-timezone Asia/Ho_Chi_Minh
      SHELL
  end
end
