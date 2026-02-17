# Jellyfin Stack

Stack para gerenciar mídia (vídeos, TV shows, audiobooks, músicas), downloads e legendas.

Serviços inclusos:
- Jellyfin (media server)
- qBittorrent (torrent)
- Radarr (filmes)
- Sonarr (séries)
- Lidarr (música)
- Readarr (audiobooks)
- Prowlarr (indexers)
- Bazarr (legendas)
- TVHeadend (IPTV/DVB)

Observações rápidas:
- Este compose usa imagens do LinuxServer (aceitam `PUID`, `PGID`, `TZ`).
- A rede é `shared` e definida como `external: true` para integrar com outros stacks (veja `immich`).
- Não incluí um container VPN — você indicou que já usa Tailscale, então não é necessário aqui.

Como usar:
1. Copie para o servidor e abra a pasta `jellyfin-stack`.
2. Defina variáveis de ambiente via `export` ou um arquivo `.env` (exemplo abaixo).
3. Suba com:

```bash
docker compose up -d
```

Exemplo de `.env` (opcional):

```
PUID=1000
PGID=1000
TZ=Europe/London
```

Pastas esperadas criadas localmente:
- `config/` — configurações por serviço
- `media/` — `movies`, `tv`, `music`, `audiobooks` (você organiza)
- `downloads/` — pasta de torrent

Próximos passos recomendados:
- Ajustar permissões (`PUID`/`PGID`) para o usuário que executa o Docker.
- Configurar integrações entre Radarr/Sonarr/Lidarr/Readarr e qBittorrent (via Prowlarr para indexers).
- Configurar Bazarr para buscar legendas automaticamente.
- Se usar hardware de GPU, ajuste permissões e mapeamentos (`/dev/dri` ou runtime NVIDIA).
