# code-server (VS Code no Navegador)

**code-server** é o VS Code rodando diretamente no navegador, hospedado no seu próprio servidor Docker. Acesse seu ambiente de desenvolvimento de qualquer lugar sem instalar nada localmente.

## Recursos

- VS Code completo no navegador
- Suporte a extensões do VS Code Marketplace
- Terminal integrado no container
- Acesso protegido por senha
- Integra com Nginx Proxy Manager para HTTPS

## Como usar

### 1. Preparar o `.env`

```bash
cp .env.example .env
# Edite .env e defina senhas seguras
```

### 2. Subir o container

```bash
docker compose up -d
```

### 3. Acessar

Abra o navegador em:

```
http://<seu-ip>:8444
```

Digite a senha definida em `PASSWORD` no `.env`.

Para abrir automaticamente o workspace configurado, use:

```
http://<seu-ip>:8444/?folder=/vscode/projects
```

## Variáveis de Ambiente

| Variável            | Padrão                 | Descrição                                      |
|---------------------|------------------------|------------------------------------------------|
| `PUID`              | `1000`                 | User ID do host (use `id` para verificar)      |
| `PGID`              | `1000`                 | Group ID do host                               |
| `TZ`                | `America/Sao_Paulo`    | Fuso horário                                   |
| `PASSWORD`          | *(obrigatório)*        | Senha de acesso ao code-server                 |
| `SUDO_PASSWORD`     | *(opcional)*           | Senha sudo dentro do container                 |
| `PORT`              | `8444`                 | Porta exposta no host                          |
| `CONFIG_LOCATION`   | `./config`             | Diretório de configuração no host              |
| `HOST_WORKSPACE`    | `./vscode/projects`    | Diretório workspace no host (criado automaticamente) |

## Comandos Úteis

```bash
# Subir em background
docker compose up -d

# Ver logs
docker compose logs -f code-server

# Parar
docker compose down

# Reiniciar
docker compose restart code-server
```

## Segurança

- Defina uma senha forte em `PASSWORD`.
- Use o **Nginx Proxy Manager** para expor o code-server com HTTPS e domínio próprio.
- Não exponha a porta diretamente na internet sem HTTPS.
- Remova `SUDO_PASSWORD` se não precisar de acesso sudo no container.

## Usando com Nginx Proxy Manager

1. Remova (ou comente) a seção `ports` do `docker-compose.yml`.
2. Adicione o serviço à rede `shared`:

```yaml
networks:
  - shared

networks:
  shared:
    external: true
```

3. No Nginx Proxy Manager, crie um **Proxy Host** apontando para `code-server:8443`.

## Personalização

### Script de Inicialização Customizado

O container executa automaticamente scripts localizados em `config/custom-cont-init.d/` durante a inicialização. O script `set-workspace.sh` já está configurado para definir o workspace padrão.

Você pode adicionar seus próprios scripts nesta pasta para customizar o ambiente.

### Workspace

O workspace padrão está mapeado para o diretório definido em `HOST_WORKSPACE` (padrão: `./vscode/projects`). Esta pasta é criada automaticamente pelo Docker e está acessível em `/vscode/projects` dentro do container.

## Recursos e Documentação

- **Imagem Docker**: [linuxserver/code-server](https://docs.linuxserver.io/images/docker-code-server/)
- **GitHub**: https://github.com/coder/code-server
- **Documentação oficial**: https://coder.com/docs/code-server
