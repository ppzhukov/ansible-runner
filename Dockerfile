FROM bitnami/gitlab-runner

USER root
# Обновление пакетов и установка необходимых утилит
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3 python3-pip git keyutils cifs-utils ca-certificates python3-dev libkrb5-dev krb5-user libcap2-bin git
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
RUN apt-get clean
RUN pip install ansible pywinrm pywinrm[kerberos] hvac
CMD ["/bin/bash"]

