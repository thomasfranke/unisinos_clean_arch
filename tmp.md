```
flowchart TB
    subgraph OUTER["Camadas Externas"]
        P["🖥️ Presentation\nWidgets · Pages · ViewModels"]
        I["⚙️ Infra\nHTTP · DB · Storage · Device"]
    end

    subgraph MIDDLE["Camadas de Adaptação"]
        A["📋 Application\nUseCases · BLoC/Cubit · DTOs"]
        D["🗄️ Data / Datasources\nRepositoryImpl · Models · Mappers"]
    end

    subgraph CORE["Núcleo — Domain"]
        DO["🏛️ Domain\nEntities · Repository Interfaces\nValue Objects · Business Rules"]
    end

    P -->|"chama"| A
    A -->|"depende de"| DO
    D -->|"implementa interfaces de"| DO
    I -->|"é usado por"| D

    style CORE fill:#1a3a5c,stroke:#4a9eff,color:#fff
    style MIDDLE fill:#1a2a3a,stroke:#666,color:#ccc
    style OUTER fill:#111,stroke:#444,color:#ccc
    style DO fill:#0d47a1,stroke:#4a9eff,color:#fff
    ```