# localstack

The development stack with preconfigured Docker containers is 
designed to assist in establishing a local environment for developing future applications.

## Requirements

Tools used by this project:

- Bash 
- Make
- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Installation

### Pre-install

Execute the following command:

```bash
make project-init
```
### Configure

Configure the .env file and the configuration files located in the `conf/` folder for your own needs.

### Post-install

Execute the following command to start the stack:

```bash
make docker-up
```
### Usage

Execute the following command to see all the available commands:

```bash
make help
```

## License

The localstack is open-sourced software licensed under the [MIT](LICENSE.md)