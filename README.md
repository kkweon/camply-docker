# Camply Docker (Multi-Architecture)

[![Build and Push Camply](https://github.com/kkweon/camply-docker/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/kkweon/camply-docker/actions/workflows/build-and-push.yml)
[![PyPI version](https://badge.fury.io/py/camply.svg)](https://badge.fury.io/py/camply)

This repository automatically builds and publishes a multi-architecture Docker image for [juftin/camply](https://github.com/juftin/camply) specifically targeting `linux/amd64` and `linux/arm64` (e.g., Raspberry Pi 5).

## Usage

You can pull the image from this repository's GitHub Container Registry (GHCR):

```bash
docker pull ghcr.io/kkweon/camply:latest
```

Run a simple search:

```bash
docker run ghcr.io/kkweon/camply:latest recreation-areas --search "Glacier National Park"
```

## How It Works

A GitHub Action runs daily to check the [PyPI Registry](https://pypi.org/project/camply/) for the newest version of `camply`. If a new version is detected, it automatically builds Docker images for both `amd64` and `arm64` using QEMU/Docker Buildx, tags them with the version number, and publishes them to `ghcr.io/kkweon/camply`.
