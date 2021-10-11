FROM jenkins/jenkins:2.303.1-jdk11
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
RUN curl -L \  
  "https://github.com/docker/compose/releases/download/v2.0.0-beta.6/docker-compose-$(uname -s)-$(uname -m)" \  
  -o /usr/local/bin/docker-compose \  
  && chmod +x /usr/local/bin/docker-compose  
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.0 docker-workflow:1.26"