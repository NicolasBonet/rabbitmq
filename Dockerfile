FROM rabbitmq:3.8.0-management

# Copy config file
COPY rabbitmq.conf /etc/rabbitmq/

ENV RABBITMQ_NODENAME=rabbit@localhost

# Download and install the delayed message plugin
RUN apt-get update && apt-get install -y curl \
    && curl -L https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.8.0/rabbitmq_delayed_message_exchange-3.8.0.ez > /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange-3.8.0.ez \
    && rabbitmq-plugins enable rabbitmq_delayed_message_exchange \
    && apt-get purge -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Set permissions for config file
RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf

USER rabbitmq:rabbitmq
