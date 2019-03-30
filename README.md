# dockarr

A self-contained Docker service for running [Plex](https://www.plex.tv), [Radarr](https://github.com/Radarr/Radarr), [Sonarr](https://github.com/Sonarr/Sonarr), and qbittorrent behind a [Letsencrypt](https://letsencrypt.org)-powered Nginx on a dynamic IP with [automatically updated](https://github.com/Sleavely/cloudflare-dyn-ip-updater) DNS from Cloudflare.

## Getting started

1. Configure the `.env` file
1. Run `setup.sh` to create some boilerplate directories
1. Run `docker-compose up` (with `--detach` to run in the background)

### letsencrypt

domains.txt should contain one line per certificate. If you want alternate names on the cert, these should be listed after the primary domain. e.g.

```
example.com www.example.com
myothersite.com
```

Certificates are output to `/letsencrypt/certs/{domain}`.

### qbittorrent

Because qbittorrent doesn't support setting a custom base path, it is not included in the reverse proxy. To configure it, you'll have to access it through localhost:8087 with the default user `admin` and password `adminadmin`.

1. Set download path to /downloads/incomplete and /downloads/done ?
