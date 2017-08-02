FROM egis/ubuntu-base

ADD ansible /opt/ansible
WORKDIR /opt/ansible
RUN ansible-galaxy install ansiblebit.oracle-java geerlingguy.docker shelleg.gradle
RUN ansible-playbook site.yml -c local
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/bin/bash"]

