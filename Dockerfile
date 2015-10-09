FROM kiyoto/fluentd:0.10.56-2.1.1

MAINTAINER Mihai Bivol <mihai.bivol@eaudeweb.ro>

RUN apt-get update -q && apt-get install -y python3-pip && \
    pip3 install chaperone

RUN mkdir -p /etc/fluent/ /log /etc/chaperone.d

RUN /usr/local/bin/gem install fluent-plugin-record-reformer --no-rdoc --no-ri
RUN /usr/local/bin/gem install fluent-plugin-elasticsearch --no-rdoc --no-ri
RUN /usr/local/bin/gem install gelf --no-rdoc --no-ri
RUN mkdir /etc/fluent/plugin
ADD out_gelf.rb /etc/fluent/plugin/

EXPOSE 5140
EXPOSE 5140/udp

COPY chaperone.conf /etc/chaperone.d/chaperone.conf
ENTRYPOINT ["/usr/local/bin/chaperone"]
