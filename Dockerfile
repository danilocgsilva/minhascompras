FROM debian:stable-20220912-slim
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    git \
    vim \
    curl \
    apache2 \
    lsb-release \
    ca-certificates \
    apt-transport-https \
    software-properties-common \
    gnupg2 \
    zip
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list
RUN curl -fsSL  https://packages.sury.org/php/apt.gpg| gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-keyring.gpg
RUN apt update
RUN apt install php8.1 -y
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
RUN composer create-project symfony/skeleton -d /var/www
EXPOSE 80
CMD apachectl -D FOREGROUND
