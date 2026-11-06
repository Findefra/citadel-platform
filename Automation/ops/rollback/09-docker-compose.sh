#!/usr/bin/env bash
# 09-docker-compose.sh
# Simple Docker Compose service image rollback pattern
# Usage: ./09-docker-compose.sh <service> <previous-image:tag> [compose-file]

set -euo pipefail

SERVICE=${1:?Service name required}
PREVIOUS_IMAGE=${2:?Previous image:tag required}
COMPOSE_FILE=${3:-docker-compose.yml}

echo "=== Docker Compose Image Rollback ==="
echo "Service        : $SERVICE"
echo "Previous image : $PREVIOUS_IMAGE"
echo "Compose file   : $COMPOSE_FILE"
echo

# For classic docker-compose
if command -v docker-compose &>/dev/null; then
  docker-compose -f "$COMPOSE_FILE" stop "$SERVICE"
  # You typically edit the image in the compose file or use an override
  echo "Update the image for $SERVICE to $PREVIOUS_IMAGE in $COMPOSE_FILE (or override file), then:"
  echo "  docker-compose -f $COMPOSE_FILE up -d $SERVICE"
else
  # Modern docker compose plugin
  docker compose -f "$COMPOSE_FILE" stop "$SERVICE"
  echo "Update the image for $SERVICE to $PREVIOUS_IMAGE, then:"
  echo "  docker compose -f $COMPOSE_FILE up -d $SERVICE"
fi

# Swarm alternative (commented):
# docker service update --image "$PREVIOUS_IMAGE" "$SERVICE"
