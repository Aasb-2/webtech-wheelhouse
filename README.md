# Wheelhouse

Wheelhouse is a neighbourhood bicycle repair shop. This application is its public-facing
website: what the shop does, what it costs, how to bring a bike in, and who runs it.

This repository also carries the specification the application is built from, and will
grow into the full Wheelhouse system over the course of the semester.

## Documentation

- [User Stories](docs/user-stories.md)
- [Domain Model](docs/domain-model.md)
- [Decisions](docs/decisions.md)
- [Wireframes](docs/wireframes.md)

## Prerequisites

Install these before setting up the project:

- **Ruby 3.2.0** (or compatible with Rails 8.1) — check with `ruby -v`
- **Rails 8.1** — check with `rails -v`
- **Node 26.1.0** and **Yarn** — check with `node -v` and `yarn -v`
- **PostgreSQL**, running locally, with a role that can create databases

## Setup

Clone the repository, then from its root, run the following in order:

```bash
bundle install
yarn install
bin/rails db:create
```

## Running the application

```bash
bin/dev
```

This starts both the Rails server and the Bootstrap Sass watcher. Visit
[http://localhost:3000](http://localhost:3000).

`bin/rails server` will also start the application, but will not compile or watch the
stylesheets — use `bin/dev` during development.