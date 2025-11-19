#!/usr/bin/env bash

# Script to create a new service with all the necessary boilerplate
# Usage: ./new-service.sh <service-name>

set -e

if [ $# -eq 0 ]; then
    echo "Usage: $0 <service-name>"
    echo "Example: $0 myservice"
    exit 1
fi

SERVICE_NAME="$1"
SERVICE_DIR="./$SERVICE_NAME"

# Check if service directory already exists
if [ -d "$SERVICE_DIR" ]; then
    echo "Error: Service directory '$SERVICE_DIR' already exists"
    exit 1
fi

echo "Creating new service: $SERVICE_NAME"

# Create service directory
mkdir -p "$SERVICE_DIR"

# Create compose.yaml with all the necessary labels and configuration
cat > "$SERVICE_DIR/compose.yaml" << EOF
services:
  $SERVICE_NAME:
    image: example/image:latest
    container_name: $SERVICE_NAME
    restart: unless-stopped
    volumes:
      - ./volumes/data:/data
    networks:
      - traefik
    labels:
      traefik.enable: true
      traefik.http.routers.$SERVICE_NAME.rule: Host(\`$SERVICE_NAME.69b.place\`)
      # traefik.http.services.$SERVICE_NAME.loadbalancer.server.port: 80

      chadburn.enabled: "true"
      chadburn.job-exec.$SERVICE_NAME-job.schedule: "0 0 * * *"
      chadburn.job-exec.$SERVICE_NAME-job.command: "echo 'Example job'"

      homepage.group: Applications
      homepage.name: ${SERVICE_NAME^}
      homepage.description: Description
      homepage.icon: 
      homepage.href: https://$SERVICE_NAME.69b.place

networks:
  traefik:
    name: traefik
    external: true
EOF

echo "Service '$SERVICE_NAME' created successfully!"
echo "Directory: $SERVICE_DIR"
echo "Next steps:"
echo "  1. Edit $SERVICE_DIR/compose.yaml to configure your service"
echo "  2. Update the image, volumes, and environment variables as needed"
echo "  3. Adjust Traefik labels (uncomment port if needed)"
echo "  4. Configure chadburn job schedule and command"
echo "  5. Update homepage labels (group, name, description, icon)"
echo "  6. Start the service with: docker compose -f $SERVICE_DIR/compose.yaml up -d"
