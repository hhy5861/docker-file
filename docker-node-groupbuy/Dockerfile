FROM hub.oapol.com/node

ENV APP /app

RUN apt-get update && apt-get install git -y \
    && mkdir -p $APP \
    && git clone http://mike:tlslpc586@gitlab.oapol.com/cheyian/group-buy.git $APP \
    && cd $APP \
    && npm install \
    && apt-get clean

WORKDIR $APP

EXPOSE 3000

CMD ["npm", "start"]
