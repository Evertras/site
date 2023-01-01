---
title: "Doing a quick release with GHA"
date: 2023-01-01T12:05:00+09:00
slug: "gha-release-ref"
summary: "A quick reference of how to deal with releases in Github Actions"
draft: false
---

A quick example/reference for how to deal with [release
tags](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#release)
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

Obviously replace the above with whatever will actually do the release, but
that's how you get the tags to plug into things like Docker tags and such.
