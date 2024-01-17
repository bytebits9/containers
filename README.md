# localstack

The development stack with preconfigured Docker containers is 
designed to assist in establishing a local environment for developing future applications.

## Dependencies

* [Docker](https://docs.docker.com/install/)
* [Docker Compose](https://docs.docker.com/v17.09/compose/install/)

## Installation

Copy the `.env.example` to `.env` or use `make setup`.

## Usage

Running the development stack
```bash
make start
```

Stop all services
```bash
make stop
```

Restart services
```bash
make restart
```

Cleaning up all docker resources
```bash
make prune
```

## License

The localstack is open-sourced software licensed under the [MIT](LICENSE.md)