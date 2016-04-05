FROM ubuntu:14.04
MAINTAINER Isidoro Trevino "chololo@gmail.com"

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Install libgtk as a separate step so that we can share the layer above with
# the netbeans image
RUN apt-get update && apt-get install -y libgtk2.0-0 libcanberra-gtk-module

RUN wget http://mirror.cc.columbia.edu/pub/software/eclipse/technology/epp/downloads/release/mars/2/eclipse-jee-mars-2-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
    echo 'Installing eclipse' && \
    tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

ADD run /usr/local/bin/eclipse

COPY ["files/features.txt", "files/repositories.txt", "files/prepare_eclipse.sh", "/tmp/files/"]

RUN chmod +x /usr/local/bin/eclipse && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer && \
    chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo && \
    ls -la /tmp && \
    ls -la /tmp/files && \
    chmod 755 /tmp/files/*.sh && \
    wget https://www.dropbox.com/s/amqwdauk9qox7v4/springsource-tool-suite-3.6.4.RELEASE-e4.5-updatesite.zip?dl=0 -O /tmp/files/springsource-tool-suite-3.6.4.RELEASE-e4.5-updatesite.zip -q && \
    /tmp/files/prepare_eclipse.sh /opt/eclipse && \
    rm -rf /tmp/*

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /usr/local/bin/eclipse

