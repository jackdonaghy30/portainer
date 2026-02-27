Uptime Kuma — Docker Compose

Instruções rápidas

1. Copie o exemplo de .env e ajuste conforme necessário:

   cp .env.example .env
   # edite .env para definir TZ, PORT e DATA_LOCATION

2. Iniciar:

   docker compose up -d

3. Acessar:

- Abra http://<host>:3001 no navegador para configurar o painel de monitoramento.
- Para produção, recomendo colocar atrás de um reverse-proxy (Nginx Proxy Manager). Remova a seção `ports` do serviço e aponte o proxy para uptime-kuma:3001.

Observações:
- Os dados são salvos em `./data` por padrão (configurável via DATA_LOCATION no `.env`).
- Na primeira execução, crie um usuário administrador diretamente pela interface web.
- Não comite o arquivo `.env`.

Comandos úteis

- Subir em background: `docker compose up -d`
- Ver logs: `docker compose logs -f uptime-kuma`
- Parar: `docker compose down`

Exemplo mínimo de `.env` (veja `.env.example` para valores):

TZ=America/Sao_Paulo
PORT=3001
DATA_LOCATION=./data

Segurança

- Defina uma senha forte ao criar o usuário administrador na primeira execução.
- Faça backups periódicos da pasta `data`.
