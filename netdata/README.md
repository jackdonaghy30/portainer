# Netdata

Netdata é uma ferramenta de monitoramento de performance em tempo real para sistemas, containers e aplicações. Oferece métricas detalhadas de CPU, memória, disco, rede, Docker e muito mais através de uma interface web interativa.

## Como usar

1. Copie o arquivo de variáveis de ambiente:

```bash
cp .env.example .env
```

2. (Opcional) Edite o `.env` para ajustar porta e configurar integração com o Netdata Cloud.

3. Suba o serviço:

```bash
docker compose up -d
```

4. Acesse o painel em `http://<seu-host>:19999`.

## Variáveis de ambiente

| Variável                | Padrão                        | Descrição                                                  |
|-------------------------|-------------------------------|------------------------------------------------------------|
| `TZ`                    | `America/Sao_Paulo`           | Timezone do servidor                                       |
| `NETDATA_PORT`          | `19999`                       | Porta de acesso à interface web                            |
| `NETDATA_CLAIM_TOKEN`   | *(vazio)*                     | Token para vincular ao Netdata Cloud (opcional)            |
| `NETDATA_CLAIM_URL`     | `https://app.netdata.cloud`   | URL do Netdata Cloud (opcional)                            |
| `NETDATA_CLAIM_ROOMS`   | *(vazio)*                     | ID da sala no Netdata Cloud (opcional)                     |

## Comandos úteis

```bash
# Subir em background
docker compose up -d

# Ver logs em tempo real
docker compose logs -f netdata

# Parar o serviço
docker compose down
```

## Notas de segurança

- O Netdata expõe métricas detalhadas do host. Em produção, recomenda-se colocá-lo atrás do Nginx Proxy Manager com autenticação ou restringir o acesso por IP.
- As variáveis `NETDATA_CLAIM_TOKEN` e `NETDATA_CLAIM_ROOMS` são opcionais e usadas apenas para integração com o Netdata Cloud. Nunca compartilhe seu token publicamente.
- Não comite o arquivo `.env` com valores reais.

## Links

- [Documentação oficial](https://learn.netdata.cloud)
- [Imagem Docker](https://hub.docker.com/r/netdata/netdata)
- [Netdata Cloud](https://app.netdata.cloud)
