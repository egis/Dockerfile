FROM egis/base

ADD ansible /opt/ansible
WORKDIR /opt/ansible
RUN ansible-galaxy install ansiblebit.oracle-java geerlingguy.docker shelleg.gradle
RUN ansible-playbook site.yml -c local
ENV TERM xterm
CMD ["/bin/bash"]