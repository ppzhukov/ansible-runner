FROM bitnami/gitlab-runner
USER root
# Обновление пакетов и установка необходимых утилит
RUN apt-get update
RUN apt-get install -y apt-utils python3-full python3-pip git keyutils cifs-utils ca-certificates python3-dev libkrb5-dev krb5-user libcap2-bin git wget sudo
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN . /etc/os-release && export VERSION_CODENAME && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update
RUN apt-get install -y vault
#setcap -r /usr/bin/vault
RUN apt-get install --reinstall -y vault
RUN pip install --break-system-packages ansible pywinrm pywinrm[kerberos] hvac
RUN apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
USER 1001
ENTRYPOINT [ "/usr/bin/dumb-init", "/opt/bitnami/scripts/gitlab-runner/entrypoint.sh" ]
CMD [ "run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner" ]

