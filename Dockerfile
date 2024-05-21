FROM bitnami/gitlab-runner

# containers/bitnami/gitlab-runner/16/debian-12/Dockerfile issue
RUN mkdir -p /var/lib/apt/lists/partial
# Обновление пакетов и установка необходимых утилит
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y python3 python3-pip git keyutils cifs-utils ca-certificates python3-dev libkrb5-dev krb5-user libcap2-bin vault git
RUN apt-get clean
RUN pip install ansible pywinrm pywinrm[kerberos] hvac
CMD ["/bin/bash"]

