# Use the prebuilt RabbitMQ image with the delayed message exchange plugin
FROM heidiks/rabbitmq-delayed-message-exchange:3.13.3

# Optional: Copy your custom configuration file
COPY rabbitmq.conf /etc/rabbitmq/

# Set environment variables
ENV RABBITMQ_NODENAME=rabbit@localhost

# Set permissions for the configuration file
RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf

# Specify the default user
USER rabbitmq:rabbitmq
