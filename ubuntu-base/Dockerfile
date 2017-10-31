FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90circleci \
  && echo 'APT::Get::force-Yes "true";' >> /etc/apt/apt.conf.d/90circleci \
  && echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90circleci

RUN apt-get update && \
  apt-get install python-software-properties software-properties-common apt-transport-https \
                  build-essential curl wget git sudo -q -y --no-install-recommends && \
  apt-add-repository ppa:ansible/ansible && \
  apt-get update && \
  apt-get install -y ansible --no-install-recommends && \
  rm -rf /var/lib/apt/lists/*

RUN echo '[local]\nlocalhost ansible_connection=local\n' > /etc/ansible/hosts
ADD ansible /opt/ansible
WORKDIR /opt/ansible
RUN ansible-playbook site.yml -c local
RUN pip3 install chaperone
CMD ["/bin/bash"]

