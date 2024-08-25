FROM python:3.12

ARG USER_PASSWORD="django-runner"
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo
ENV HOME=/home/django
ENV PYCURL_SSL_LIBRARY=openssl

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    curl \
    git \
    gcc \
    make \
    zip \
    nginx \
    python3-dev \
    libsqlite3-dev \
    libbz2-dev \
    libreadline-dev \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    default-libmysqlclient-dev \
    pkg-config \
    libcurl4-openssl-dev \
    graphviz \
    libgraphviz-dev \
    locales \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ロケールの設定
RUN locale-gen en_US.UTF-8 ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8


# 日本語フォント追加
RUN curl -L -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip && \
    unzip -d noto NotoSansCJKjp-hinted.zip && \
    mkdir -p /usr/share/fonts/opentype && \
    mv -fv noto /usr/share/fonts/opentype/noto && \
    rm -rfv NotoSansCJKjp-hinted.zip && \
    fc-cache -fv && \
    chmod -Rf a+r /usr/share/fonts/*

WORKDIR /var/www/django

# django ユーザー追加
RUN useradd -ms /bin/bash django && \
    echo "django:${USER_PASSWORD}" | chpasswd && \
    echo "django ALL=(ALL) ALL" >> /etc/sudoers && \
    usermod -aG www-data django

# app と nginxのログ のパーミッション変更
RUN chmod 2775 /var/log/nginx && \
    chgrp -R www-data /var/log/nginx && \
    chown -R django /var/www/django

USER django

# Poetryのインストール
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc


# COPY ./apps/poetry.lock /var/www/django
# COPY ./apps/pyproject.toml /var/www/django

RUN poetry install --no-root

# pipの更新
RUN pip install -U pip

# Prepare log files 
COPY docker/django/stdout_log.sh /opt/stdout_log.sh
ENV USER_PASSWORD=${USER_PASSWORD}
EXPOSE 8000

CMD ["/bin/bash", "/opt/stdout_log.sh"]