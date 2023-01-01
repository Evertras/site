---
title: "Doing a quick release with GHA"
date: 2023-01-01T12:05:00+09:00
slug: "gha-release-ref"
summary: "A quick reference of how to deal with releases in Github Actions"
draft: false
---

A quick example/reference for how to deal with [release tags](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#release)
in GHA.

```yaml
name: Release

on:
  release:
    types: [published]

jobs:
  show-vars:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Print the SHA
        run: echo ${GITHUB_SHA}
      - name: Print out the full ref
        run: echo ${GITHUB_REF}
      - name: Print out the tag alone
        run: echo ${GITHUB_REF##*/}
```

Some actions might need the environment variable passed in, but doing something
like `${GITHUB_REF##*/}` isn't parsed by GHA. In this situation, we need to
pass the environment variable in with an extra intermediate step. Here's an
example that I used for [cynomys](https://github.com/Evertras/cynomys).

```yaml
# Reference:
# https://github.com/marketplace/actions/build-and-push-docker-images
name: docker

on:
  release:
    types: [published]

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: evertras
          password: ${{ secrets.DOCKER_API_KEY }}
      - name: Set environment variables
        run: echo "EVERTRAS_PUBLISHED_VERSION=${GITHUB_REF##*/}" >> $GITHUB_ENV
      - name: Build and push
        uses: docker/build-push-action@v3
        with:
          push: true
          tags: evertras/cynomys:${{ env.EVERTRAS_PUBLISHED_VERSION }},evertras/cynomys:latest
```
