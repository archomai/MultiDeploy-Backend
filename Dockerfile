FROM      python:3.6.4-slim

RUN       apt-get -y update
RUN       apt-get -y dist-upgrade

RUN       apt-get -y install nginx supervisor

COPY      . /srv/backend
WORKDIR   /srv/backend
RUN       pip install -r requirements.txt

# Nginx settings
RUN       rm -rf /etc/nginx/sites-enabled/*

# Copy Nginx conf
RUN       cp /srv/backend/.config/nginx.conf \
              /etc/nginx/nginx.conf

# Copy nginx-app.conf
RUN       cp /srv/backend/.config/nginx-app.conf \
              /etc/nginx/sites-available/
RUN       ln -sf /etc/nginx/sites-available/nginx-app.conf \
                /etc/nginx/sites-enabled/nginx-app.conf

# Copy supervisord conf
RUN       cp -f /srv/backend/.config/supervisord.conf \
                /etc/supervisor/conf.d/

# Stop nginx, run supervisor
CMD       pkill nginx; supervisord -n

EXPOSE    80
