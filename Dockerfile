# Use an official Postfix image as the base image
FROM debian:buster-slim

# Set environment variables for non-interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Install Postfix and dependencies
RUN apt-get update && \
    apt-get install -y postfix mailutils libsasl2-modules && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the Postfix configuration file
COPY postfix/main.cf /etc/postfix/main.cf

# Copy sasl_passwd file and set permissions
COPY postfix/sasl_passwd /etc/postfix/sasl_passwd
RUN postmap /etc/postfix/sasl_passwd && \
    chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db && \
    chmod 600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db

# Expose port 25 (SMTP)
EXPOSE 25

# Start Postfix in the foreground
CMD ["postfix", "start"]
