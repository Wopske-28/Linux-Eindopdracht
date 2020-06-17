Install docker dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - gnupg-agent
      - software-properties-common
      - python-pip
      - python3-pip

Install docker_container:
  pip.installed:
    - name: docker
    - bin_env: '/usr/bin/pip3'
    
Get stable docker repository:
  cmd.run:
    - names: 
      - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

Install docker engine:
  pkg.installed:
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io 

Hello world container:
  docker_container.running:
    - name: static-site
    - image: seqvence/static-site:latest
    - network_mode: host