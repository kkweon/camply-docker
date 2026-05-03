# -- Build Stage --
FROM python:3.11-slim AS builder

# Install system build dependencies that might be needed for building python wheels
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc python3-dev && \
    rm -rf /var/lib/apt/lists/*

# Create a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

ARG CAMPLY_VERSION
# Install specific version if provided, otherwise install the latest.
# Also clean up __pycache__ and .pyc files to save space.
RUN if [ -z "$CAMPLY_VERSION" ]; then \
        pip install --no-cache-dir camply; \
    else \
        pip install --no-cache-dir camply==${CAMPLY_VERSION}; \
    fi && \
    find /opt/venv -type d -name "__pycache__" -exec rm -r {} + && \
    find /opt/venv -name "*.pyc" -delete


# -- Final Stage --
FROM python:3.11-slim

# Keep Python from generating .pyc files and turn off buffering
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/opt/venv/bin:$PATH"

# Copy ONLY the virtual environment from the build stage (leaves behind gcc, caches, etc.)
COPY --from=builder /opt/venv /opt/venv

# Set the entrypoint to the camply CLI
ENTRYPOINT ["camply"]
