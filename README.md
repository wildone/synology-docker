# Synology Docker

This repository contains the Docker Compose for running services on your Synology NAS.

## Running this on your Synology NAS

To use this repository, login to your Synology NAS and run the following command:

Linux:

```bash
./start
```

Update `.env` with setting appropriate for your environment.

## Running this on your local machine

Linux:

```bash
./start
```

Windows in powershell core:

```powershell
./start
```

By default console page will be on `https://localhost:5443/`.

## Restart clean stack


```powershell
./stop && ./clean && ./start
```