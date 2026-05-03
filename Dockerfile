# Use an official Python runtime as a parent image (supports both amd64 and arm64)
FROM python:3.11-slim

# Keep Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
# Turn off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

ARG CAMPLY_VERSION
# Install specific version if provided, otherwise install the latest
RUN if [ -z "$CAMPLY_VERSION" ]; then \
        pip install --no-cache-dir camply; \
    else \
        pip install --no-cache-dir camply==${CAMPLY_VERSION}; \
    fi

# Set the entrypoint to the camply CLI
ENTRYPOINT ["camply"]
