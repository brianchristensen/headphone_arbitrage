# Headphone Arbitrage
Scrape headphone forums, analyze price history, find sales listings under market value, profit!

http://http://arbitrage.servebeer.com/

myuser/mypass

## Run local

`docker pull docker.elastic.co/elasticsearch/elasticsearch:6.7.1

docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.7.1

cd dashboard && mix phx.server

http://localhost:4000

username=testuser password=testpass`

## Run server

`docker pull docker.elastic.co/elasticsearch/elasticsearch:6.7.1

docker pull brianchristensen/dev:arbitrage

docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.7.1

docker run -e "BASIC_AUTH_USER=myuser" -e "BASIC_AUTH_PASS=mypass" -e "BASIC_AUTH_REALM=prod" -e "HOST=arbitrage.servebeer.com" -e "PORT=80" -e "ESADDR='http:localhost:9200'" -network="host" brianchristensen/dev:arbitrage`
