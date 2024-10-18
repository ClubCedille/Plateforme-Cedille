# wiki.omni.cedille.club with mkdocs

This folder contains the source code for the CEDILLE Club's wiki, hosted at
[wiki.omni.cedille.club](https://wiki.omni.cedille.club).

## How to use

### Prerequisites

- Python 3.6 or newer
- [MkDocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

Optionally, you can use [Docker](https://docs.docker.com/get-started/) to build and run the wiki.

### Usage

1. Clone this repository.
2. Install the required dependencies with `pip install mkdocs-material`
3. Run `mkdocs build -f ./mkdocs-en.yml` to build the site.
4. Run `mkdocs serve -f ./mkdocs-en.yml` to start the live-reloading development server.

#### Docker

To make your life easier, and test both the English and French versions of the
wiki, you can use the provided Dockerfile. Simply build the image with

```sh
docker build --build-arg WIKI_DIR="./" -t cedille-wiki .
```

and run the container with

```sh
docker run -p 8080:8080 -v $(pwd):/docs cedille-wiki
```

### Folder structure

- `docs/`: Contains the Markdown files that make up the wiki.
- `mkdocs.yml`: The configuration file for MkDocs.
- `docs/en/index.md`: The homepage of the wiki.
- `docs/en/log791/`: Contains the Markdown files for the LOG791 project of the
  CEDILLE Club during the Fall 2023 semester.
- `docs/en/plateforme-cedille/`: Contains the Markdown files for the CEDILLE
  platform.
