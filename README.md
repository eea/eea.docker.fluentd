# Ready to use Fluentd image with GELF and elasticsearch plugins

Use this image if you want to make fluentd store logs in elasticsearch or
graylog2


## Versions:

 - `:latest` [*Dockerfile*](https://github.com/eea/eea.docker.fluentd/blob/master/Dockerfile) (default)
 - `:0.12.19` [*Dockerfile*](https://github.com/eea/eea.docker.varnish/blob/0.12.19/Dockerfile)
 - `:1.0.1` [*Dockerfile*](https://github.com/eea/eea.docker.fluentd/blob/1.0.1-chaperone/Dockerfile) (deprecated)
 - `:1.0` [*Dockerfile*](https://github.com/eea/eea.docker.fluentd/blob/1.0/Dockerfile) (deprecated)

## How to run

    docker run -v /path/to/your/fluent.conf:/etc/fluent/fluent.conf eeacms/fluentd

## Dumping logs to files on host disk

This Docker image has a directory called ```/log``` which is the recommended
path for storing persistent file logs using the ```out_file``` rules.

After adding an ```out_file``` rule in your ```fluent.conf``` pointing to
```/log``` you can run the following command to store the logs on a host
directory:

    docker run -v /path/to/your/fluent.conf:/etc/fluent/fluent.conf -v /path/to/persistent/logs:/log eeacms/fluentd


## Dumping logs into another container

Alternativelly you can use a data volume containers for storing custom logs
into files:

First, create a container having a /log volume and give it an easy to remember
name:

    docker run -v /mylogidrectory --name logdata ubuntu true


Then modify your fluent.conf so it dumps logs into /mylogdirectory

Then, mount the volumes defined in logdata using the --volumes-from
option.


    docker run -v /path/to/your/fluent.conf:/etc/fluent/fluent.conf --volumes-from logdata eeacms/fluentd
