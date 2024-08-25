FROM python:3.12
RUN apt-get update && \
    apt-get -y install mariadb-client
RUN mkdir /code
WORKDIR /code
RUN pip install --upgrade pip\
    && pip install --upgrade setuptools\
    && install poetry
ENV PYTHONPATH=/code