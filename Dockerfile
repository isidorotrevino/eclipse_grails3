FROM vintec/basejava:v8
MAINTAINER Isidoro Trevino "chololo@gmail.com"


RUN wget http://mirror.cc.columbia.edu/pub/software/eclipse/technology/epp/downloads/release/mars/2/eclipse-jee-mars-2-linux-gtk-x86_64.tar.gz -O /tmp/eclipse.tar.gz -q && \
    echo 'Installing eclipse' && \
    sudo apt-get update && sudo apt-get install -y libgtk2.0-0 libcanberra-gtk-module && \
    sudo tar -xf /tmp/eclipse.tar.gz -C /opt && \
    rm /tmp/eclipse.tar.gz

ADD run /usr/local/bin/eclipse

COPY ["files/features.txt", "files/repositories.txt", "files/prepare_eclipse.sh", "/tmp/files/"]

USER root

RUN chmod +x /usr/local/bin/eclipse && \
    mkdir -p /home/developer && \
    echo "developer:x:1000:1000:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:1000:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown root:root /usr/bin/sudo && \
    chmod 4755 /usr/bin/sudo && \
    ls -la /tmp && \
    ls -la /tmp/files && \
    chmod 755 /tmp/files/*.sh && \
    wget https://www.dropbox.com/s/amqwdauk9qox7v4/springsource-tool-suite-3.6.4.RELEASE-e4.5-updatesite.zip?dl=0 -O /tmp/files/springsource-tool-suite-3.6.4.RELEASE-e4.5-updatesite.zip -q && \
    wget https://projectlombok.org/downloads/lombok.jar -O /tmp/files/lombok.jar && \
	java -jar /tmp/files/lombok.jar install /opt/eclipse && \
    /tmp/files/prepare_eclipse.sh /opt/eclipse && \
	chown -R developer:developer /opt/ && \
    chown developer:developer -R /home/developer && \
    rm -rf /tmp/*

USER developer
ENV HOME /home/developer
WORKDIR /home/developer
CMD /usr/local/bin/eclipse

