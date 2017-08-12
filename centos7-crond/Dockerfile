FROM centos:7.2.1511

RUN yum -y install cronie && yum clean all
ADD start_crond.sh /
RUN chmod a+x start_crond.sh

VOLUME ["/etc/cron.d"]

EXPOSE 22

CMD ["/bin/bash","/start_crond.sh"]