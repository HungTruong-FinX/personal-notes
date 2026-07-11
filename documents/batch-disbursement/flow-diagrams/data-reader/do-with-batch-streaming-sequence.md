```mermaid
sequenceDiagram
    autonumber
    title Excel Data Reader Batch Streaming Flow

    actor App as Application Code
    participant DataReader as DataReader interface
    participant PoiReader as PoiDataReader
    participant Hints as ReaderHints
    participant RowMapperProvider as RowMapperProviderProvider
    participant MapperProvider as RowMapperProvider(s)
    participant RowMapper as RowMapper
    participant StreamingReader as StreamingReader
    participant Workbook as Workbook
    participant Sheet as Sheet
    participant Headers as Headers
    participant HeaderControl as HeaderControl
    participant Spliterator as SheetSpliterator
    participant JavaStream as Stream<List<Row>>
    participant BeanStream as Stream<List<T>>
    participant Consumer as Consumer<Stream<List<T>>>
    participant SanityTester as SanityTester

    %% ==========================================
    %% Optional default method
    %% ==========================================
    rect rgb(240, 240, 240)
        Note over App, DataReader: Optional default method
    end

    App->>DataReader: doWithBatchingStream(inputStream, hints, consumer)
    DataReader->>PoiReader: doWithBatchingStream(inputStream, hints, consumer,<br/>interruptedThread sanity tester)

    %% ==========================================
    %% Resolve reading options
    %% ==========================================
    rect rgb(240, 240, 240)
        Note over PoiReader, Hints: Resolve reading options
    end

    PoiReader->>Hints: getOrDefault("batchSize", 100)
    Hints-->>PoiReader: batchSize, e.g. 100

    PoiReader->>RowMapperProvider: getRowMapper(hints)

    loop each configured RowMapperProvider
        RowMapperProvider->>MapperProvider: getRowMapper(hints)

        alt hints contains "beanClass"
            MapperProvider->>Hints: get("beanClass")
            Hints-->>MapperProvider: e.g. AccountImportRow.class
            MapperProvider-->>RowMapperProvider: Optional<RowMapper<AccountImportRow>>
        else hints contains "mapperName"
            MapperProvider->>Hints: getOrDefault("mapperName", "")
            Hints-->>MapperProvider: e.g. "accountImportRowMapper"
            MapperProvider-->>RowMapperProvider: Optional<RowMapper>
        else no match
            MapperProvider-->>RowMapperProvider: Optional.empty()
        end

        alt mapper found
            RowMapperProvider-->>PoiReader: RowMapper<T>
        end
    end

    alt no RowMapper found
        PoiReader->>App: throw IllegalArgumentException
    end

    PoiReader->>PoiReader: create ReadContext

    %% ==========================================
    %% Open workbook
    %% ==========================================
    rect rgb(240, 240, 240)
        Note over PoiReader, StreamingReader: Open workbook
    end

    PoiReader->>Hints: getOrDefault("streamBufferSize", 4096)
    Hints-->>PoiReader: buffer size

    PoiReader->>StreamingReader: builder()
    PoiReader->>StreamingReader: bufferSize(bufferSize)
    PoiReader->>StreamingReader: rowCacheSize(batchSize)
    PoiReader->>StreamingReader: open(inputStream)
    StreamingReader-->>PoiReader: Workbook

    PoiReader->>Hints: getOrDefault("sheetIndex", 0)
    Hints-->>PoiReader: sheetIndex

    PoiReader->>Workbook: getNumberOfSheets()
    Workbook-->>PoiReader: count

    PoiReader->>PoiReader: fit sheetIndex into range 0..count-1
    PoiReader->>Workbook: getSheetAt(sheetIndex)
    Workbook-->>PoiReader: Sheet

    %% ==========================================
    %% Create spliterator
    %% ==========================================
    rect rgb(240, 240, 240)
        Note over PoiReader, Spliterator: Create spliterator
    end

    PoiReader->>Headers: resolveHeaderControl(hints)
    Headers->>Hints: get("headerControl")

    alt headerControl missing
        Hints-->>Headers: empty
        Headers-->>PoiReader: HeaderControl.PRESENTED
    else headerControl = "SKIP"
        Hints-->>Headers: "SKIP"
        Headers-->>PoiReader: HeaderControl.SKIP
    end

    PoiReader->>HeaderControl: getIteratorAction()
    HeaderControl-->>PoiReader: opening iterator action

    PoiReader->>Spliterator: new SheetSpliterator(sheet, batchSize,<br/>iteratorAction, sanityTester)

    Spliterator->>Sheet: iterator()
    Sheet-->>Spliterator: Iterator<Row>

    alt HeaderControl.PRESENTED
        Spliterator->>Spliterator: do not advance iterator
    else HeaderControl.SKIP
        Spliterator->>Spliterator: advance iterator once<br/>(skip first row)
    end

    %% ==========================================
    %% Build lazy streams
    %% ==========================================
    rect rgb(240, 240, 240)
        Note over PoiReader, Consumer: Build lazy streams
    end

    PoiReader->>JavaStream: StreamSupport.stream(spliterator, false)
    JavaStream-->>PoiReader: Stream<List<Row>>

    PoiReader->>BeanStream: rowStream.map(rowMapper::mapToBeanBatch)
    BeanStream-->>PoiReader: Stream<List<T>>

    PoiReader->>Consumer: accept(beanBatchStream)

    %% ==========================================
    %% Lazy consumption inside consumer
    %% ==========================================
    rect rgb(240, 240, 240)
        Note over Consumer, Spliterator: Lazy consumption inside consumer
    end

    Consumer->>BeanStream: terminal operation<br/>forEach / collect / etc.

    loop while stream requests next batch
        BeanStream->>JavaStream: request next List<Row>
        JavaStream->>Spliterator: tryAdvance(action)

        Spliterator->>Spliterator: iterator.hasNext()
        Spliterator->>SanityTester: apply(iterator)

        alt no next row or sanity fails
            Spliterator-->>JavaStream: false
            JavaStream-->>BeanStream: stream ends
        else can read
            Spliterator->>Spliterator: create batch list

            loop until batch size reached or no rows
                Spliterator->>SanityTester: apply(iterator)
                Spliterator->>Spliterator: iterator.next()
                Spliterator->>Spliterator: add Row to batch
            end

            Spliterator->>JavaStream: action.accept(List<Row>)
            Spliterator-->>JavaStream: true

            JavaStream->>RowMapper: mapToBeanBatch(List<Row>)
            RowMapper->>RowMapper: map each Row -> T
            RowMapper-->>BeanStream: List<T>

            BeanStream-->>Consumer: List<T>
        end
    end

    %% ==========================================
    %% Cleanup
    %% ==========================================
    rect rgb(240, 240, 240)
        Note over Consumer, App: Cleanup
    end

    Consumer-->>PoiReader: returns
    PoiReader->>Workbook: close()

    alt IOException while closing/reading
        PoiReader->>App: throw UncheckedIOException
    else success
        PoiReader-->>App: void
    end