FROM python:3.10-alpine

WORKDIR /code

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk add --update --no-cache poetry

COPY poetry.lock  .
COPY pyproject.toml .

RUN poetry config virtualenvs.create false
RUN poetry install --no-root

CMD poetry run api/manage.py runserver