# Hare 🐇

A lightweight Ruby CLI for working with SVN repositories and code reviews.

## Status

Early development (`0.0.1.dev`).

## Requirements

* Ruby
* Subversion (SVN)

## Installation

Clone the repository and install the dependencies:

```bash
bundle install
```

## Usage

Run the CLI:

```bash
./bin/hare
```

Currently, Hare can check whether SVN is installed and display its version.

Example:

```text
✓ SVN 1.14.5
```

## Development

Run the test suite:

```bash
bundle exec rake test
```

Run RuboCop:

```bash
bundle exec rubocop
```

## Roadmap

* [x] `hare doctor`
* [x] `hare sync`
* [x] `hare status`
* [x] `hare log`
* [ ] `hare diff`
* [ ] `hare review`
* [ ] Web interface
* [ ] Shared review state

## License

Not defined yet.

