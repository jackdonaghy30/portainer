# speedtest-tracker (Docker)

Instalação rápida do `speedtest-tracker` usando Docker Compose.

1. Entre na pasta do serviço:

```powershell
cd portainer/speedtest-tracker
```

2. (Opcional) Crie um arquivo `.env` na mesma pasta para definir variáveis como `TZ` ou `DOMAIN`.

3. Inicie o serviço:

```powershell
docker compose up -d
```

4. Acessar a interface em `http://<HOST>:3000` (ou o host configurado no seu proxy reverso).

Notas:
- Os dados são persistidos em `./data` no diretório do serviço (SQLite por padrão).
- Se você usar um proxy reverso como `nginx-proxy-manager`, remova o mapeamento de portas
  do `docker-compose.yml` e crie um Proxy Host apontando para `speedtest-tracker:3000`.
