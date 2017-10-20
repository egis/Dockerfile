FROM egis/base

ADD ansible /opt/ansible
WORKDIR /opt/ansible
RUN ansible-playbook system.yml -c local
RUN ansible-playbook site.yml -c local
ENV PATH   /usr/local/go/bin:$PATH
ENV GOPATH /go
ENV TERM xterm
CMD ["/bin/bash"]