# Headphone Arbitrage
Scrape headphone forums, analyze price history, find sales listings under market value, profit!

docker pull docker.elastic.co/elasticsearch/elasticsearch:6.7.1

docker run -d -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:6.7.1

cd dashboard && mix phx.server

http://localhost:4000
username=testuser password=testpass

