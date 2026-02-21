# Portainer - Docker Compose Files

Este repositório contém arquivos Docker Compose para gerenciar múltiplos containers Docker.

## Serviços Disponíveis

### 1. Portainer
Ferramenta de gerenciamento Docker com interface web.

**Localização**: `portainer/`

# Overview

Este diretório reúne as configurações Docker usadas neste repositório.

Aplicações incluídas

- Portainer — interface para gestão de containers.
- Nginx Proxy Manager — proxy reverso com painel web e suporte a certificados.
 - Vaultwarden — servidor de senhas compatível com Bitwarden.
 - Speedtest Tracker — painel de testes de velocidade (persistência em `./data`).
 - Glance — coleção de páginas e widgets estáticos (conteúdo em `../glance/`).
 - Jellyfin — media server para organizar e servir sua coleção de mídia (`jellyfin/`).
 - code-server — VS Code no navegador, acessível remotamente via Docker (`code-server/`).

Leia os guias específicos para instruções detalhadas de instalação e uso:

- Portainer: [Portainer README](./portainer/README.md)
- Nginx Proxy Manager: [Nginx Proxy Manager README](./nginx-proxy-manager/README.md)
 - Vaultwarden: [Vaultwarden README](./vaultwarden/README.md)
 - Speedtest Tracker: [Speedtest Tracker README](./speedtest-tracker/README.md)
 - Glance: [Glance README](../glance/README.md)
 - Jellyfin: [Jellyfin README](./jellyfin/README.md)
 - code-server: [code-server README](./code-server/README.md)

Arquivo principal

- `docker-compose.yml` dentro da pasta de cada aplicação.

Para mais detalhes, abra os READMEs acima.
**Localização**: `nginx-proxy-manager/`
