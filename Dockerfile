FROM ubuntu:noble
USER root
# Обновление пакетов и установка необходимых утилит
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt -y install python3-full python3-pip git keyutils cifs-utils ca-certificates python3-dev libkrb5-dev krb5-user libcap2-bin git wget sudo
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN . /etc/os-release && export VERSION_CODENAME && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update
RUN apt -y install vault
#setcap -r /usr/bin/vault
RUN apt -y reinstall vault
RUN pip install --break-system-packages ansible pywinrm pywinrm[kerberos] hvac pyVim
RUN pip install --break-system-packages dnspython beautifulsoup4 netaddr lxml jmespath requests_gssapi soupsieve gssapi decorator #Basic 
RUN ansible-galaxy collection install kubernetes.core
RUN apt update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
CMD [ "/bin/bash" ]

