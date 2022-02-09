FROM python:3.9.10-buster 

ENV MICRO_SERVICE=/home/app/microservice
# RUN addgroup -S $APP_USER && adduser -S $APP_USER -G $APP_USER
# set work directory


RUN mkdir -p $MICRO_SERVICE
RUN mkdir -p $MICRO_SERVICE/static
COPY ./app $MICRO_SERVICE
# where the code lives
WORKDIR $MICRO_SERVICE

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependenciedsd
# RUN apk update \
#     && apk add --virtual build-deps gcc python3-dev musl-dev \
#     && apk del build-deps \
#     && apk --no-cache add musl-dev linux-headers g++
# install dependencies
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
# copy project
COPY . $MICRO_SERVICE
RUN pip install mysqlclient
RUN pip install -r requirements.txt

COPY ./entrypoint.sh $MICRO_SERVICE

CMD ["/bin/bash", "/home/app/microservice/entrypoint.sh"]