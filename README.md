# Personal website

This repository contains the Hugo source for <https://acarril.github.io>.
GitHub Actions validates pull requests and deploys pushes to `main`.

## Requirements

- Git
- Go 1.20 or newer, required by the Bootstrap icons Hugo module
- Hugo 0.164.0 extended, matching the version pinned in CI

## Local setup

Clone the repository with its theme submodule:

```sh
git clone --recurse-submodules git@github.com:acarril/acarril.github.io.git
cd acarril.github.io
```

For an existing checkout, initialize or update the pinned theme with:

```sh
git submodule update --init --recursive
```

Start the development server:

```sh
hugo server
```

Create the same production build used by CI:

```sh
hugo --minify
```

Generated files are written to `public/` and are not tracked by Git.
