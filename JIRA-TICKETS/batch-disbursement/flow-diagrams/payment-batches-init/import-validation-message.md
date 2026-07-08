```mermaid
sequenceDiagram
    autonumber
    title Unsupported File Type Validation Flow

    actor Client
    participant Service as PaymentBatchService
    participant FileService as FileService
    participant Dispatcher as FileValidationDispatcher
    participant Validator as LendingDisbursementFileValidator
    participant Result as FileValidationResult
    participant Message as TransactionValidationMessage
    participant MessageSource as MessageSource
    participant BatchService as TransactionBatchService

    Client->>Service: init(batch)

    Service->>FileService: getMetadata(documentUri)
    FileService-->>Service: FileMetadata(mimeType = text/csv)

    Service->>Service: initBatchInfo(batch)
    Service->>Dispatcher: validateHeader(savedBatch, fileMetadata)

    Dispatcher->>Validator: validateHeader(batch, metadata)
    Validator->>Validator: validateMimeType(metadata)

    alt MIME type is not Excel
        Validator->>Validator: getMimeTypeName(text/csv)
        Validator->>Result: "invalid(<br/>IMPORT_VALIDATION_FAILED,<br/>UNSUPPORTED_FILETYPE,<br/>'Unsupported file reader: text/csv',<br/>'text/csv'<br/>)"
        Result-->>Validator: FileValidationResult
        Validator-->>Dispatcher: FileValidationResult
        Dispatcher-->>Service: FileValidationResult
    end

    Service->>Service: failedStatus = IMPORT_VALIDATION_FAILED
    Service->>Service: validationMessage = UNSUPPORTED_FILETYPE
    Service->>Service: batch.setStatus(IMPORT_VALIDATION_FAILED)
    Service->>Service: batch.setErrorCode("1")

    Service->>Message: "toLocalizedString(messageSource,<br/>transactionType,<br/>result.messageArgs())"

    Message->>Message: getMessageKey(transactionType)
    Message->>MessageSource: "getMessage(<br/>'LENDING_DISBURSEMENT_TRANSACTION_VALIDATION_1',<br/>['text/csv'],<br/>VI<br/>)"
    MessageSource-->>Message: "Định dạng file text/csv không hỗ trợ."

    Message->>MessageSource: "getMessage(<br/>'LENDING_DISBURSEMENT_TRANSACTION_VALIDATION_1',<br/>['text/csv'],<br/>EN<br/>)"
    MessageSource-->>Message: "The file format text/csv is not supported."

    Message-->>Service: LocalizedString

    Service->>Service: batch.setErrorDescription(localizedString)
    Service->>BatchService: save(batch)
    BatchService-->>Service: saved batch

    Service-->>Client: "throw IllegalArgumentException(<br/>'Unsupported file reader: text/csv'<br/>)"