FROM node:current-alpine
LABEL maintainer="Andrew Beveridge <andrew@beveridge.uk>" \
    description="Lightweight Docusaurus container with Node.js based on Alpine Linux"

RUN apk add --no-cache \
    bash bash-completion supervisor \
    autoconf automake build-base libtool nasm

# Environment variables
ENV TARGET_UID=1000
ENV TARGET_GID=1000
ENV TEMPLATE='classic'
ENV RUN_MODE='production'

RUN mkdir /docusaurus
WORKDIR /docusaurus

# Copy configuration files
ADD config/init.sh /
ADD config/run.sh /
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set files permission
RUN chmod a+x /init.sh /run.sh

EXPOSE 80
VOLUME [ "/docusaurus" ]
ENTRYPOINT [ "/init.sh" ]
