FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.3.1

RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji && \
  /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-icu
