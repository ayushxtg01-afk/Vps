
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/sshd && \
    printf '\nPermitRootLogin yes\nPasswordAuthentication yes\n' >> /etc/ssh/sshd_config

EXPOSE 22

CMD ["bash", "-lc", "if [ -z \"$ROOT_PASSWORD\" ]; then echo 'ROOT_PASSWORD is missing'; exit 1; fi; echo \"root:$ROOT_PASSWORD\" | chpasswd && exec /usr/sbin/sshd -D -e"]
