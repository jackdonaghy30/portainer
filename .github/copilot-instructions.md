# GitHub Copilot Instructions

## Visão Geral do Repositório

Este repositório contém configurações **Docker Compose** para múltiplos serviços auto-hospedados. Cada serviço é isolado em seu próprio diretório e segue uma estrutura padronizada.

## Estrutura de Diretórios

Cada serviço deve seguir esta estrutura:

```
<nome-do-servico>/
├── docker-compose.yml   # Configuração principal dos containers
├── .env.example         # Variáveis de ambiente documentadas (nunca commitar .env)
└── README.md            # Instruções de instalação e uso em português
```

## Serviços Existentes e Portas

| Serviço              | Porta(s) no Host       | Diretório              |
|----------------------|------------------------|------------------------|
| Portainer            | 9000, 9443             | `portainer/`           |
| Nginx Proxy Manager  | 80, 443, 81            | `nginx-proxy-manager/` |
| Vaultwarden          | 8080                   | `vaultwarden/`         |
| Speedtest Tracker    | 8082, 8443             | `speedtest-tracker/`   |
| Glance               | 8081                   | `glance/`              |
| Jellyfin Stack       | 8096, 8920, 7878, 8989, 8686, 8787, 9696, 8265, 8266, 5055, 6767 | `jellyfin/` |
| code-server          | 8444                   | `vscode-server/`       |
| Ollama + Open WebUI  | 11434, 3000            | `ollama/`              |
| Immich               | 2283, 3003             | `immich/`              |

## Rede Docker

A maioria dos serviços usa uma rede externa chamada `shared`. Ao criar um novo serviço que precisa se comunicar com outros serviços, use:

```yaml
networks:
  - shared

networks:
  shared:
    external: true
```

Serviços com redes isoladas (ex: `nginx-proxy-manager` com `npm_network`) são a exceção.

## Convenções para `docker-compose.yml`

- Sempre use `version: "3.8"`.
- Defina `restart: unless-stopped` (ou `restart: always` para serviços críticos como Portainer e Nginx Proxy Manager).
- Prefira variáveis de ambiente com valores padrão: `${VAR:-valor_padrao}`.
- Use `${VAR:?mensagem de erro}` para variáveis obrigatórias sem valor padrão (ex: senhas).
- Nomes de containers devem ser em `snake_case` ou `kebab-case`, sem prefixos redundantes.
- Volumes nomeados devem ser declarados na seção `volumes:` do arquivo.
- Imagens LinuxServer (`lscr.io/linuxserver/...`) exigem `PUID`, `PGID` e `TZ`.

## Convenções para `.env.example`

- Inclua **todas** as variáveis usadas no `docker-compose.yml`.
- Forneça valores padrão seguros e não-sensíveis.
- Para senhas e tokens, use um placeholder descritivo como `replace-with-secure-token`.
- Adicione comentários explicando cada variável.
- Nunca inclua valores reais de senhas ou tokens.

Exemplo:

```bash
# Timezone
TZ=America/Sao_Paulo

# Senha de acesso (obrigatória)
PASSWORD=replace-with-strong-password
```

## Convenções para `README.md`

Os READMEs devem ser escritos em **português** e conter:

1. Título e breve descrição do serviço.
2. Seção "Como usar" com passos numerados.
3. Tabela de variáveis de ambiente (se houver mais de 3).
4. Seção de comandos úteis (`docker compose up -d`, `logs`, `down`).
5. Notas de segurança quando relevante.
6. Links para documentação oficial.

## Segurança

- **Nunca** commitar arquivos `.env` (já configurado no `.gitignore`).
- Sempre usar `.env.example` para documentar variáveis sem valores sensíveis.
- Passwords e tokens devem usar placeholders descritivos no `.env.example`.
- Expor serviços com HTTPS via Nginx Proxy Manager em produção.
- Não expor portas de APIs internas (ex: porta Ollama `11434`) diretamente na internet.

## Adicionando um Novo Serviço

1. Crie um novo diretório com o nome do serviço em `kebab-case`.
2. Adicione `docker-compose.yml`, `.env.example` e `README.md`.
3. Use a rede `shared` se o serviço precisar se comunicar com outros.
4. Escolha uma porta de host ainda não utilizada (veja tabela acima).
5. Adicione o serviço à lista de serviços no `README.md` raiz.
6. Adicione um link para o README do serviço no `README.md` raiz.

## Padrões de Volume

- Dados de configuração: `${CONFIG_LOCATION:-./config}:/config`
- Dados persistentes locais: prefira caminhos relativos (`./data`) com fallback via variável de ambiente.
- Caches e dados temporários não precisam de variável de ambiente.
