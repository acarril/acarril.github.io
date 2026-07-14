# Personal website

This repository contains the Hugo source for <https://acarril.github.io>.
GitHub Actions validates pull requests and deploys pushes to `main`.

## Requirements

- Git
- Go 1.20 or newer, required by the Bootstrap icons Hugo module
- Hugo 0.164.0 extended, matching the version pinned in CI

## Local setup

Clone the repository:

```sh
git clone git@github.com:acarril/acarril.github.io.git
cd acarril.github.io
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

## Theme provenance

The site layouts and styles derive from [Etch](https://github.com/LukasJoswiak/etch)
by Lukas Joswiak, adapted through the
[`etch-academic` fork](https://github.com/acarril/etch-academic). They are
licensed under the MIT license in [`LICENSES/etch-academic.txt`](LICENSES/etch-academic.txt).
