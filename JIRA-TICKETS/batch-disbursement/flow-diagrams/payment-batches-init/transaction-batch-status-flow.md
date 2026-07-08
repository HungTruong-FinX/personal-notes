```mermaid
sequenceDiagram
    autonumber
    title Transaction Batch Status Flow

    actor Client
    participant BatchService as PaymentBatchService
    participant BatchStore as TransactionBatchService
    participant FileValidation as FileValidationDispatcher
    participant Importer as PaymentBatchRecordImporter
    participant ContentValidator as LendingDisbursementFileValidator
    participant DraftFinalizer as TransactionDraftFinalizer
    participant EventManager as PaymentBatchEventManager
    participant TxValidator as TransactionValidator
    participant TxStore as TransactionService

    Client->>BatchService: init(batch)
    activate BatchService
    
    BatchService->>BatchService: validateRequiredFields(batch)
    BatchService->>BatchStore: save(batch)
    note right of BatchStore: Batch status:<br/>IMPORT_IN_PROCESS
    
    BatchService->>FileValidation: validateHeader(batch, metadata)
    
    alt Header validation failed
        FileValidation-->>BatchService: invalid result
        BatchService->>BatchStore: save(batch)
        note right of BatchStore: Batch status:<br/>IMPORT_VALIDATION_FAILED
        BatchService-->>Client: throw validation error
        
    else Header validation passed
        FileValidation-->>BatchService: valid result
        BatchService-->>Client: saved batch
        
        BatchService->>BatchService: run async import and validation
        activate BatchService
        
        BatchService->>Importer: importBatch(batch, mimeType)
        activate Importer
        
        loop For each imported file chunk
            Importer->>TxStore: saveDraftTransactions(drafts)
            note right of Importer: Draft status:<br/>NEW<br/>Existing metadata:<br/>importCompleted += chunk quantity/amount<br/>Must run outside active DB transaction
        end
        
        alt Import failed by exception
            Importer->>BatchStore: save(batch)
            note right of BatchStore: Batch status:<br/>IMPORT_FAILED
            Importer-->>BatchService: rethrow exception
            
        else Import completed
            Importer->>BatchStore: save(batch)
            note right of BatchStore: Batch status remains:<br/>IMPORT_IN_PROCESS
            Importer-->>BatchService: imported batch
        end
        deactivate Importer
        
        BatchService->>BatchStore: save(batch)
        note right of BatchStore: Batch status:<br/>VALIDATION_STARTED
        
        BatchService->>FileValidation: validateContent(importedBatch)
        FileValidation->>ContentValidator: validateContent(batch)
        activate ContentValidator
        
        loop For each draft validation chunk
            ContentValidator->>ContentValidator: validate draft records
            ContentValidator->>TxStore: updateDraftTransactions(drafts)
            note right of ContentValidator: Draft status per record:<br/>NEW when import validation passes<br/>VALIDATION_FAILED when import validation fails<br/>Required metadata:<br/>importValidationCompleted += valid draft quantity/amount<br/>Must run outside active DB transaction
        end
        
        ContentValidator-->>FileValidation: passed / failed
        deactivate ContentValidator
        
        deactivate BatchService
    end
    deactivate BatchService