#!/bin/sh

# Hint:
#
# Before syncing a new pair works, a resync has to be done
# rclone bisync /localdir remote:/remotedir --resync -v
#
# For the configured path pairs this has been done already


umask 027


while true; do
  trap '' SIGINT SIGTERM   # Ignore signals
  rclone bisync /data/andi andi-drive:/documents --recover --resilient --max-lock 5m -v
  chown -R 1000:100 /data/andi
  trap - SIGINT SIGTERM    # Restore signal handling

  sleep 5

  trap '' SIGINT SIGTERM   # Ignore signals
  rclone bisync /data/kaddi kaddi-drive:/documents --recover --resilient --max-lock 5m -v
  chown -R 1001:100 /data/kaddi
  trap - SIGINT SIGTERM    # Restore signal handling

  echo "Sleeping for 10 minutes..."
  sleep 600
done
