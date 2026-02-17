# Glance (docker-compose)

Este diretório contém um `docker-compose.yml` mínimo para rodar o Glance usando a imagem oficial `glanceapp/glance`.

Passos rápidos:

1. Crie a pasta de configuração:

```bash
mkdir -p glance/config
```

2. Baixe o arquivo de configuração de exemplo:

```bash
curl -L -o glance/config/glance.yml https://raw.githubusercontent.com/glanceapp/glance/refs/heads/main/docs/glance.yml
```

3. (Opcional) Edite `glance/config/glance.yml` conforme suas preferências.

4. Suba o serviço:

```bash
cd glance
docker compose up -d
```

5. Acesse o painel em `http://<seu-host>:8080`.

Logs:

```bash
docker compose logs -f
```

Notas:
- A estrutura usa `./config` montada em `/app/config`, que é onde o Glance procura por `glance.yml` por padrão.
- Se preferir construir a imagem a partir do código fonte, siga as instruções do repositório oficial: https://github.com/glanceapp/glance
