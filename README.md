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
- [API Reference](docs/api.md)

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
bin/rails db:migrate
bin/rails db:seed
```

## Running the application

```bash
bin/dev
```

This starts both the Rails server and the Bootstrap Sass watcher. Visit
[http://localhost:3000](http://localhost:3000).

`bin/rails server` will also start the application, but will not compile or watch the
stylesheets — use `bin/dev` during development.

## API (Lab 10)

The application also exposes a read-mostly JSON API under `/api/v1`. Full route
list and document shapes: [docs/api.md](docs/api.md).

The API runs on the same local server as the rest of the app —
`bin/dev` on port **3000** — so no extra process is needed.

### Configuring the token

`repairs#index`, `repairs#show`, and `services#create` require a bearer token.
It's stored in Rails encrypted credentials, never in code or a committed file.

To set it:

```bash
bin/rails credentials:edit
```

Add (indentation matters — two spaces under `api`):

```yaml
api:
  token: <your own secret value>
```

### Consuming page

A separate personal page consumes the public part of this API (the price
list) from its own origin:
[https://aasb-2.github.io/webtech-lab-01/](https://aasb-2.github.io/webtech-lab-01/)

It expects the API to be running locally on `http://localhost:3000` — start
`bin/dev` before opening that page if you want its Wheelhouse section to load
live data.

### Example requests

Public — the price list:

```bash
curl http://localhost:3000/api/v1/services
```

Token-gated — repairs (replace `YOUR_TOKEN_HERE` with the value configured above):

```bash
curl http://localhost:3000/api/v1/repairs \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```