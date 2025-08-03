#!/usr/bin/env bash

for stack in /data/docker/*/compose.yaml; do
  docker compose -f $stack up -d
done
