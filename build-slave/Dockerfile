FROM egis/base

ADD ansible /opt/ansible
WORKDIR /opt/ansible
RUN ansible-playbook site.yml -c local
ENV TERM xterm
CMD ["/bin/bash"]