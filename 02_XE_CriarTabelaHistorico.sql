CREATE TABLE dbo.Historico_CapturaDeQueries (
    [Dt_Evento] DATETIME,
    [session_id] INT,
    [database_name] VARCHAR(128),
    [username] VARCHAR(128),
    [session_server_principal_name] VARCHAR(128),
    [session_nt_username] VARCHAR(128),
    [client_hostname] VARCHAR(128),
    [client_app_name] VARCHAR(128),
    [duration] DECIMAL(18, 2),
    [cpu_time] DECIMAL(18, 2),
    [logical_reads] BIGINT,
    [physical_reads] BIGINT,
    [writes] BIGINT,
    [row_count] BIGINT,
    [sql_text] XML,
    [batch_text] XML,
    [result] VARCHAR(100)
) WITH(DATA_COMPRESSION=PAGE)
GO
 
CREATE CLUSTERED INDEX SK01_Historico_Query_Lenta ON dbo.Historico_CapturaDeQueries (Dt_Evento) WITH(DATA_COMPRESSION=PAGE)
GO
