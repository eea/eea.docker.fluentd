# Ready to use Fluentd image with GELF and elasticsearch plugins

Use this image if you want to make fluentd store logs in elasticsearch or
graylog2

## How to run
```docker run -v /path/to/your/fluent.conf:/etc/fluent/fluent.conf eeacms/fluentd```

## Dumping logs to file

This Docker image has a volume called ```/log``` which is the recommended
path for storing persistent file logs using the ```out_file``` rules.

After adding an ```out_file``` rule in your ```fluent.conf``` pointing to
```/log``` you can run the following command:

```docker run -v /path/to/your/fluent.conf:/etc/fluent/fluent.conf -v /path/to/persistent/logs:/log eeacms/fluentd```
