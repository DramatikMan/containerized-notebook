FROM python:3.11-slim
SHELL ["/bin/bash", "-c"]
WORKDIR /project
ENV PYTHONPATH "${PYTHONPATH}:/project"

RUN apt update && apt install make -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && pip install poetry \
    && poetry config virtualenvs.in-project true \
    && poetry config installer.modern-installation false \
    && mkdir .venv

COPY pyproject.toml poetry.lock* ./
RUN poetry install --no-root

COPY Makefile .flake8 ./
COPY notebook notebook
CMD make jupyter
