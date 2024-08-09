FROM alpine:3.20.2

RUN set -eux; \
  apk add --no-cache \
    bash \
    doas \
    openssh \
    git \
    yq-go \
    ncurses

WORKDIR /srv/

COPY bin bin
COPY common.sh common.sh
COPY git-shell-commands-common.sh git-shell-commands-common.sh
COPY conf conf
COPY init-git-shell-session /usr/bin/init-git-shell-session
RUN chmod 0755 /usr/bin/init-git-shell-session
COPY doas.conf /etc/doas.conf

RUN echo -n "" > /etc/motd

EXPOSE 22

ENTRYPOINT ["bin/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
