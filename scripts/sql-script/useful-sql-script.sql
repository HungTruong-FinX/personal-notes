SELECT unnest(enum_range(NULL::event_type));


<!-- changeset hung.truong:27.04.2026:grant-view-table-permissions -->
<changeSet id="29.05.2026:grant-view-table-permissions" author="hung.truong">
    <sql>
        GRANT SELECT ON ALL TABLES IN SCHEMA public TO db_cluster_viewer;
        GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO db_cluster_viewer;
    </sql>
</changeSet>

DROP DATABASE payment_batches WITH (FORCE);