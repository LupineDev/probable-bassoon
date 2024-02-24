# probable-bassoon
This is the rails app for Tree-node coding challenge

## README


## Ruby & Rails Version
Created with Ruby 3.3.0 and Rails 7.1.3.2

## Running Locally

### System dependencies
Project is dockerized for development and requires following dependencies to run
- docker (with buildx and compose plugins)
- make

### Initial Setup
To build the required docker containers then initialize and seed the database. **NOTE:** only seeded with node data from `data/nodes.csv` No birds data are seeded.
```
make bootstrap
```

### Working With the Application
Launch the local server on port `3000`
```
make run
```

Start a shell in development Rails `development` environment
```
make bash
```

Run the test suite
```
make rspec
```

Start a shell in development Rails `test` environment (usually for running indivitual tests)
```
make bash
```

To rubuild the docker images afer making changes to `Dockerfile` or `Gemfile`
```
make update
```

Wiping local database and re-initizing & seeding
```
make reset
```
