FROM      python:3.6.4-slim

RUN       apt-get -y update
RUN       apt-get -y dist-upgrade

RUN       apt-get -y install nginx supervisor

COPY      . /srv/backend
WORKDIR   /srv/backend
RUN       pip install -r requirements.txt

WORKDIR   /srv/backend/app
CMD       python manage.py runserver 0:8000

EXPOSE    8000
