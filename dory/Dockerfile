FROM centos:7
MAINTAINER ben@perimeterx.com

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN yum -y group mark convert
RUN yum -y groupinstall "Development Tools"
RUN yum -y install git libasan snappy-devel boost-devel xerces-c-devel rpm-build wget unzip socat
RUN wget -P /etc/yum.repos.d http://mirrors.aliyun.com/repo/Centos-7.repo \
	&& wget -P /etc/yum.repos.d http://mirrors.aliyun.com/repo/epel-7.repo
RUN wget "http://downloads.sourceforge.net/project/scons/scons/2.3.6/scons-2.3.6-1.noarch.rpm?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fscons%2Ffiles%2Fscons%2F2.3.6%2F&ts=1439720375&use_mirror=skylineservers" -O scons.rpm && \
    rpm -i scons.rpm \
    && yum -y install nginx

RUN cd /root && \
    git clone https://github.com/dspeterson/dory.git && \
    cd dory && \
    cd src/dory && \
    scons -Q --up --release dory && \
    mkdir -p /opt/dory/bin/ && \
    cp /root/dory/out/release/dory/dory /opt/dory/bin/


RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python
RUN easy_install pip
RUN pip install supervisor

RUN mkdir -p /etc/dory && yum clean all
ADD dory_conf.xml /etc/dory/
ADD start.sh /etc/dory/
ADD supervisord.conf /etc/
ADD nginx.conf /etc/nginx/

EXPOSE 9090 9080

CMD ["supervisord","-n","-c","/etc/supervisord.conf"]
