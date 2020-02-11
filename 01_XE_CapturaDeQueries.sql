-- Dropa a sessão XE, caso exista. 
IF ((SELECT COUNT(*) FROM sys.dm_xe_sessions WHERE [name] = 'CapturaDeQueries') > 0 )
   DROP EVENT SESSION CapturaDeQueries ON SERVER

-- Criar XE Session
CREATE EVENT SESSION CapturaDeQueries ON SERVER
ADD EVENT sqlserver.sql_batch_completed (
    ACTION (
        sqlserver.session_id,
        sqlserver.client_app_name,
        sqlserver.client_hostname,
        sqlserver.database_name,
        sqlserver.username,
        sqlserver.session_nt_username,
        sqlserver.session_server_principal_name,
        sqlserver.sql_text
    )
    WHERE
        duration > (2000000) --2 segundos
),
ADD EVENT sqlserver.sp_statement_completed (
    ACTION (
        sqlserver.session_id,
        sqlserver.client_app_name,
        sqlserver.client_hostname,
        sqlserver.username,
        sqlserver.database_id,
        sqlserver.session_nt_username,
        sqlserver.sql_text
    )
    WHERE
        duration > (2000000)
),
ADD EVENT sqlserver.sql_statement_completed (
    ACTION (
        sqlserver.session_id,
        sqlserver.client_app_name,
        sqlserver.client_hostname,
        sqlserver.username,
        sqlserver.database_id,
        sqlserver.session_nt_username,
        sqlserver.sql_text
    )
    WHERE
        duration > (2000000)
)
ADD TARGET package0.asynchronous_file_target (
    SET filename=N'C:\Traces\CapturaDeQueries.xel',
    max_file_size=(100),
    max_rollover_files=(1)
)
 
-- Ativa o Extended Event
ALTER EVENT SESSION CapturaDeQueries ON SERVER STATE = START
GO
