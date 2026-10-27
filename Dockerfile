FROM ubuntu:24.04

# Instalacja pakietow i narzedzi systemowych
RUN apt update && apt upgrade -y && \
    apt install -y openssh-server curl iputils-ping inetutils-telnet iproute2 vim sudo && \
    mkdir /var/run/sshd &&\
    apt clean && rm -rf /var/lib/apt/lists/*

# Tworzenie katalogu SSH dla root'a
RUN mkdir -p /root/.ssh

# Dodanie klucza publicznego do authorized_keys oraz nadanie uprawnien
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh

# Ustawienie opcji SSH (pozwolenie na logowanie root'a)
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

# Uruchomienie uslugi SSH bez pracy w tle
CMD ["/usr/sbin/sshd", "-D"]
