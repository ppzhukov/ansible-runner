FROM bitnami/gitlab-runner

# Обновление пакетов и установка необходимых утилит
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y python3 python3-pip git keyutils cifs-utils ca-certificates python3-dev libkrb5-dev krb5-user libcap2-bin vault git
RUN apt-get clean
RUN pip install ansible pywinrm pywinrm[kerberos] hvac
CMD ["/bin/bash"]

