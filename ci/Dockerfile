FROM php:7.3-apache

RUN apt-get update && apt-get install --no-install-recommends -y gnupg && apt-key update -y
RUN apt-get install --no-install-recommends -y automake \
    bash \
    ca-certificates \
    curl \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libldap2-dev \
    libnotify-bin \
    libpng-dev \
    libpq-dev \
    libtool \
    libssl-dev \
    libzip-dev \
    libghc-zlib-dev \
    libcurl4-gnutls-dev \
    libexpat1-dev \
    gettext \ 
    make \
    default-mysql-client \
    nasm \
    python-pip \
    python-setuptools \
    ssh-client \
    openssh-client \
    software-properties-common \
    unzip \
    wget \
    zip \
    zlib1g-dev \
    g++ \
    vim

# Make sure we're using the right security level so things don't break
RUN vi -c '%s/SECLEVEL=2/SECLEVEL=1/g' /etc/ssl/openssl.cnf -c 'wq' 

# Enable Apache Extensions We Need
RUN a2enmod proxy \
    proxy_ajp \
    proxy_http \
    rewrite \
    deflate \
    headers \
    proxy_balancer \
    proxy_connect \
    proxy_html \
    substitute \
    expires \
    vhost_alias

# Install Pecl Dependencies
RUN pecl install grpc

# Configure PHP Extensions: GD for Glide Image Resizing, LDAP for authentication and GRPC for Firebase
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure ldap --with-libdir=/lib/x86_64-linux-gnu/
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql zip mysqli gd opcache pcntl exif bcmath ldap
RUN docker-php-ext-enable grpc

# Install Composer 2 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install AWS CLI, we need it for deployment tooling, but you may not
RUN pip install awscli && ln -s /usr/local/bin/aws /usr/bin/aws

# Install nodejs
RUN curl -sL https://deb.nodesource.com/setup_14.x  | bash && apt-get install --no-install-recommends -y nodejs && npm install -g gulp bower

# Install git lfs
RUN wget https://github.com/git/git/archive/v2.21.0.zip -O git.zip && \
    unzip git.zip && \
    cd git-* && \
    make prefix=/usr/local all && \
    make prefix=/usr/local install

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install --no-install-recommends -y git-lfs && \
    git lfs install && \ 
    rm -rf /var/lib/apt/lists/* # cleanup caches when we're done
