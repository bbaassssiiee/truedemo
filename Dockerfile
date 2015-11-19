FROM centos:centos6
MAINTAINER Bas Meijer <datasmid@yahoo.com>
LABEL org.dockpack.purpose=demo

ADD ansible /tmp/ansible
RUN yum update -y && \
    yum install -y epel-release && \
    yum install -y ansible tar && \
    yum clean all && \
    cd /tmp/ansible && \
    ansible-galaxy install --force -r requirements.yml && \
    ansible-playbook playbook.yml

ADD webapps /opt/apache-tomcat/webapps
ENV CATALINA_HOME /opt/apache-tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
LABEL running="docker run -d -p 8080:8080 dockpack/tomcat:7"
WORKDIR $CATALINA_HOME
EXPOSE 8080
ENTRYPOINT ["/opt/apache-tomcat/bin/catalina.sh","run"]
