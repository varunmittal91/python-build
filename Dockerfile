# Use official python image as the base image
from python:3.11.10-slim-bookworm

# Set environment variables
env PYTHONUNBUFFERED=1 \
    POETRY_VERSION=1.8.3 \
    GCLOUD_SDK_VERSION=467.0.0

# Install dependencies
run <<EOF
    apt-get update &&
    apt-get install -y --no-install-recommends \
        curl \
        git \
        gnupg \
        ca-certificates &&
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list &&
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg &&
    apt-get update &&
    apt-get install -y google-cloud-cli=${GCLOUD_SDK_VERSION}-0 &&
    rm -rf /var/lib/apt/lists/* &&
    rm -rf /var/cache/apt/archives &&
    rm -rf /root/.cache &&
    apt-get clean
EOF

# Install Poetry
run <<EOF
    curl -sSL https://install.python-poetry.org | python3.11 - &&
    ln -s /root/.local/bin/poetry /usr/local/bin/poetry
EOF

# Install pip packages
run <<EOF
   pip install keyring &&
   pip install keyrings.google-artifactregistry-auth &&
   pip install jinja2
EOF
