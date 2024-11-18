FROM rabbitmq:3.8.0-management

# Copy config file
COPY rabbitmq.conf /etc/rabbitmq/

ENV RABBITMQ_NODENAME=rabbit@localhost

# Stay as root for installation and permission settings
USER root

# Download and install the delayed message plugin
RUN apt-get update && apt-get install -y curl \
    && curl -L https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.8.0/rabbitmq_delayed_message_exchange-3.8.0.ez > /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange-3.8.0.ez \
    && rabbitmq-plugins enable rabbitmq_delayed_message_exchange \
    && apt-get purge -y curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Set proper permissions
RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf && \
    chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/ && \
    chmod 600 /var/lib/rabbitmq/.erlang.cookie

# Finally switch to rabbitmq user
USER rabbitmq:rabbitmq
