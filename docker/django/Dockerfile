FROM python:3.12

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Poetryのインストール
RUN curl -sSL https://install.python-poetry.org | python3 - && \
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# 作業ディレクトリの設定
WORKDIR /var/www/django

# nginxの設定ファイルを追加
COPY ./nginx /etc/nginx/conf.d

# Poetryの設定
COPY ./apps/pyproject.toml ./apps/poetry.lock ./
RUN poetry install --no-root

# 環境変数の設定
ENV PATH="/root/.local/bin:$PATH"

RUN pip install -U pip