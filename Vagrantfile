Vagrant.configure("2") do |config|
  # Edge Node
  config.vm.define "mapr-edge-data2-ai.com" do |edge|
    edge.vm.box = "ubuntu/bionic64"
    edge.vm.network "private_network", type: "dhcp"
    edge.vm.hostname = "mapr-edge-data2-ai.com"
    edge.vm.network "forwarded_port", guest: 22, host: 2222 # SSH port forwarding
    edge.vm.network "private_network", type: "static", ip: "192.168.33.10"

    # Configure /etc/hosts and SSH keys
    edge.vm.provision "shell", inline: <<-SHELL
      mkdir -p /home/vagrant/.ssh
      cp /vagrant/.ssh/id_rsa* /home/vagrant/.ssh/
      chown -R vagrant:vagrant /home/vagrant/.ssh
      chmod 600 /home/vagrant/.ssh/id_rsa*
      rm -f /home/vagrant/.ssh/known_hosts
      echo "192.168.33.11 mapr-master-data2-ai.com" >> /etc/hosts
      echo "192.168.33.12 mapr-worker1-data2-ai.com" >> /etc/hosts
      echo "192.168.33.13 mapr-worker2-data2-ai.com" >> /etc/hosts
      echo "192.168.33.14 mapr-worker3-data2-ai.com" >> /etc/hosts
      ssh-keygen -t rsa -P "" -f /home/vagrant/.ssh/id_rsa
      cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-master-data2-ai.com
      ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-worker1-data2-ai.com
    SHELL
  end

  # Master Node
  config.vm.define "mapr-master-data2-ai.com" do |master|
    master.vm.box = "ubuntu/bionic64"
    master.vm.network "private_network", type: "dhcp"
    master.vm.hostname = "mapr-master-data2-ai.com"
    master.vm.network "forwarded_port", guest: 22, host: 2223 # SSH port forwarding
    master.vm.network "private_network", type: "static", ip: "192.168.33.11"

    # Configure /etc/hosts and SSH keys
    master.vm.provision "shell", inline: <<-SHELL
      mkdir -p /home/vagrant/.ssh
      cp /vagrant/.ssh/id_rsa* /home/vagrant/.ssh/
      chown -R vagrant:vagrant /home/vagrant/.ssh
      chmod 600 /home/vagrant/.ssh/id_rsa*
      rm -f /home/vagrant/.ssh/known_hosts
      echo "192.168.33.10 mapr-edge-data2-ai.com" >> /etc/hosts
      echo "192.168.33.12 mapr-worker1-data2-ai.com" >> /etc/hosts
      echo "192.168.33.13 mapr-worker2-data2-ai.com" >> /etc/hosts
      echo "192.168.33.14 mapr-worker3-data2-ai.com" >> /etc/hosts
      ssh-keygen -t rsa -P "" -f /home/vagrant/.ssh/id_rsa
      cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-edge-data2-ai.com
      ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-worker1-data2-ai.com
      ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-worker2-data2-ai.com
    SHELL
  end

  # Worker Nodes
  (1..3).each do |i|
    config.vm.define "mapr-worker#{i}-data2-ai.com" do |worker|
      worker.vm.box = "ubuntu/bionic64"
      worker.vm.network "private_network", type: "dhcp"
      worker.vm.hostname = "mapr-worker#{i}-data2-ai.com"
      worker.vm.network "forwarded_port", guest: 22, host: 2223 + i # SSH port forwarding
      worker.vm.network "private_network", type: "static", ip: "192.168.33.#{12 + i}"

      # Configure /etc/hosts and SSH keys
      worker.vm.provision "shell", inline: <<-SHELL
        mkdir -p /home/vagrant/.ssh
        cp /vagrant/.ssh/id_rsa* /home/vagrant/.ssh/
        chown -R vagrant:vagrant /home/vagrant/.ssh
        chmod 600 /home/vagrant/.ssh/id_rsa*
        rm -f /home/vagrant/.ssh/known_hosts
        echo "192.168.33.10 mapr-edge-data2-ai.com" >> /etc/hosts
        echo "192.168.33.11 mapr-master-data2-ai.com" >> /etc/hosts
        echo "192.168.33.13 mapr-worker2-data2-ai.com" >> /etc/hosts
        echo "192.168.33.14 mapr-worker3-data2-ai.com" >> /etc/hosts
        ssh-keygen -t rsa -P "" -f /home/vagrant/.ssh/id_rsa
        cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
        ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-edge-data2-ai.com
        ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-master-data2-ai.com
        ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-worker1-data2-ai.com
        ssh-copy-id -i /home/vagrant/.ssh/id_rsa.pub vagrant@mapr-worker2-data2-ai.com
      SHELL
    end
  end
end
