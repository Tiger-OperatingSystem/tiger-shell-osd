# tiger-shell-osd
O `tiger-shell-osd` prove funções `bash` para a criação de diálogos unificados para o Tiger OS simplificando o desenvolvimento de extensões e mini-aplicativos pro sistema

# Diálogos padrão

### `input`

**Uso:** Para receber entradas de texto do usuário

**Sintaxe**: ```input "[Título]" "[Descrição]" ```

**Demonstração**:

```bash

nome=$(input "Digite seu nome:" "Essa é uma demonstração do diálogo input" )

```

### `password`, `directory-picker`, `file-picker` e `multi-file-picker`

Possuem a mesma sintaxe que `input` porém possuem usos diferentes:

| **Função**          | **Uso**                                       |
|---------------------|-----------------------------------------------|
| `password`          | Para receber um texto tipo senha              |
| `directory-picker`  | Para escolher uma pasta                       |
| `file-picker`       | Para escolher um arquivo                      |
| `multi-file-picker` | Para escolher multiplos arquivos de uma pasta |

### `show-message`

**Uso:** Para mostrar uma mensagem ao usuário

**Sintaxe**: ```show-message "[Título]" "[Descrição]" ```

**Demonstração**:

```bash

show-message "Esse é o título" "Essa é o corpo da mensagem" 

```

> Nota: Os diálogos `show-message` deve ser usado menos de 3x durante a execução, `show-warning` e `show-erro` deve ser exibido apenas ao final do script com apenas uma execução, `ask` deve ser usado com cautela


### `show-warning` e `show-error`

Possuem a mesma sintaxe e uso que `show-message` porém possuem consequências diferentes:

| **Função**     | **Uso**                         |
|----------------|---------------------------------|
| `show-warning` | Para emitir um aviso ao usuario |
| `show-error`   | Para emitir um erro ao usuario  |
| `ask`          | Para perguntar algo ao usuario  |

> **Notas:** 
> 
> ¹ ao usar `show-error` o script será encerrado quando o usuário clicar em <kbd>Fechar</kbd>
> 
> ² `ask` é usado para perguntas tipo _Sim e Não_

### `display-text`

**Uso:** Para mostrar o conteúdo de um arquivo de texto

**Sintaxe**: ```display-text "[Título]" "[Descrição]" "[Arquivo]" "[Layout dos botões]"```

**Demonstração**:

```bash

display-text "Esse é o título da caixa de diálogo" "Essa é a descrição do diálogo" "/proc/cpuinfo" close

```

> Nota: `"[Layout dos botões]"` é opcional, veja a seção `Tipos de botões de diálogo` para as opções disponíveis

### `pulsate-progress` e `progress`

**Uso:** Para mostrar que algo está sendo feito

**Sintaxes**: 
  * ```comando | pulsate-progress "[Descrição]" ```
  * ```comando | progress "[Descrição]" ```

**Demonstração**:

```bash

for i in $(seq 1 100); do echo ${i}; sleep 0.1; done | progress "Demonstração progress"

for i in $(seq 1 100); do echo aaaa; sleep 0.1; done | pulsate-progress "Demonstração pulsate-progress"

```

> **Notas:** 
> 
> ¹ `progress` fecha automaticamente ao chegar em 100%, `pulsate-progress` quando o comando terminar a execução
> 
> ² `progress` é atualizado por linhas que contém apenas números
>
> ³ `pulsate-progress` é atualizado sempre que recebe uma linha em _`stdout`_

# Tipos de botões de diálogo

Nessa versão o `tiger-shell-osd` existem os seguintes tipos de botão:

* `yes-no` exibe os botões <kbd>Sim</kbd> que retorna 1 e <kbd>Não</kbd> que retorna 0
* `no-yes` exibe os botões <kbd>Não</kbd> que retorna 1 e <kbd>Sim</kbd> que retorna 0
* `cancel-ok` exibe os botões <kbd>Cancelar</kbd> que retorna 1 e <kbd>Ok</kbd> que retorna 0
* `close` exibe o botão <kbd>Fechar</kbd>
* `ok` exibe o botão <kbd>Ok</kbd>
* `cancel` exibe o botão <kbd>Cancelar</kbd>
* `none` não exibe nenhum botão, note que isso isso implica na janela fechar ao perder o foco
