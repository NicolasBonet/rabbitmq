FROM rabbitmq:3.8.0-management

COPY rabbitmq.conf /etc/rabbitmq/

ENV RABBITMQ_NODENAME=rabbit@localhost

RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf

USER rabbitmq:rabbitmq

RUN mkdir -p /plugins && \
	curl -fsSL \
	-o "/plugins/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez" \
	https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.8.0/rabbitmq_delayed_message_exchange-3.8.0.ez

COPY --from=builder --chown=rabbitmq:rabbitmq \
	/plugins/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez \
	$RABBITMQ_HOME/plugins/rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez

RUN rabbitmq-plugins enable rabbitmq_delayed_message_exchange

RUN rabbitmq-plugins enable rabbitmq_consistent_hash_exchange
