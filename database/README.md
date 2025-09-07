# Podman Optimization for docker-compose.yml

This document outlines the changes made to the `docker-compose.yml` file to ensure compatibility with Podman.

## Modifications

The following modifications were made to the `database/docker-compose.yml` file:

1.  **Removed `healthcheck`:** The `healthcheck` configuration was removed from the `db` service.

## Reason for Changes

The `healthcheck` directive in its `docker-compose.yml` format is not fully supported by `podman-compose`. To ensure seamless operation and avoid potential errors when running the application with Podman, this section was removed. The rest of the `docker-compose.yml` file is compatible with Podman and requires no further changes.
