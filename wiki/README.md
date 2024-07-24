# wiki.omni.cedille.club with mkdocs

This folder contains the source code for the Cedille Club's wiki, hosted at
[wiki.omni.cedille.club](https://wiki.omni.cedille.club).

## How to use

### Prerequisites

- Python 3.6 or newer
- [MkDocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

### Installation

1. Clone this repository.
2. Install the required dependencies with `pip install mkdocs-material` or
   `docker pull squidfunk/mkdocs-material` if you prefer to use Docker.
3. Run `mkdocs build -f .\mkdocs-en.yml` to build the site or `docker run --rm -it -v ${PWD}:/docs
   squidfunk/mkdocs-material build -f .\mkdocs-en.yml` if you prefer to use Docker.
4. Run `mkdocs serve -f .\mkdocs-en.yml` to start the live-reloading development server or `docker
   run --rm -it -p 8000:8000 -v ${PWD}:/docs squidfunk/mkdocs-material serve -f .\mkdocs-en.yml` if you
   prefer to use Docker.

### Folder structure

- `docs/`: Contains the Markdown files that make up the wiki.
- `mkdocs.yml`: The configuration file for MkDocs.
- `docs/en/index.md`: The homepage of the wiki.
- `docs/en/log791/`: Contains the Markdown files for the LOG791 project of the
  Cedille Club during the Fall 2023 semester.
- `docs/en/plateforme-cedille/`: Contains the Markdown files for the Cedille
  platform.
