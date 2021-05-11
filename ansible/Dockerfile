FROM jenkins/jenkins

USER root

#AVOID INITIAL CONFIGURATION
#ENV JAVA_OPTS -Djenkins.install.runSetupWizard=true

ENV JENKINS_HOME /var/jenkins_home

#INSTALL ANSIBLE
RUN apt-get -y update && apt-get install python3-pip -y && \
    pip3 install ansible --upgrade && \
    apt-get install sshpass
    
RUN mkdir /ansible && \
    mkdir -p /etc/ansible