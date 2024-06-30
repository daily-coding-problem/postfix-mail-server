# Use an official Postfix image as the base image
FROM debian:buster-slim

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Install Postfix
RUN apt-get update && \
    apt-get install -y postfix mailutils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the Postfix configuration file
COPY postfix/main.cf /etc/postfix/main.cf

# Copy sasl_passwd and sender_relay files and set permissions
COPY postfix/sasl_passwd /etc/postfix/sasl_passwd
COPY postfix/sender_relay /etc/postfix/sender_relay
RUN postmap /etc/postfix/sasl_passwd && \
    postmap /etc/postfix/sender_relay && \
    chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db && \
    chmod 600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db && \
    chown root:root /etc/postfix/sender_relay /etc/postfix/sender_relay.db && \
    chmod 600 /etc/postfix/sender_relay /etc/postfix/sender_relay.db

# Expose port 25 (SMTP)
EXPOSE 25

# Start Postfix
CMD ["postfix", "start-fg"]
