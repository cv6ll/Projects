#!/bin/bash
sudo su
apt update
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

apt-get update
apt  install docker.io -y

mkdir /etc/prometheus
cd /etc/prometheus/ && touch prometheus.yml
mkdir -p /data/prometheus

cat >> /etc/prometheus/prometheus.yml << EOF
# A scrape configuration scraping a Node Exporter and the Prometheus server
# itself.
scrape_configs:
  # Scrape Prometheus itself every 10 seconds.
  - job_name: 'prometheus'
    scrape_interval: 10s
    static_configs:
      - targets: ['localhost:9090']
EOF

apt install net-tools
docker volume create prometheus_volume
docker run -d -p 9090:9090 --name prometheus \
 --net=host -v /etc/prometheus:/etc/prometheus \
-v prometheus_volume/data/prometheus prom/prometheus \
--config.file="/etc/prometheus/prometheus.yml" \
--storage.tsdb.path="prometheus_volume/data/prometheus"

mkdir /etc/grafana && cd /etc/grafana
wget -O grafana_config.ini https://raw.githubusercontent.com/grafana/grafana/master/conf/defaults.ini

mkdir -p /etc/grafana/provisioning/datasources
cat >> /etc/grafana/provisioning/datasources/datasource.yaml << EOF
apiVersion: 1

datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://localhost:9090
EOF

docker volume create grafana_volume
docker run -d -p 3000:3000 --name grafana \
--net=host -v /etc/grafana/grafana_config.ini:/etc/grafana/grafana.ini \
-v grafana_volume:/var/lib/grafana \
-v /etc/grafana/provisioning/datasources/datasource.yaml:/etc/grafana/provisioning/datasources/datasource.yaml grafana/grafana
