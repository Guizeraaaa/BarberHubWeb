# Publicação em www.barberhub.truesprint.com.br

Endereço desejado: **https://www.barberhub.truesprint.com.br/**.

Esse endereço é um subdomínio de `truesprint.com.br`. A landing page pode ser hospedada no GitHub Pages; o administrador de `truesprint.com.br` precisa criar o apontamento DNS abaixo. O registro DNS, sozinho, não publica o site.

## 1. Preparar a hospedagem no GitHub

1. Incorpore o pull request que adiciona `.github/workflows/deploy-pages.yml` à branch `main`.
2. No [BarberHubWeb → Settings → Pages](https://github.com/Guizeraaaa/BarberHubWeb/settings/pages), em **Build and deployment → Source**, escolha **GitHub Actions**.
3. Em **Custom domain**, informe `www.barberhub.truesprint.com.br` e clique em **Save**. Configure o endereço no GitHub antes de criar o CNAME no DNS.
4. Em **Actions → Publicar GitHub Pages → Run workflow**, escolha a branch `main`. Se a primeira execução falhou porque o Pages ainda estava desabilitado, execute novamente após a configuração.
5. Confirme que o job **deploy** concluiu com sucesso antes de solicitar o apontamento DNS.

O workflow valida o código, executa os testes, gera o Flutter Web e publica o conteúdo completo de `build/web`. Os próximos pushes em `main` atualizam o site. Pull requests e outras branches não publicam.

O `base-href` vem da configuração do Pages: `/` para o domínio personalizado ou `/BarberHubWeb/` para o endereço padrão do projeto. Se mudar o domínio nas configurações do Pages, execute novamente o workflow para reconstruir com o caminho correto.

## 2. Registro para o administrador do domínio

Adicione este registro na zona DNS de **truesprint.com.br**:

| Campo | Valor |
| --- | --- |
| Tipo | `CNAME` |
| Nome completo | `www.barberhub.truesprint.com.br` |
| Nome, se o painel acrescentar `.truesprint.com.br` automaticamente | `www.barberhub` |
| Destino | `guizeraaaa.github.io` |
| TTL | Padrão do provedor |

O destino é apenas o hostname `guizeraaaa.github.io`, sem `https://` e sem `/BarberHubWeb`. Não é um redirecionamento de URL. O nome completo e o nome relativo na tabela são duas formas de preencher **o mesmo registro**, conforme o painel utilizado.

Na consulta de 06/10/2026, os servidores DNS do domínio eram `ns114.hostgator.com.br` e `ns115.hostgator.com.br`, e o hostname solicitado ainda não tinha registro público. Isso indica que a configuração deve ser feita no painel DNS da HostGator, salvo mudança posterior dos servidores.

Na HostGator, o administrador pode usar **cPanel → Editor de Zona DNS → Gerenciar truesprint.com.br → Adicionar registro → CNAME**, ou a zona avançada no Portal do Cliente. Cadastre apenas o hostname solicitado. Se já houver um registro com esse nome, confirme o destino com o administrador antes de substituí-lo. A propagação pode levar até 24 horas.

## 3. Concluir o HTTPS

Após o DNS resolver para o GitHub Pages, aguarde a emissão do certificado e habilite **Enforce HTTPS** em **Settings → Pages**. Essa opção pode levar até 24 horas para ficar disponível.

Conferência do apontamento:

```bash
dig www.barberhub.truesprint.com.br CNAME +short
```

Resultado esperado: `guizeraaaa.github.io.`. Depois, acesse `https://www.barberhub.truesprint.com.br/` e confira a página, os assets e a demonstração.

O GitHub também oferece verificação de propriedade por TXT em **configurações da conta → Pages**. Se utilizá-la, encaminhe ao administrador o nome e o valor gerados pelo próprio GitHub para este domínio.

Como a publicação usa GitHub Actions, um arquivo `CNAME` no repositório não configura o domínio: o endereço deve ser salvo nas configurações do Pages.

## Referências

- [Domínio personalizado e CNAME no GitHub Pages](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site).
- [Workflows personalizados do GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages).
- [Criar ou alterar registros DNS na HostGator](https://suporte.hostgator.com.br/hc/pt-br/articles/30813120385427-Como-criar-ou-alterar-um-registro-A-MX-TXT-CNAME-e-outros-na-Zona-DNS).
