@startuml
actor App as "Application Code"

participant Spring
participant TikaAliasConfig as "TikaMimeTypeConfiguration"
participant AliasBean as "MimeTypeAlias Bean"
participant PoiConfig as "PlatformApachePoiConfiguration"
participant PoiReader as "PoiDataReader"
participant FactoryBean as "DataReaderFactory Bean"
participant Registry as "DataReaderRegistry"
participant Tika
participant MimeFactory as "MimeTypeFactory"

Spring -> TikaAliasConfig : create MimeTypeAliasSupplier beans
TikaAliasConfig --> Spring : XLSX alias: application/x-tika-ooxml
TikaAliasConfig --> Spring : XLS alias: application/x-tika-msoffice

Spring -> AliasBean : mimeTypeAlias(all suppliers)
AliasBean -> AliasBean : build dictionary\noriginal MIME -> aliases
AliasBean --> Spring : MimeTypeAlias

Spring -> PoiConfig : create platformApachePoiDataReader(...)
PoiConfig -> PoiReader : new PoiDataReader(rowMapperProvider, alias)
PoiReader -> AliasBean : get aliases for Excel MIME types
AliasBean --> PoiReader : application/x-tika-ooxml\napplication/x-tika-msoffice
PoiReader -> PoiReader : supported MIME list = originals + aliases
PoiReader --> Spring : DataReader bean

Spring -> PoiConfig : create platformApachePoiDataReaderSupplier(reader)
PoiConfig --> Spring : DataReaderSupplier

Spring -> FactoryBean : platformDataReaderFactory(all DataReaderSupplier beans)
FactoryBean -> Registry : new DataReaderRegistry(suppliers)
Registry -> PoiReader : supplier.getMimeTypes()
PoiReader --> Registry : Excel original MIMEs + Tika alias MIMEs
Registry -> Registry : build Map<MimeType, DataReaderSupplier>
Registry --> Spring : DataReaderFactory bean

App -> Tika : tika.detect(inputStream, metadata)
Tika --> App : "application/x-tika-ooxml"

App -> MimeFactory : create("application/x-tika-ooxml")
MimeFactory --> App : MimeType(application/x-tika-ooxml)

App -> Registry : requireReader(StreamMetadata(mimeType))
Registry -> Registry : lookup supplier by MimeType
Registry -> PoiConfig : supplier.get()
PoiConfig --> Registry : PoiDataReader
Registry --> App : PoiDataReader

App -> PoiReader : doWithBatchingStream(inputStream, hints, consumer)
PoiReader -> PoiReader : open workbook with StreamingReader
PoiReader -> PoiReader : select sheet
PoiReader -> PoiReader : map rows by RowMapper
PoiReader --> App : Stream<List<T>>

@enduml