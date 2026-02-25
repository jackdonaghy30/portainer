# World Monitor

World Monitor é um dashboard de inteligência global em tempo real com IA, agregando notícias, dados geopolíticos, monitoramento militar e de infraestrutura em uma interface unificada de consciência situacional.

Funciona em três variantes a partir do mesmo código-fonte:

| Variante    | Foco                                                      |
|-------------|-----------------------------------------------------------|
| **full**    | Geopolítica, conflitos, bases militares, infraestrutura   |
| **tech**    | Startups, IA/ML, nuvem, cibersegurança                    |
| **finance** | Mercados globais, bancos centrais, Gulf FDI               |

> **Nota:** Este compose constrói a imagem localmente a partir do código-fonte oficial em [github.com/koala73/worldmonitor](https://github.com/koala73/worldmonitor). As funcionalidades que dependem de APIs de backend (Vercel Edge Functions) — como IA, rastreamento de navios e aeronaves militares — não estão disponíveis nesta configuração self-hosted. Os recursos principais (notícias, mercados, terremotos, clima, mapa) funcionam sem nenhuma configuração adicional.

## Como usar

1. Copie o arquivo de variáveis de ambiente:

```bash
cp .env.example .env
```

2. (Opcional) Edite o `.env` para escolher a variante e a porta desejada.

3. Construa a imagem e suba o serviço:

```bash
docker compose up -d --build
```

> O build faz o clone do repositório e compila o frontend — pode levar alguns minutos na primeira vez.

4. Acesse o dashboard em `http://<seu-host>:8083`.

## Variáveis de ambiente

| Variável                    | Padrão          | Descrição                                                                 |
|-----------------------------|-----------------|---------------------------------------------------------------------------|
| `WORLDMONITOR_PORT`         | `8083`          | Porta de acesso à interface web                                           |
| `VITE_VARIANT`              | `full`          | Variante do dashboard: `full`, `tech` ou `finance`                        |
| `VITE_MAP_INTERACTION_MODE` | `3d`            | Modo do mapa: `3d` (pitch/rotação) ou `flat` (2D)                         |
| `VITE_SENTRY_DSN`           | *(vazio)*       | DSN do Sentry para relatório de erros (opcional)                          |
| `VITE_POSTHOG_KEY`          | *(vazio)*       | Chave PostHog para analytics (opcional)                                   |
| `VITE_POSTHOG_HOST`         | *(vazio)*       | Host PostHog (opcional)                                                   |

> **Importante:** As variáveis `VITE_*` são embutidas no código durante o build. Para aplicar mudanças nessas variáveis, é necessário reconstruir a imagem com `docker compose build --no-cache`.

## Comandos úteis

```bash
# Construir e subir em background
docker compose up -d --build

# Reconstruir após alterar variáveis VITE_*
docker compose build --no-cache && docker compose up -d

# Ver logs em tempo real
docker compose logs -f worldmonitor

# Parar o serviço
docker compose down
```

## Notas de segurança

- Não comite o arquivo `.env` com valores reais.
- Em produção, recomenda-se colocar o serviço atrás do Nginx Proxy Manager com HTTPS.
- As variáveis `VITE_POSTHOG_KEY` e `VITE_SENTRY_DSN` são opcionais e não devem conter dados sensíveis críticos, mas evite expô-las publicamente.

## Links

- [Repositório oficial](https://github.com/koala73/worldmonitor)
- [Documentação completa](https://github.com/koala73/worldmonitor/blob/main/docs/DOCUMENTATION.md)
- [Demo ao vivo](https://worldmonitor.app)
