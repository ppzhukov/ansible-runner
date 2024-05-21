FROM bitnami/gitlab-runner

USER root
# Обновление пакетов и установка необходимых утилит
RUN apt-get update
RUN apt-get install -y python3 python3-pip git keyutils cifs-utils ca-certificates python3-dev libkrb5-dev krb5-user libcap2-bin git wget sudo
RUN . /etc/os-release
RUN cat /etc/os-release
RUN export UBUNTU_CODENAME
RUN wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update
RUN apt install vault
RUN apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN pip install ansible pywinrm pywinrm[kerberos] hvac
CMD ["/bin/bash"]

