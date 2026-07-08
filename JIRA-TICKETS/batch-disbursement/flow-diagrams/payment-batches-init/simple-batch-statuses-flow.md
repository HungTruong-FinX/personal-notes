```mermaid
graph TD
    %% Define Styles
    classDef startEnd fill:#f9f,stroke:#333,stroke-width:2px;
    classDef process fill:#bbf,stroke:#333,stroke-width:1px;
    classDef error fill:#fbb,stroke:#333,stroke-width:1px;

    Start([Start: Batch created]) --> ImportInProcess[IMPORT_IN_PROCESS]
    
    %% First Decision
    ImportInProcess --> Cond1{Header validation<br/>passed?}
    Cond1 -- No --> ImportValFailed[IMPORT_VALIDATION_FAILED] --> Stop1([Stop])
    Cond1 -- Yes --> Cond2{Import file records<br/>successfully?}
    
    %% Second Decision
    Cond2 -- No --> ImportFailed[IMPORT_FAILED] --> Stop2([Stop])
    Cond2 -- Yes --> ContImport[Continue import validation] --> ValStarted1[VALIDATION_STARTED]
    
    %% Third Decision
    ValStarted1 --> Cond3{All imported records<br/>pass import validation?}
    Cond3 -- No --> ImportValFailed2[IMPORT_VALIDATION_FAILED] --> Stop3([Stop])
    Cond3 -- Yes --> ImportCompleted[IMPORT_COMPLETED]
    
    %% Fourth Decision
    ImportCompleted --> CreateRealTx[Create real transactions<br/>from valid records] --> ValStarted2[VALIDATION_STARTED]
    ValStarted2 --> Cond4{Any business<br/>validation failed?}
    
    Cond4 -- Yes --> ValFailed[VALIDATION_FAILED] --> Stop4([Stop])
    Cond4 -- No --> ValCompleted[VALIDATION_COMPLETED] --> Stop5([Stop])

    %% Apply Classes
    class Start,Stop1,Stop2,Stop3,Stop4,Stop5 startEnd;
    class ImportValFailed,ImportFailed,ImportValFailed2,ValFailed error;