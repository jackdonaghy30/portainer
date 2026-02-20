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
- Tdarr (transcodificação automática)
- TVHeadend (IPTV/DVB)

Observações rápidas:
- Este compose usa imagens do LinuxServer (aceitam `PUID`, `PGID`, `TZ`).
- A rede é `shared` e definida como `external: true` para integrar com outros stacks (veja `immich`).
- Não incluí um container VPN — você indicou que já usa Tailscale, então não é necessário aqui.

Como usar:
1. Copie para o servidor e abra a pasta `jellyfin`.
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
- Configurar Tdarr para transcodificar automaticamente (ex: converter H.264 → H.265).
- Se usar hardware de GPU, ajuste permissões e mapeamentos (`/dev/dri` ou runtime NVIDIA).

## Tdarr - Transcodificação Automática

**Tdarr** é um sistema distribuído de transcodificação que permite:
- Converter automaticamente vídeos (ex: H.264 → H.265 HEVC, economizando 40-50% de espaço)
- Processar arquivos paralelamente
- Aplicar regras e filtros aos vídeos
- Verificar a integridade dos arquivos

### Acessar Tdarr
- **URL**: http://localhost:8265
- **Porta Server**: 8266

### Configurar Tdarr

1. Crie a variável `TRANSCODE_CACHE` no `.env` para o diretório de cache:
```
TRANSCODE_CACHE=/mnt/transcode_cache
```

2. Acesse http://localhost:8265 e:
   - Adicione sua biblioteca de mídia (Libraries)
   - Configure regras de transcodificação (Plugins/Stacks)
   - Ajuste workers e agendamento

### Integração com Radarr/Sonarr (transcodificação automática pós-download)

Você pode integrar Tdarr com Radarr/Sonarr para que **cada filme ou série recém baixado seja automaticamente transcodificado pelo FFmpeg**. Siga os passos abaixo:

#### 1. Configure uma biblioteca no Tdarr

1. Acesse http://localhost:8265 → **Libraries** → **Add Library**.
2. Defina o **Source** como `/media/movies` (filmes) ou `/media/tv` (séries) — os mesmos caminhos mapeados no container.
3. Ative **File watcher** para que o Tdarr detecte novos arquivos automaticamente.
4. Configure o **Transcode plugin stack** desejado (ex: H.264 → H.265 HEVC).
5. Salve e ative a biblioteca.

#### 2. Configure o Radarr para mover os arquivos para a biblioteca

Certifique-se de que o **Radarr** está configurado para mover (não copiar) os arquivos baixados para `/movies`. Com o **File watcher** ativo no Tdarr, nenhuma configuração extra é necessária: o Tdarr detecta o novo arquivo automaticamente e inicia a transcodificação via FFmpeg.

> **Opcional — webhook do Radarr**: Se preferir um scan imediato em vez de esperar o file watcher, você pode configurar um webhook em Radarr → **Settings** → **Connect** → **Webhook** apontando para a API do Tdarr. Consulte a [documentação oficial do Tdarr](https://docs.tdarr.io/) para o endpoint e parâmetros corretos da versão instalada.

#### 3. Verifique o fluxo

```
qBittorrent (baixa) → Radarr (move para /movies) → Tdarr detecta (file watcher) → FFmpeg transcodifica → Jellyfin reproduz
```

#### 4. Translação de caminhos (se necessário)

Se os caminhos do host forem diferentes entre os containers, configure **path translators** no arquivo:
```
configs/tdarr/configs/Tdarr_Server_Config.json
```

### Recursos e Documentação

- **Site**: https://tdarr.io/
- **Docs**: https://docs.tdarr.io/
- **GitHub**: https://github.com/HaveAGitGat/Tdarr
- **Discord**: https://discord.gg/waKdfJR
- **Plugins**: https://github.com/HaveAGitGat/Tdarr_Plugins

### Hardware Acceleration

Os volumes já estão configurados para Intel/AMD (`/dev/dri`). Se tiver GPU NVIDIA, descomente as seções de GPU no docker-compose.yml.
