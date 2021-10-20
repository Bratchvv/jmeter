#!/bin/bash

docker load --input grafana.tar || true
docker load --input prometheus.tar || true
docker load --input blackbox-exporter.tar || true
docker load --input volumes-provisioner.tar || true

docker-compose up -d
