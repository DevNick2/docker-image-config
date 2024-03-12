FROM ubuntu:latest

# Definindo a pasta de trabalho
RUN mkdir /dir-project-container

# Configurando a variavel de ambiente responsável pelo timezone
ENV TZ=America/Sao_Paulo

# Aplicando as configurações de timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Preparando as aplicações do ambiente
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install software-properties-common -y && add-apt-repository ppa:ondrej/php -y
RUN apt-get update -y && apt-get install php7.4 -y 
RUN apt-get install curl -y
RUN apt-get install vim -y

# Instalando o GIT
RUN apt-get install git -y

# Dependências do PHP
RUN apt-get install \
    php7.4-common \
    php7.4-mysql \
    php7.4-xml \
    php7.4-xmlrpc \
    php7.4-curl \
    php7.4-gd \
    php7.4-imagick \
    php7.4-cli \
    php7.4-dev \
    php7.4-imap \
    php7.4-mbstring \
    php7.4-opcache \
    php7.4-soap \
    php7.4-zip \
    php-xml -y

# Instalando o composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalação do Node
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y

# Instalaçao do Yarn
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -y && apt-get install yarn -y

# Copiando os arquivos da pasta atual para a pasta de trabalho
ADD ./dir-project /dir-project-container/
