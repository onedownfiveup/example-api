# Example API

An tamplate API using GrapeAPI and Warden for authentication

## Libraries used in this app
- GrapeAPI: https://github.com/ruby-grape/grape
- Warden for authentication
- rom https://rom-rb.org/5.0/learn/
- dry suite: (dry-configurable, dry-transaction, dry-types, dry-validation) https://dry-rb.org
- RSpec: https://rspec.info


## Setup

1. Install Docker
2. Run `bin/setup`.
3. `cp .env.sample .env` and modify accordingly.

## Running the app

```bash
docker-compose up
```

## Running tests
The following will run the rubocop ruby linter and then run the rspec test suite.

```bash
docker-compose run --rm app rake test
```

## Running console

```bash
docker-compose run --rm app bin/console
```
