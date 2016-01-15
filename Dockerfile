FROM centos:7

MAINTAINER Mihai Bivol <mihai.bivol@eaudeweb.ro>
MAINTAINER Eduard Zaharia <eduard.zaharia@eaudeweb.ro>

RUN yum update -y && \
    yum install -y centos-release-scl-rh && \
    yum install -y scl-utils make gcc bzip2 rh-ruby22 rh-ruby22-ruby-devel  && \

    yum -y install epel-release && \
    yum install python34 python34-devel -y && \
    curl -s "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python3.4 get-pip.py && \
    cd /usr/bin && ln -s python3.4 python3 && \
    pip3 install chaperone && \
    yum clean all && yum -y autoremove && rm -rf /tmp/

ENV LD_LIBRARY_PATH /opt/rh/rh-ruby22/root/usr/lib64
RUN scl enable rh-ruby22 'gem update --system --no-document' && \
    scl enable rh-ruby22 'gem install --no-document json_pure jemalloc' && \
    scl enable rh-ruby22 "gem install fluentd" && \
    ln -s /opt/rh/rh-ruby22/root/usr/bin/* /usr/local/bin/ && \
    ln -s /opt/rh/rh-ruby22/root/usr/local/bin/* /usr/bin

RUN /usr/local/bin/gem install fluent-plugin-record-reformer --no-rdoc --no-ri && \
    /usr/local/bin/gem install fluent-plugin-elasticsearch --no-rdoc --no-ri && \
    /usr/local/bin/gem install gelf --no-rdoc --no-ri

# fluent.conf added for individual testing of container 
#ADD test-fluent.conf /etc/fluent/fluent.conf
ADD out_gelf.rb /etc/fluent/plugin/
EXPOSE 5140/tcp 5140/udp

RUN useradd 500 && usermod -u 500 500 && \
    chown -R 500:500 /var/log/ /etc/fluent/

USER 500
COPY chaperone.conf /etc/chaperone.d/chaperone.conf
ENTRYPOINT ["/usr/bin/chaperone"]
