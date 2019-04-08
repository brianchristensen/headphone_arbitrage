# Headphone Arbitrage
Scrape headphone forums, analyze price history, find sales listings under market value, profit!

docker pull docker.elastic.co/elasticsearch/elasticsearch:6.7.1

docker pull brianchristensen/dev:headphone_arbitrage

docker run -d -e "HOST=arbitrage.onthewifi.com" -e "ESADDR=http://arbitrage.onthewifi.com:9200" -e "PORT=4000" -e "BASIC_AUTH_USER=myuser" -e "BASIC_AUTH_PASS=mypass" -e "BASIC_AUTH_REALM=prod" -p 80:4000 brianchristensen/dev:arbitrage

docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.7.1

