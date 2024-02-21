# docker-docusaurus

![](https://img.shields.io/badge/multiarch-amd64(x86__64)%2C%20arm64%2C%20armv7%2C%20armv6-lightgrey?style=flat-square)
![](https://img.shields.io/github/actions/workflow/status/beveradb/docker-docusaurus/buildx.yml?branch=main?style=flat-square)

![](https://img.shields.io/docker/image-size/beveradb/docusaurus/latest?style=flat-square)
![](https://img.shields.io/docker/pulls/beveradb/docusaurus?style=flat-square)
![](https://img.shields.io/docker/stars/beveradb/docusaurus?style=flat-square)


⚠️ Warning: This is *not* the [recommended way to deploy](https://docusaurus.io/docs/deployment#choosing-a-hosting-provider) Docusaurus docs. Ideally you should use a static hosting provider or CDN. Only use this if you understand that and know you want to serve it from a container instead.

## What is Docusaurus

To quote the [official docs](https://docusaurus.io/docs):

⚡️ Docusaurus will help you ship a beautiful documentation site in no time.

💸 Building a custom tech stack is expensive. Instead, focus on your content and just write Markdown files.

💥 Ready for more? Use advanced features like versioning, i18n, search and theme customizations.

## What is this project

A simple Docker image for running Docusaurus inside a container, e.g. for deploying in Kubernetes if you cannot deploy to a CDN or static file hosting service for some reason.

## Features

* Alpine Linux (latest stable version from node:current-alpine tag)
* Node.js (latest stable version from node:current-alpine tag)
* Docusaurus (latest stable version)
* Cross-platform (Github Actions workflow builds for multiple architectures)

## Usage

Pull the image from Docker Hub and run it using whatever container runtime you're using.

```bash
docker pull beveradb/docusaurus
```

### Run locally

You can run a local test in Docker like so; this assumes you have your docusaurus config and docs in a folder called "docs", and want to serve on port 3000:

```bash
docker run -it --rm -p 3000:3000 -v `pwd`/docs:/docusaurus beveradb/docusaurus
```

Once the container starts, your docs should be available at URL:

```http
http://localhost:3000
```

### Configuration

* Docs and config must be volume mounted to path: `/docusaurus` inside the container

## License

This project is licensed under the [MIT License](LICENSE).
