# Grafana — Docker Compose

[Grafana](https://grafana.com/) é uma plataforma open-source de observabilidade e visualização de dados. Permite criar dashboards interativos a partir de diversas fontes de dados (Prometheus, InfluxDB, MySQL, etc.).

## Como usar

1. Copie o arquivo de exemplo de variáveis de ambiente:

```bash
cp .env.example .env
```

2. Edite o `.env` e defina uma senha segura para `GF_SECURITY_ADMIN_PASSWORD`.

3. Suba o serviço:

```bash
docker compose up -d
```

4. Acesse o painel em `http://<seu-host>:3100` e faça login com as credenciais configuradas.

## Variáveis de Ambiente

| Variável                      | Padrão                    | Descrição                                      |
|-------------------------------|---------------------------|------------------------------------------------|
| `TZ`                          | `America/Sao_Paulo`       | Fuso horário do container                      |
| `PORT`                        | `3100`                    | Porta exposta no host                          |
| `GF_SECURITY_ADMIN_USER`      | `admin`                   | Nome do usuário administrador                  |
| `GF_SECURITY_ADMIN_PASSWORD`  | *(obrigatório)*           | Senha do administrador (nunca use o padrão)    |
| `GF_SERVER_ROOT_URL`          | `http://localhost:3100`   | URL pública do Grafana (proxy reverso)         |

## Comandos Úteis

```bash
# Subir em background
docker compose up -d

# Ver logs em tempo real
docker compose logs -f grafana

# Parar e remover containers
docker compose down
```

## Segurança

- **Nunca** comite o arquivo `.env` com a senha real.
- Troque `GF_SECURITY_ADMIN_PASSWORD` por uma senha forte antes de iniciar.
- Em produção, exponha o Grafana via HTTPS usando o [Nginx Proxy Manager](../nginx-proxy-manager/README.md) apontando para `grafana:3000`, e remova a seção `ports` do `docker-compose.yml`.

## Links

- Documentação oficial: <https://grafana.com/docs/>
- Imagem Docker: <https://hub.docker.com/r/grafana/grafana>
