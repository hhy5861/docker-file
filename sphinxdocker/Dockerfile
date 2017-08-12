FROM    hub.oapol.com/docker-crond-go:latest

COPY sphinxsearch_2.2.10-release-1~jessie_amd64.deb /
RUN apt-get update
RUN apt-get install -y mysql-client unixodbc libpq5 libexpat1-dev python-pip
RUN dpkg -i /sphinxsearch_2.2.10-release-1~jessie_amd64.deb
RUN pip install supervisor

RUN mkdir -p /var/data \
	&& mkdir -p /data/sphinx/data \
	&& mkdir -p /data/sphinx/logs \
	&& mkdir -p /data/sphinx/run \
	&& rm -f /etc/localtime \
	&& ln -s /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

ADD supervisord.conf /etc/supervisord.conf
ADD start.sh /start.sh 
ADD indexandsearch.sh /
ADD searchd.sh /

RUN chmod a+x indexandsearch.sh \
	&& chmod a+x searchd.sh \
	&& chmod a+x /start.sh \
	&& rm -rf /sphinxsearch_2.2.10-release-1~jessie_amd64.deb

VOLUME ["/etc/sphinxsearch", "/etc/cron.d"]

CMD ["/start.sh"]