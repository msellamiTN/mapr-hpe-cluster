 
Vagrant.configure("2") do |config|
 
    # Edge Node
    config.vm.define "mapr-edge" do |edge|
      edge.vm.box = "ubuntu/focal64"
      edge.vm.hostname = "mapr-edge-data2-ai.com"
       # Set memory, CPU, and disk resources
       edge.vm.disk :disk, size: "100GB", primary: true   
       edge.vm.provider "virtualbox" do |vb|
        vb.memory = 24576  # 24 GB RAM
        vb.cpus = 8        # 8 CPUs
        
      end
      
      edge.vm.network "forwarded_port", guest: 22, host: 2220 , id: "ssh", auto_correct: true
      # NAT adapter for internet access
      edge.vm.network "public_network",  type: "static", ip: "192.168.56.10"
      # Internal/private network for communication between VMs
      edge.vm.network "private_network", type: "static", ip: "192.168.56.10", virtualbox__intnet: true , name: "mapr-cluster-net"

      # Copy hosts file
      edge.vm.provision "file", source: "external_hosts", destination: "/tmp/hosts"
      edge.vm.provision "shell", inline: "sudo mv /tmp/hosts /etc/hosts"
      edge.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
      edge.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
      edge.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"         
    end
    # Master Node
   
     config.vm.define "mapr-master" do |master|
      master.vm.box = "ubuntu/focal64"
      master.vm.hostname = "mapr-master-data2-ai.com"
       # Set memory, CPU, and disk resources
      master.vm.disk :disk, size: "50GB", primary: true 
      master.vm.disk :disk, size: "100GB", name: "mapr_data"
      master.vm.provider "virtualbox" do |vb|
        vb.memory = 24576  # 24 GB RAM
        vb.cpus = 8        # 8 CPUs
        
      end
      # NAT adapter for internet access
      master.vm.network "public_network",  type: "static", ip: "192.168.56.11"
      # Internal/private network for communication between VMs
      master.vm.network "private_network", type: "static", ip: "192.168.56.11", virtualbox__intnet: true , name: "mapr-cluster-net"
      master.vm.network "forwarded_port", guest: 22, host: 2221, id: "ssh", auto_correct: true
      # Copy hosts file
      master.vm.provision "file", source: "external_hosts", destination: "/tmp/hosts"
      master.vm.provision "shell", inline: "sudo mv /tmp/hosts /etc/hosts"
      master.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
      master.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
      master.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"         
    end
  
    # Worker Nodes
    (1..3).each do |i|
      config.vm.define "mapr-worker#{i}" do |worker|
        worker.vm.box = "ubuntu/focal64"
        worker.vm.hostname = "mapr-worker#{i}-data2-ai.com"
         # Set memory, CPU, and disk resources
         worker.vm.disk :disk, size: "100GB", primary: true
         worker.vm.provider "virtualbox" do |vb|
          vb.memory = 8000  # 8 GB RAM
          vb.cpus = 4        # 4 CPUs
          
        end
           # NAT adapter for internet access
           worker.vm.network "public_network", type: "static", ip: "192.168.56.#{11 + i}"
        # Internal/private network for communication between VMs
        worker.vm.network "private_network", type: "static", ip: "192.168.56.#{11 + i}", virtualbox__intnet: true , name: "mapr-cluster-net"
        worker.vm.network "forwarded_port", guest: 22, host: 2221 + i , id: "ssh", auto_correct: true
        # Copy hosts file
        worker.vm.provision "file", source: "external_hosts", destination: "/tmp/hosts"
        worker.vm.provision "shell", inline: "sudo mv /tmp/hosts /etc/hosts"
        worker.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
        worker.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
        worker.vm.provision "file", source: "/home/user2/mapr-cluster/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/authorized_keys"         
      
      end
    end
    config.disksize.size = "100GB"  # Adjust the size as needed
  end
  