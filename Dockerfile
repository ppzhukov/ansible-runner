FROM ubuntu:22.04

# Обновление пакетов и установка необходимых утилит
RUN apt-get update && apt-get upgrade -y && apt-get install -y ansible python sudo && apt-get clean

CMD ["/bin/bash"]

