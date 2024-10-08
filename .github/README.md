# Postfix Mail Server

![Docker](https://img.shields.io/badge/-Docker-2496ED?style=flat-square&logo=Docker&logoColor=white)
![Linux](https://img.shields.io/badge/-Linux-FCC624?style=flat-square&logo=linux&logoColor=black)

This project sets up a Postfix mail server using Docker and [mailtrap](https://mailtrap.io). The mail server can be used by other services to send emails.

## Features

- Lightweight Postfix mail server in a Docker container.
- Configurable via `main.cf`.
- Supports email routing using [mailtrap](https://mailtrap.io).
- Routes to all major email providers (`@outlook`, `@gmail`, `@yahoo`, etc.)

## Prerequisites

- Docker
- Docker Compose (optional, for easy setup)

## Getting Started

### 1. Clone the Repository

Clone this repository to your local machine:

```sh
git clone https://github.com/daily-coding-problem/postfix-mail-server.git
cd postfix-mail-server
```

### 2. Create `postfix/sasl_passwd`

Create the [`postfix/sasl_passwd`](/postfix/sasl_passwd) file with your credentials from [mailtrap](https://mailtrap.io).

### 3. Build the Docker Image

Build the Docker image using the `Dockerfile`:

```sh
docker compose build
```

### 4. Run the Docker Container

Run the Docker container with the built image:

```sh
docker compose up
```

### 5. Test Sending Emails

You can test sending emails by connecting to the mail server from another container or from your host machine using `telnet`:

```sh
telnet localhost 25
```

Once connected, use the following SMTP commands to send an email:

```
HELO localhost
MAIL FROM:<sender@example.com>
RCPT TO:<recipient@example.com>
DATA
Subject: Test Email

This is a test email.
.
QUIT
```

## License

This project is licensed under the MIT License.
