FROM gliderlabs/logspout:master

ADD https://raw.githubusercontent.com/looplab/logspout-logstash/master/logstash.go /go/src/github.com/looplab/logspout-logstash/logstash
