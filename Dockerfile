FROM kiyoto/fluentd:0.10.56-2.1.1

MAINTAINER Mihai Bivol <mihai.bivol@eaudeweb.ro>

RUN apt-get update -q && apt-get install -y gcc python3-pip && \
    apt-get clean && pip3 install chaperone && rm -rf /tmp/* /var/tmp/* && \
    mkdir -p /etc/fluent /log /etc/fluent/plugin && \

    /usr/local/bin/gem install fluent-plugin-record-reformer --no-rdoc --no-ri && \
    /usr/local/bin/gem install fluent-plugin-elasticsearch --no-rdoc --no-ri && \
    /usr/local/bin/gem install gelf --no-rdoc --no-ri

ADD out_gelf.rb /etc/fluent/plugin/
EXPOSE 5140/tcp 5140/udp

RUN useradd 500 && usermod -u 500 500 && \
    groupmod -g 500 500 && chown -R 500:500 /var/log/ /etc/fluent/

USER 500
COPY chaperone.conf /etc/chaperone.d/chaperone.conf
ENTRYPOINT ["/usr/local/bin/chaperone"]
