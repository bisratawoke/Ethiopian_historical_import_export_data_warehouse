FROM apache/airflow:2.9.0

ADD requirements.txt .

USER root

RUN apt update \
  && apt install -y --no-install-recommends \
         libpq-dev \ 
         python3-dev \
         build-essential \
  && apt autoremove -yqq --purge \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

USER airflow

RUN pip install dbt-core  dbt-postgres

RUN pip install apache-airflow==${AIRFLOW_VERSION}