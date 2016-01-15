FROM fluent/fluentd

MAINTAINER Eduard Zaharia <eduard.zaharia@eaudeweb.ro>

USER root
#RUN usermod -u 999 fluent
RUN chown -R fluent:fluent /var/log
USER fluent

RUN gem install fluent-plugin-record-reformer --no-rdoc --no-ri && \
 gem install fluent-plugin-elasticsearch --no-rdoc --no-ri && \
 gem install gelf --no-rdoc --no-ri

EXPOSE 5140/tcp 5140/udp
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
