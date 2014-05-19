#!/usr/bin/env bash
# This takes care of installing dependencies required from debian repos.

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

apt-get update

apt-get install -y python-software-properties

add-apt-repository -y ppa:cartodb/gis
add-apt-repository -y ppa:mapnik/v2.1.0
add-apt-repository -y ppa:cartodb/nodejs
add-apt-repository -y ppa:cartodb/redis
add-apt-repository -y ppa:cartodb/postgresql
add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable

apt-get update

apt-get install -y make unp zip libgeos-c1 libgeos-dev gdal-bin libgdal1-dev libjson0 \
  python-simplejson libjson0-dev proj-bin proj-data libproj-dev postgresql-9.1 \
  postgresql-client-9.1 postgresql-contrib-9.1 postgresql-server-dev-9.1 \
  postgresql-plpython-9.1 ruby1.9.1 ruby1.9.1-dev nodejs npm redis-server libmapnik-dev \
  mapnik-utils python-mapnik git python-setuptools python-gdal gdal-bin libgdal1-dev

apt-get install -y imagemagick nmap
