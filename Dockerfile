FROM kiyoto/fluentd:0.10.56-2.1.1

MAINTAINER Mihai Bivol <mihai.bivol@eaudeweb.ro>

RUN apt-get update -q && apt-get install -y supervisor

RUN mkdir -p /etc/fluent/
RUN mkdir -p /log

RUN /usr/local/bin/gem install fluent-plugin-record-reformer --no-rdoc --no-ri
RUN /usr/local/bin/gem install fluent-plugin-elasticsearch --no-rdoc --no-ri
RUN /usr/local/bin/gem install gelf --no-rdoc --no-ri
RUN mkdir /etc/fluent/plugin
ADD out_gelf.rb /etc/fluent/plugin/

EXPOSE 5140
EXPOSE 5140/udp

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
