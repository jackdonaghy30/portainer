Vaultwarden (Bitwarden compatible server) - Docker Compose

Instruções rápidas

1. Copie o exemplo de .env e defina um token de admin seguro:

   cp .env.example .env
   # edite .env e defina ADMIN_TOKEN com um valor forte

2. Iniciar:

   docker compose up -d

3. Acessar:

- Se usar mapeamento de portas local (padrão), abra http://<host>:8080
- Para produção, recomendo colocar atrás de um reverse-proxy (Traefik ou nginx-proxy-manager). Remova a seção `ports` do serviço e adicione labels de proxy conforme necessário.

Observações:
- Os dados por padrão são salvos em `./vw-data` (SQLite). Para usar Postgres, configure `DATABASE_URL` no `.env` e ajuste conforme necessário.
- Não comite o arquivo `.env` com `ADMIN_TOKEN` público.

Comandos úteis

- Subir em background: `docker compose up -d`
- Ver logs: `docker compose logs -f vaultwarden`
- Parar: `docker compose down`

Exemplo mínimo de `.env` (veja `.env.example` para valores):

ADMIN_TOKEN=replace-with-secure-token

Segurança

- Gere um `ADMIN_TOKEN` forte e limite o acesso ao endpoint de administração.
- Faça backups periódicos da pasta `vw-data`.
