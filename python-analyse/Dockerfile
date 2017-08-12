FROM hub.oapol.com/python_jieba:0.8

MAINTAINER Mike Huang <hhy5861@163.com>

ADD app /app/
ADD start.sh /start.sh

RUN chmod +x app/app.py
RUN chmod +x /start.sh

EXPOSE 22
EXPOSE 5000

CMD ["/bin/bash","/app/app.py"]