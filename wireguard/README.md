# WireGuard Easy

This setup uses [wg-easy](https://github.com/wg-easy/wg-easy) which provides a web-based admin UI for WireGuard VPN management.

## Features

- Web-based admin interface accessible at `https://wg-easy.69b.place`
- Easy client management (create, edit, delete, enable/disable)
- QR code generation for easy mobile setup
- Download client configuration files
- Connection statistics and charts
- One-time links for secure client sharing

## First-time Setup

When you first start wg-easy, it will present a setup wizard where you can:

1. Set admin username and password
2. Configure the WireGuard host (should be your server's public IP or domain)
3. Set DNS servers and network configuration

## Unattended Setup (Optional)

If you want to automate the initial setup, uncomment and configure the `INIT_*` environment variables in `compose.yaml`:

```yaml
environment:
  INIT_ENABLED: true
  INIT_USERNAME: admin
  INIT_PASSWORD: ${WG_ADMIN_PASSWORD}
  INIT_HOST: ${SERVERURL}
  INIT_PORT: 51820
  INIT_DNS: 1.1.1.1,8.8.8.8
  INIT_IPV4_CIDR: 10.8.0.0/24
  INIT_IPV6_CIDR: 2001:0DB8::/32
  INIT_ALLOWED_IPS: 0.0.0.0/0,::/0
```

Then set the `WG_ADMIN_PASSWORD` environment variable.

## Migration from LinuxServer WireGuard

This replaces the previous LinuxServer WireGuard container. The new setup:

- Uses the same UDP port (51820) for WireGuard traffic
- Adds a web interface on port 51821 (TCP)
- Stores configuration in `./volumes/etc_wireguard/` instead of `./volumes/config/`
- Provides much easier client management through the web UI

## Access

- **Web Interface**: https://wg-easy.69b.place
- **WireGuard Port**: 51820 (UDP)
- **Network**: Uses the traefik network for reverse proxy integration