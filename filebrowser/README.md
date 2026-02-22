# File Browser - Docker Compose

Interface web para gerenciamento de arquivos. Permite fazer upload, download, visualizar, renomear e editar arquivos dentro de um diretório configurado.

## Como usar

1. Copie o arquivo de variáveis de ambiente:

   ```bash
   cp .env.example .env
   ```

2. Crie os diretórios necessários e o arquivo de configurações iniciais:

   ```bash
   mkdir -p config data
   echo '{}' > config/settings.json
   touch config/filebrowser.db
   ```

3. Suba o serviço:

   ```bash
   docker compose up -d
   ```

4. Acesse no navegador: `http://<host>:8083`

5. Faça login com as credenciais padrão:
   - **Usuário:** `admin`
   - **Senha:** `admin`

   > ⚠️ Altere a senha imediatamente após o primeiro acesso.

## Variáveis de ambiente

| Variável     | Padrão  | Descrição                                               |
|--------------|---------|---------------------------------------------------------|
| `FILES_ROOT` | `./data` | Diretório local montado como raiz no File Browser       |
| `PUID`       | `1000`  | UID do usuário do host para permissões de arquivo       |
| `PGID`       | `1000`  | GID do grupo do host para permissões de arquivo         |
| `PORT`       | `8083`  | Porta do host para acessar a interface web              |

## Comandos úteis

- Subir em background: `docker compose up -d`
- Ver logs: `docker compose logs -f filebrowser`
- Parar: `docker compose down`

## Segurança

- Altere a senha padrão do usuário `admin` imediatamente após o primeiro acesso.
- Em produção, coloque o serviço atrás de um proxy reverso com HTTPS (ex: Nginx Proxy Manager). Remova a seção `ports` do `docker-compose.yml` e aponte o proxy para `filebrowser:80`.
- Restrinja o acesso ao diretório `FILES_ROOT` apenas ao necessário.

## Links

- Repositório oficial: https://github.com/filebrowser/filebrowser
- Documentação: https://filebrowser.org
