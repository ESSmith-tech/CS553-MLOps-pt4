FROM python:3.10-slim

WORKDIR /opt/app
COPY . .
RUN pip install --no-cache-dir -r /opt/app/requirements.txt

# Install packages that we need. vim is for helping with debugging
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -yq ca-certificates && \
    apt-get install -yq --no-install-recommends
    
EXPOSE 7860
ENV GRADIO_SERVER_NAME="0.0.0.0"

# HF_TOKEN environment variable will be passed at runtime via Cloud Run secrets/env vars
#ENV PYTHONUNBUFFERED=1

CMD bash -c "python /opt/app/src/app.py"
