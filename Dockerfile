FROM debian:10-slim

COPY *.tar.gz /tmp/

RUN apt-get update && apt-get install -y \
    nano mc rpm python-pip ruby-dev build-essential groff createrepo \
    && pip install --upgrade pip \
    \
    && mkdir /usr/lib/java \
    && tar -zxvf /tmp/jdk.tar.gz -C /usr/lib/java/ && rm /tmp/jdk.tar.gz \
    \
    && mkdir /usr/lib/ant \
    && tar -zxvf /tmp/ant.tar.gz -C /usr/lib/ant/ && rm /tmp/ant.tar.gz \
    \
    && gem install fpm \
    && pip install awscli && pip install awscli --upgrade \
    \
    && mkdir /work

ENV PATH=$PATH:/usr/lib/java/bin
ENV JAVA_HOME=/usr/lib/java/
ENV JRE_HOME=/usr/lib/java/jre/
ENV J2SDKDIR=/usr/lib/java/
ENV J2REDIR=/usr/lib/java/jre/
ENV ANT_HOME=/usr/lib/ant
ENV PATH=${PATH}:${ANT_HOME}/bin

WORKDIR /work

CMD ["bash"]