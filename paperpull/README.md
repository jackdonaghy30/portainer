# PaperPull Server - Docker Compose

PaperPull baixa extratos e recibos de bancos, cartões, lojas e serviços (somente leitura; você faz o login) e os organiza em PDFs, com opção de enviar para o Paperless-ngx.

## Como usar

1. Copie o exemplo de variáveis:

   ```bash
   cp .env.example .env
   ```

2. Ajuste `PUID`, `PGID`, `TZ` e `DATA_LOCATION` no `.env`.
3. Inicie:

   ```bash
   docker compose up -d
   ```

4. Veja o código de configuração inicial:

   ```bash
   docker logs paperpull
   ```

5. Acesse `http://<host>:8765` e escolha uma senha usando esse código.

O arquivo `seccomp-chrome.json` é obrigatório: ele permite o sandbox do Chrome usado nas janelas de login.

## Variáveis de ambiente

| Variável | Padrão | Descrição |
|----------|--------|-----------|
| `PAPERPULL_VERSION` | `0.71.0` | Tag da imagem |
| `PAPERPULL_PORT` | `8765` | Porta do painel |
| `PUID` / `PGID` | `1000` | Dono dos documentos |
| `TZ` | `America/Sao_Paulo` | Timezone |
| `DATA_LOCATION` | `./data` | Pasta dos documentos |
| `PAPERPULL_PASSWORD` | vazio | Senha do painel (opcional) |
| `PAPERPULL_HOSTS` | vazio | Nomes extras de acesso |
| `PAPERPULL_HOSTS_ONLY` | vazio | `1` restringe aos nomes de `PAPERPULL_HOSTS` |
| `PAPERLESS_SUBFOLDERS` | vazio | `1` cria uma subpasta por provedor no consume |

Para integrar ao Paperless-ngx, defina `PAPERLESS_CONSUME_LOCATION` no `.env` e descomente a linha correspondente em `volumes`.

## Comandos úteis

- Subir em background: `docker compose up -d`
- Ver logs: `docker compose logs -f paperpull`
- Parar: `docker compose down`
- Atualizar: altere `PAPERPULL_VERSION`, depois `docker compose pull && docker compose up -d`

## Segurança

- Mantenha a porta restrita à rede local; para acesso externo use uma VPN, nunca redirecione a porta no roteador.
- Em produção, use HTTPS via Nginx Proxy Manager e defina `PAPERPULL_HOSTS`.
- Faça backup da pasta de dados.
- Servidores em datacenter são tratados como bots por muitos provedores; prefira rodar em casa.

## Links

- [Repositório oficial](https://github.com/rheeloaded/paperpull)
- [Site](https://paperpull.net)
