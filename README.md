
dart run dart_code_linter:metrics analyze lib --reporter=json > clean_arch_metrics.json

# flutter_clean_arch_riverpod

## Arquitetura

Este projeto segue a **Clean Architecture** com influências do **DDD (Domain-Driven Design)**. A estrutura é composta pelas camadas clássicas do DDD, complementadas pelas camadas que o Uncle Bob define como fundamentais no Clean Architecture, e por duas camadas de suporte específicas deste projeto.

### Camadas do DDD

| Camada            | Responsabilidade                                  |
|-------------------|---------------------------------------------------|
| `domain/`         | Regras e contratos de negócio                     |
| `application/`    | Orquestração de regras, contendo os casos de uso  |
| `infrastructure/` | Serviços externos implementados via contratos     |

### Camadas do Clean Architecture

Camadas que o DDD tradicional não explicita, mas o Clean Architecture define como fundamentais:

| Camada       | Responsabilidade                              |
|--------------|-----------------------------------------------|
| `data/`      | Acesso e persistência de dados                |
| `presentation/` | Interface com o usuário e gerenciamento de estado |

### Camadas de Suporte

Camadas transversais específicas deste projeto:

| Camada       | Responsabilidade                               |
|--------------|------------------------------------------------|
| `bootstrap/` | Injeção de dependência (via Riverpod) e rotas  |
| `core/`      | Utilitários transversais                       |

---

## Estrutura de Pastas

```
/lib
├── application/                          # Camada de aplicação: orquestração entre domínio e dados
│   ├── favorites/                           ## Casos de uso de favoritos
│   ├── preferences/                         ## Casos de uso de preferências
│   └── quotes/                              ## Casos de uso de cotações
├── bootstrap/                            # Inicialização e configuração do app
│   ├── di/                                  ## Injeção de dependência (Riverpod)
│   └── routes/                              ## Configuração de rotas (AutoRoute)
├── core/                                 # Utilitários transversais compartilhados entre camadas
│   ├── constants/                           ## Constantes globais
│   ├── failures/                            ## Falhas de domínio, seguindo padrão Result
│   ├── l10n/                                ## Internacionalização
│   └── theme/                               ## Tema e cores da aplicação
├── data/                                 # Camada de dados: implementação de acesso e persistência
│   ├── data_objects/                        ## Objetos de transferência e mapeamento de dados
│   │   ├── *_dao.dart                           ### Mapeamento de persistência local
│   │   └── *_dto.dart                           ### Mapeamento de API REST
│   ├── datasources/                         ## Fontes de dados: API e persistência local
│   │   └── *_datasource.dart
│   └── repositories_impl/                   ## Implementações dos contratos declarados no domínio
│       └── *_repository_impl.dart
├── domain/                               # Camada de domínio: regras e contratos de negócio
│   ├── entities/                            ## Entidades de domínio
│   └── repositories/                        ## Contratos dos repositórios
│       └── *_repository_interface.dart
├── infrastructure/                       # Camada de infraestrutura: serviços externos via contratos
│   ├── api_client/                          ## Cliente HTTP
│   │   ├── dio/                                 ### Implementação com Dio
│   │   ├── models/                              ### Modelos internos (ApiRoute, HttpMethod)
│   │   ├── api_client_failure.dart              ### Falhas da camada HTTP
│   │   └── api_client_interface.dart            ### Contrato do cliente HTTP
│   └── storage/                             ## Persistência local
│       ├── shared_preferences/                  ### Implementação com SharedPreferences
│       ├── storage_failure.dart                 ### Falhas da camada de persistência
│       └── storage_interface.dart               ### Contrato de persistência
└── presentation/                         # Camada de apresentação: UI e gerenciamento de estado
    ├── screens/                             ## Telas
    ├── widgets/                             ## Widgets reutilizáveis
    └── providers/                           ## Gerenciamento de estado (Riverpod)
        ├── *_notifier.dart                      ### Notifiers: lógica de estado
        └── *_state.dart                         ### Estados possíveis da UI
```

## Fluxograma Simplificado

```mermaid
flowchart TB
    domain["**domain**"]

    domain --> application
    application --> presentation
    domain --> data
    data --> infrastructure

    application["**application**\nuse cases"]
    presentation["**presentation**"]
    data["**data**"]
    infrastructure["**infrastructure**"]
```

## Métricas

- 243 funções distribuídas em múltiplos arquivos pequenos
- Média de SLOC por função: 6.8 — funções curtas e focadas
- Complexidade ciclomática média: 1.6 — quase sem ramificações por função
- Maintainability Index médio: 83.5/100 — muito alto
- Nível de aninhamento máximo: 4 — estrutura rasa

| Métrica | Spaguetti | Clean Arch |
|---|---|---|
| Arquivos | 9 | 87 |
| Funções analisadas | 52 | 313 |
| SLOC médio por função | 12.2 | 5.5 |
| SLOC máximo | 105 | 102 |
| Complexidade ciclomática média | 2.1 | 1.5 |
| Complexidade ciclomática máxima | 16 | 19 |
| Maintainability Index médio | 77.6 | 87.0 |
| Maintainability Index mínimo | 34 | 32 |
| Funções com MI < 50 (warnings) | 6 (11%) | 12 (4%) |
| Nível de aninhamento médio | 0.8 | 0.4 |
| Nível de aninhamento máximo | 4 | 4 |
| Arquivos com `Dio` (API Client) | 2 (UI) | 1 (infra) |
| Arquivos com `SharedPreferences` (storage) | 3 (UI) | 1 (infra) |

## Análise Comparativa

### Concentração de Complexidade

- **Spaguetti**: complexidade concentrada na camada de UI — widgets com lógica de negócio, chamadas HTTP e persistência misturados
- **Clean Arch**: complexidade restrita à camada de infraestrutura, onde é inevitável e esperada

### Acoplamento de Dependências

- **Spaguetti**: `Dio` e `SharedPreferences` espalhados por arquivos de UI, criando alto acoplamento — qualquer troca de dependência exige modificar telas
- **Clean Arch**: `Dio` e `SharedPreferences` isolados na camada de infraestrutura, comunicando-se com o restante da aplicação através de contratos (`ApiClientInterface`, `StorageInterface`)

### Testabilidade

- **Spaguetti**: impossível testar lógica de negócio isoladamente — qualquer teste exige instanciar `Dio` e `SharedPreferences` reais
- **Clean Arch**: cada use case e repositório é testável com um único mock, sem dependências externas reais

### Escalabilidade

- **Spaguetti**: adicionar uma nova feature exige criar mais telas com mais dependências diretas, aumentando progressivamente o acoplamento
- **Clean Arch**: novas features são adicionadas criando arquivos novos sem modificar os existentes, respeitando o Princípio Aberto/Fechado

### Manutenibilidade

- **Spaguetti**: trocar uma dependência exige modificar arquivos de UI e compreender lógica misturada, com risco de regressão em funcionalidades não relacionadas
- **Clean Arch**: a troca é cirúrgica — substituir `Dio` por `http` ou `SharedPreferences` por `Hive` impacta apenas um arquivo de infraestrutura