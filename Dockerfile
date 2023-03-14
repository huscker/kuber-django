FROM python:3.10-alpine

WORKDIR /code

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk add --update --no-cache poetry
RUN apk add --no-cache postgresql-libs
RUN apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev python3-dev

COPY poetry.lock  .
COPY pyproject.toml .

RUN poetry config virtualenvs.create false
RUN poetry install --no-root

COPY . .

CMD poetry run python api/manage.py runserver 0.0.0.0:8000