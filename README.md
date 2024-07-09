# Moonchain publisher
[![Latest release](https://img.shields.io/github/v/release/synternet/moonchain-publisher)](https://github.com/synternet/moonchain-publisher/releases/latest)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/synternet/moonchain-publisher/github-ci.yml?label=github-ci)](https://github.com/synternet/moonchain-publisher/actions/workflows/github-ci.yml)

Establishes connection with Moonchain blockchain node and publishes blockchain data to Synternet.

## Prerequisits

- Go compiler (v1.21).
- [Moonchain](https://github.com/MXCzkEVM/simple-mxc-node) node with accessible IPC or access to [RPC](https://doc.moonchain.com/docs/Resources/RPC).
- Publishing credentials. Learn more on the [Synternet Portal](https://portal.synternet.com/).

# Usage

```
make dep
make build
./moonchain-publisher --ipc-path /var/lib/moonchain/geth.ipc --prefix synternet
```

# Environment variables and flags

Environment variables can be passed to docker container. Flags can be passed as executable arguments.

| Environment variable  | Flag               | Description |
| --------------------- | ------------------ | ----------- |
| IPC_PATH              | ipc-path           | Moonchain node IPC path, e.g.: `/tmp/geth.ipc` |
| NATS_URLS             | nats-urls          | (optional) NATS connection URLs to Synternet brokers, e.g.: `nats://e.f.g.h`. URL to [broker](https://docs.synternet.com/build/dl-access-points). Default: testnet. |
| NATS_NKEY             | nats-nkey          | NATS user NKEY, e.g.: `SU..SI` (58 chars). See [here](#auth-with-nats-credentials). |
| NATS_JWT              | nats-jwt           | NATS user JWT, e.g.: `eyJ...`. See [here](#auth-with-nats-credentials). |
| PUBLISHER_PREFIX      | publisher-prefix   | Stream prefix, usually your organisation, e.g.: `synternet` prefix results in `synternet.moonchain.<tx,log-even,header,...>` stream subjects. Stream prefix should be same as registered wallet [alias](https://docs.synternet.com/build/data-layer/developer-portal/publish-streams#2-register-a-wallet---get-your-alias). |
| PUBLISHER_NAME        | publisher-name     | (optional) Stream publisher infix, e.g.: `foo` infix results in `prefix.foo.<tx,log-even,header,...>` stream subjects. Stream publisher infix should be same as registered publisher [alias](https://docs.synternet.com/build/data-layer/developer-portal/publish-streams#3-register-a-publisher). Default: `moonchain`. |

# Auth with NATS credentials
Synternet uses NATS authentication model. NATS has an accounts level with users belonging to those accounts. To publish user level NKEY and JWT have to be used, which are generated from account.

1. Acquire account level NKEY (in Synternet a.k.a. `access token`). See [here](https://docs.synternet.com/build/data-layer/developer-portal/publish-streams#7-get-the-access-token).
2. Generate user level `NATS_NKEY`, `NATS_JWT` from account level NKEY. Can be generated using [user generator](https://github.com/Synternet/data-layer-sdk?tab=readme-ov-file#user-credentials-generator).
3. Pass generated `NATS_NKEY` and `NATS_JWT`.

## Docker

### From source

```
docker build -t moonchain-publisher -f docker/Dockerfile .
```

### Prebuilt image

```
docker run --rm --env-file=.env -v /tmp/moonchain.ipc:/tmp/ethereum.ipc ghcr.io/synternet/moonchain-publisher:latest
```
