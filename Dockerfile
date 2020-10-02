FROM gcr.io/stackdriver-agents/stackdriver-logging-agent:1.6.35

ADD lib/fluent/plugin/out_google_cloud.rb /out_google_cloud.rb

RUN mv /out_google_cloud.rb /opt/google-fluentd/embedded/lib/ruby/gems/*/gems/fluent-plugin-google-cloud-*/lib/fluent/plugin/

RUN /opt/google-fluentd/usr/sbin/google-fluentd-gem install fluent-plugin-parser_cef

RUN sed -i 's#_tag>\\S\*)#_tag\>[^:]*):#g' /opt/google-fluentd/embedded/lib/ruby/gems/*/gems/fluent-plugin-parser_cef-*/lib/fluent/plugin/parser_cef.rb
RUN sed -i 's#syslog_header = /#syslog_header = / \\<([0-9]+)\\>#g' /opt/google-fluentd/embedded/lib/ruby/gems/*/gems/fluent-plugin-parser_cef-*/lib/fluent/plugin/parser_cef.rb
RUN sed -i 's/CEF://g' /opt/google-fluentd/embedded/lib/ruby/gems/*/gems/fluent-plugin-parser_cef-*/lib/fluent/plugin/parser_cef.rb

ADD netsyslog.conf /etc/google-fluentd/config.d/netsyslog.conf

ADD entrypoint2.sh /entrypoint2.sh
RUN chmod +x /entrypoint2.sh

ENTRYPOINT ["/entrypoint2.sh"]
CMD ["/usr/sbin/google-fluentd"]