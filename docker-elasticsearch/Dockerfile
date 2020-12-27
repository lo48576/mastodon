FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.8.10

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji && \
  /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu
