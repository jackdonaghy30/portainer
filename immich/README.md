# Immich (compose)

Deploy básico do Immich usando Docker Compose — estilo consistente com os outros serviços desta workspace.

- Pasta: `immich/`
- Arquivos: `docker-compose.yml`, `.env.example`

Instruções rápidas:

1. Copie `.env.example` para `.env` e ajuste as variáveis (DB_PASSWORD, UPLOAD_LOCATION, etc.).
2. Crie a network externa `shared` se ainda não existir: `docker network create shared`.
3. Suba os containers:

```bash
docker compose up -d
```

Obs: ajuste `IMMICH_VERSION` no `.env` se quiser fixar uma versão específica.

Machine Learning (opcional):

- Se quiser recursos de reconhecimento facial/detecção, adicione o serviço `immich-machine-learning` (já incluído no `docker-compose.yml`).
- Crie a pasta de modelos no host: `./ml-models` ou ajuste `ML_MODEL_PATH` no `.env`.
- Para GPU, configure o runtime/drivers no host (ex.: `nvidia` runtime) e ajuste o serviço conforme necessário.
