/**
  @author Vladimir Bratchikov
 */
create schema nvpsv_integration;

------------------------------------------------------------------------------------------------------------------------
/**
  1. Создание таблицы с партициями для храниения общей информации о процессах
 */
create table nvpsv_integration.integration_process
(
    id               text not null,
    creation_date    date,
    request_id       text not null,
    message_id       text,
    document_type    text,
    creation_time    timestamp without time zone,
    last_update_time timestamp without time zone,
    status           text not null,
    type             text not null,
    entity           text,
    szv_request      text,
    receipt          text,
    documents_data   text
) PARTITION BY RANGE (creation_date);

-- Создание индексов
CREATE INDEX IF NOT EXISTS idx_type ON nvpsv_integration.integration_process USING hash (type);

CREATE INDEX IF NOT EXISTS idx_status ON nvpsv_integration.integration_process USING hash (status);

CREATE INDEX IF NOT EXISTS idx_creation_date ON nvpsv_integration.integration_process ((creation_date::DATE));

-- Создание партиций на 2020 год
CREATE TABLE integration_process_y2020m01 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');

CREATE TABLE integration_process_y2020m02 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');

CREATE TABLE integration_process_y2020m03 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');

CREATE TABLE integration_process_y2020m04 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');

CREATE TABLE integration_process_y2020m05 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');

CREATE TABLE integration_process_y2020m06 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');

CREATE TABLE integration_process_y2020m07 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');

CREATE TABLE integration_process_y2020m08 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');

CREATE TABLE integration_process_y2020m09 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');

CREATE TABLE integration_process_y2020m10 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');

CREATE TABLE integration_process_y2020m11 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');

CREATE TABLE integration_process_y2020m12 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');

------------------------------------------------------------------------------------------------------------------------

/**
  2. Создание таблицы с партициями для храниения общей информации данных для колбеков
 */
create table nvpsv_integration.step_callback
(
    id                text not null,
    creation_date     date,
    request_id        text not null,
    message_id        text,
    creation_time     timestamp without time zone,
    last_update_time  timestamp without time zone,
    response_callback text not null,
    error_callback    text not null,
    status            text not null,
    step              text -- references nvpsv_integration.integration_process (id)
) PARTITION BY RANGE (creation_date);

-- Создание индексов
CREATE INDEX IF NOT EXISTS idx_creation_date ON nvpsv_integration.step_callback ((creation_date::DATE));


-- Создание партиций на 2020 год
CREATE TABLE step_callback_y2020m01 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');

CREATE TABLE step_callback_y2020m02 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');

CREATE TABLE step_callback_y2020m03 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');

CREATE TABLE step_callback_y2020m04 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');

CREATE TABLE step_callback_y2020m05 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');

CREATE TABLE step_callback_y2020m06 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');

CREATE TABLE step_callback_y2020m07 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');

CREATE TABLE step_callback_y2020m08 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');

CREATE TABLE step_callback_y2020m09 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');

CREATE TABLE step_callback_y2020m10 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');

CREATE TABLE step_callback_y2020m11 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');

CREATE TABLE step_callback_y2020m12 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');

------------------------------------------------------------------------------------------------------------------------

/**
  3. Создание таблицы с партициями для храниения сырых xml (потребуется много памяти....)
 */
create table nvpsv_integration.integration_process_data
(
    id               text not null,
    creation_date    date,
    request_id       text not null,
    message_id       text,
    creation_time    timestamp without time zone,
    last_update_time timestamp without time zone,
    name             text,
    data             text -- references nvpsv_integration.integration_process (id)
) PARTITION BY RANGE (creation_date);

-- Создание индексов
CREATE INDEX IF NOT EXISTS idx_creation_date ON nvpsv_integration.integration_process_data ((creation_date::DATE));

-- Создание партиций на 2020 год
CREATE TABLE integration_process_data_y2020m01 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');

CREATE TABLE integration_process_data_y2020m02 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');

CREATE TABLE integration_process_data_y2020m03 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');

CREATE TABLE integration_process_data_y2020m04 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');

CREATE TABLE integration_process_data_y2020m05 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');

CREATE TABLE integration_process_data_y2020m06 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');

CREATE TABLE integration_process_data_y2020m07 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');

CREATE TABLE integration_process_data_y2020m08 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');

CREATE TABLE integration_process_data_y2020m09 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');

CREATE TABLE integration_process_data_y2020m10 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');

CREATE TABLE integration_process_data_y2020m11 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');

CREATE TABLE integration_process_data_y2020m12 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');
------------------------------------------------------------------------------------------------------------------------
CREATE VIEW nvpsv_integration.integration_process_list_view AS
SELECT  id                   AS id,
        request_id           AS request_id,
        message_id           AS message_id,
        document_type        AS document_type,
        creation_time        AS creation_time,
        last_update_time     AS last_update_time,
        status               AS status,
        type                 AS type
FROM nvpsv_integration.integration_process;
CREATE VIEW nvpsv_integration.integration_process_data_content_view AS
SELECT  id                   AS id,
        request_id           AS request_id,
        name                 AS name,
        data                 AS data
FROM nvpsv_integration.integration_process_data;

CREATE VIEW nvpsv_integration.integration_process_data_list_view AS
SELECT  id                   AS id,
        request_id           AS request_id,
        message_id           AS message_id,
        creation_time        AS creation_time,
        last_update_time     AS last_update_time,
        name                 AS name
FROM nvpsv_integration.integration_process_data ORDER BY last_update_time DESC;
ALTER TABLE nvpsv_integration.integration_process
    ADD COLUMN pm_name character varying(255);
ALTER TABLE nvpsv_integration.integration_process
    ADD COLUMN queue_request character varying(255);
ALTER TABLE nvpsv_integration.integration_process
    ADD COLUMN queue_response character varying(255);

DROP VIEW nvpsv_integration.integration_process_list_view;

CREATE VIEW nvpsv_integration.integration_process_list_view AS
SELECT id               AS id,
       request_id       AS request_id,
       message_id       AS message_id,
       document_type    AS document_type,
       creation_time    AS creation_time,
       last_update_time AS last_update_time,
       pm_name          AS pm_name,
       queue_request    AS queue_request,
       queue_response   AS queue_response,
       status           AS status,
       type             AS type
FROM nvpsv_integration.integration_process;
drop VIEW nvpsv_integration.integration_process_list_view;
drop VIEW nvpsv_integration.integration_process_data_list_view;

alter table nvpsv_integration.integration_process
    alter creation_time type timestamp with time zone using creation_time AT TIME ZONE 'UTC',
    alter creation_time set not null,
    alter last_update_time type timestamp with time zone using last_update_time AT TIME ZONE 'UTC';

alter table nvpsv_integration.integration_process_data
    alter creation_date set not null,
    alter creation_time type timestamp with time zone using creation_time AT TIME ZONE 'UTC',
    alter creation_time set not null,
    alter last_update_time type timestamp with time zone using last_update_time AT TIME ZONE 'UTC';

alter table nvpsv_integration.step_callback
    alter creation_date set not null,
    alter creation_time type timestamp with time zone using creation_time AT TIME ZONE 'UTC',
    alter creation_time set not null,
    alter last_update_time type timestamp with time zone using last_update_time AT TIME ZONE 'UTC';


CREATE VIEW nvpsv_integration.integration_process_list_view AS
SELECT id               AS id,
       request_id       AS request_id,
       message_id       AS message_id,
       document_type    AS document_type,
       creation_time    AS creation_time,
       last_update_time AS last_update_time,
       pm_name          AS pm_name,
       queue_request    AS queue_request,
       queue_response   AS queue_response,
       status           AS status,
       type             AS type
FROM nvpsv_integration.integration_process;

CREATE VIEW nvpsv_integration.integration_process_data_list_view AS
SELECT  id                   AS id,
        request_id           AS request_id,
        message_id           AS message_id,
        creation_time        AS creation_time,
        last_update_time     AS last_update_time,
        name                 AS name
FROM nvpsv_integration.integration_process_data ORDER BY last_update_time DESC;
/**
  1. Создание таблицы с партициями для храниения общей мета информации о процессах
 */
create table nvpsv_integration.global_process_meta_data
(
    id              text not null,
    creation_date   date,
    creation_time   timestamp without time zone,
    wsa_action_type text
) PARTITION BY RANGE (creation_date);


CREATE INDEX IF NOT EXISTS idx_creation_date ON nvpsv_integration.global_process_meta_data ((creation_date::DATE));

-- Создание партиций на 2020 год
CREATE TABLE global_process_meta_data_y2020m01 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');

CREATE TABLE global_process_meta_data_y2020m02 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');

CREATE TABLE global_process_meta_data_y2020m03 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');

CREATE TABLE global_process_meta_data_y2020m04 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');

CREATE TABLE global_process_meta_data_y2020m05 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');

CREATE TABLE global_process_meta_data_y2020m06 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');

CREATE TABLE global_process_meta_data_y2020m07 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');

CREATE TABLE global_process_meta_data_y2020m08 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');

CREATE TABLE global_process_meta_data_y2020m09 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');

CREATE TABLE global_process_meta_data_y2020m10 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');

CREATE TABLE global_process_meta_data_y2020m11 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');

CREATE TABLE global_process_meta_data_y2020m12 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');
-- Добавления признака подсистемы, для которой предназначен ИП.
-- INNER - это внутренний НВПиСВ, будет еще Модуль проверок СМЭВ и др, на будущее
alter table nvpsv_integration.global_process_meta_data
    add column owner text not null default 'INNER';
/**
  1. Создание таблицы с партициями для храниения общей информации о процессах
 */
create table nvpsv_integration.migration_request
(
    id             text not null,
    creation_date  date,
    creation_time  timestamp without time zone,
    processed_time timestamp without time zone,
    request_id     text not null,
    message_id     text,
    message_from   text,
    recipient      text
) PARTITION BY RANGE (creation_date);

-- Создание индексов
CREATE INDEX IF NOT EXISTS idx_migration_request_creation_date ON nvpsv_integration.migration_request ((creation_date::DATE));

-- Создание партиций на 2020 год
CREATE TABLE migration_request_y2020m01 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');

CREATE TABLE migration_request_y2020m02 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');

CREATE TABLE migration_request_y2020m03 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');

CREATE TABLE migration_request_y2020m04 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');

CREATE TABLE migration_request_y2020m05 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');

CREATE TABLE migration_request_y2020m06 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');

CREATE TABLE migration_request_y2020m07 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');

CREATE TABLE migration_request_y2020m08 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');

CREATE TABLE migration_request_y2020m09 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');

CREATE TABLE migration_request_y2020m10 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');

CREATE TABLE migration_request_y2020m11 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');

CREATE TABLE migration_request_y2020m12 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');

------------------------------------------------------------------------------------------------------------------------

/**
  1. Создание таблицы с партициями для храниения общей информации о процессах
 */
create table nvpsv_integration.migration_files_data
(
    id                 text not null,
    creation_date      date,
    request_id         text not null,
    creation_time      timestamp without time zone,
    migration_time     timestamp without time zone,
    status             text not null,
    content_type       text not null,
    file_name          text not null,
    refuse_code        text,
    refuse_stack_trace text,
    files              text

) PARTITION BY RANGE (creation_date);

-- Создание индексов
CREATE INDEX IF NOT EXISTS idx_migration_request_request_id ON nvpsv_integration.migration_files_data USING hash (request_id);

CREATE INDEX IF NOT EXISTS idx_migration_request_creation_date ON nvpsv_integration.migration_files_data ((creation_date::DATE));

-- Создание партиций на 2020 год
CREATE TABLE migration_files_data_y2020m01 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-01-01') TO ('2020-02-01');

CREATE TABLE migration_files_data_y2020m02 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-02-01') TO ('2020-03-01');

CREATE TABLE migration_files_data_y2020m03 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-03-01') TO ('2020-04-01');

CREATE TABLE migration_files_data_y2020m04 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-04-01') TO ('2020-05-01');

CREATE TABLE migration_files_data_y2020m05 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-05-01') TO ('2020-06-01');

CREATE TABLE migration_files_data_y2020m06 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-06-01') TO ('2020-07-01');

CREATE TABLE migration_files_data_y2020m07 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-07-01') TO ('2020-08-01');

CREATE TABLE migration_files_data_y2020m08 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-08-01') TO ('2020-09-01');

CREATE TABLE migration_files_data_y2020m09 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-09-01') TO ('2020-10-01');

CREATE TABLE migration_files_data_y2020m10 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-10-01') TO ('2020-11-01');

CREATE TABLE migration_files_data_y2020m11 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-11-01') TO ('2020-12-01');

CREATE TABLE migration_files_data_y2020m12 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2020-12-01') TO ('2021-01-01');

------------------------------------------------------------------------------------------------------------------------
-- Создание партиций на 2021 год (integration_process)
CREATE TABLE integration_process_y2021m01 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE integration_process_y2021m02 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE integration_process_y2021m03 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE integration_process_y2021m04 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE integration_process_y2021m05 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE integration_process_y2021m06 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE integration_process_y2021m07 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE integration_process_y2021m08 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE integration_process_y2021m09 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE integration_process_y2021m10 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE integration_process_y2021m11 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE integration_process_y2021m12 PARTITION OF nvpsv_integration.integration_process
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

-- Создание партиций на 2021 год (integration_process_data)
CREATE TABLE integration_process_data_y2021m01 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE integration_process_data_y2021m02 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE integration_process_data_y2021m03 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE integration_process_data_y2021m04 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE integration_process_data_y2021m05 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE integration_process_data_y2021m06 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE integration_process_data_y2021m07 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE integration_process_data_y2021m08 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE integration_process_data_y2021m09 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE integration_process_data_y2021m10 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE integration_process_data_y2021m11 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE integration_process_data_y2021m12 PARTITION OF nvpsv_integration.integration_process_data
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');
------------------------------------------------------------------------------------------------------------------------

-- Создание партиций на 2021 год (global_process_meta_data)
CREATE TABLE global_process_meta_data_y2021m01 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE global_process_meta_data_y2021m02 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE global_process_meta_data_y2021m03 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE global_process_meta_data_y2021m04 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE global_process_meta_data_y2021m05 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE global_process_meta_data_y2021m06 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE global_process_meta_data_y2021m07 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE global_process_meta_data_y2021m08 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE global_process_meta_data_y2021m09 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE global_process_meta_data_y2021m10 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE global_process_meta_data_y2021m11 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE global_process_meta_data_y2021m12 PARTITION OF nvpsv_integration.global_process_meta_data
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

------------------------------------------------------------------------------------------------------------------------

-- Создание партиций на 2021 год (migration_request)
CREATE TABLE migration_request_y2021m01 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE migration_request_y2021m02 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE migration_request_y2021m03 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE migration_request_y2021m04 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE migration_request_y2021m05 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE migration_request_y2021m06 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE migration_request_y2021m07 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE migration_request_y2021m08 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE migration_request_y2021m09 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE migration_request_y2021m10 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE migration_request_y2021m11 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE migration_request_y2021m12 PARTITION OF nvpsv_integration.migration_request
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

------------------------------------------------------------------------------------------------------------------------

-- Создание партиций на 2021 год (migration_files_data)
CREATE TABLE migration_files_data_y2021m01 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE migration_files_data_y2021m02 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE migration_files_data_y2021m03 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE migration_files_data_y2021m04 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE migration_files_data_y2021m05 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE migration_files_data_y2021m06 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE migration_files_data_y2021m07 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE migration_files_data_y2021m08 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE migration_files_data_y2021m09 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE migration_files_data_y2021m10 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE migration_files_data_y2021m11 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE migration_files_data_y2021m12 PARTITION OF nvpsv_integration.migration_files_data
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

------------------------------------------------------------------------------------------------------------------------
-- Создание партиций на 2021 год (step_callback)
CREATE TABLE step_callback_y2021m01 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE step_callback_y2021m02 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE step_callback_y2021m03 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE step_callback_y2021m04 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE step_callback_y2021m05 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE step_callback_y2021m06 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE step_callback_y2021m07 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE step_callback_y2021m08 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE step_callback_y2021m09 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE step_callback_y2021m10 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE step_callback_y2021m11 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE step_callback_y2021m12 PARTITION OF nvpsv_integration.step_callback
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------
/**
  1. Создание таблицы с партициями для храниения общей информации о процессах
 */
create table nvpsv_integration.migration_svpr_request
(
    id             text not null,
    creation_date  date,
    creation_time  timestamp without time zone,
    processed_time timestamp without time zone,
    request_id     text not null,
    message_id     text,
    message_from   text,
    recipient      text
) PARTITION BY RANGE (creation_date);

-- Создание индексов
CREATE INDEX IF NOT EXISTS idx_migration_svpr_request_creation_date ON nvpsv_integration.migration_svpr_request ((creation_date::DATE));

-- Создание партиций на 2021 год
CREATE TABLE migration_svpr_request_y2021m01 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE migration_svpr_request_y2021m02 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE migration_svpr_request_y2021m03 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE migration_svpr_request_y2021m04 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE migration_svpr_request_y2021m05 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE migration_svpr_request_y2021m06 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE migration_svpr_request_y2021m07 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE migration_svpr_request_y2021m08 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE migration_svpr_request_y2021m09 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE migration_svpr_request_y2021m10 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE migration_svpr_request_y2021m11 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE migration_svpr_request_y2021m12 PARTITION OF nvpsv_integration.migration_svpr_request
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

------------------------------------------------------------------------------------------------------------------------

/**
  1. Создание таблицы с партициями для храниения общей информации о процессах
 */
create table nvpsv_integration.migration_svpr_files_data
(
    id                 text not null,
    creation_date      date,
    request_id         text not null,
    creation_time      timestamp without time zone,
    migration_time     timestamp without time zone,
    status             text not null,
    content_type       text not null,
    file_name          text not null,
    refuse_code        text,
    refuse_stack_trace text,
    files              text

) PARTITION BY RANGE (creation_date);

-- Создание индексов
CREATE INDEX IF NOT EXISTS idx_migration_svpr_request_request_id ON nvpsv_integration.migration_svpr_files_data USING hash (request_id);

CREATE INDEX IF NOT EXISTS idx_migration_svpr_request_creation_date ON nvpsv_integration.migration_svpr_files_data ((creation_date::DATE));

-- Создание партиций на 2021 год
CREATE TABLE migration_svpr_files_data_y2021m01 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01');

CREATE TABLE migration_svpr_files_data_y2021m02 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

CREATE TABLE migration_svpr_files_data_y2021m03 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-03-01') TO ('2021-04-01');

CREATE TABLE migration_svpr_files_data_y2021m04 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-04-01') TO ('2021-05-01');

CREATE TABLE migration_svpr_files_data_y2021m05 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-05-01') TO ('2021-06-01');

CREATE TABLE migration_svpr_files_data_y2021m06 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-06-01') TO ('2021-07-01');

CREATE TABLE migration_svpr_files_data_y2021m07 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE migration_svpr_files_data_y2021m08 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE migration_svpr_files_data_y2021m09 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE migration_svpr_files_data_y2021m10 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE migration_svpr_files_data_y2021m11 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE migration_svpr_files_data_y2021m12 PARTITION OF nvpsv_integration.migration_svpr_files_data
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

------------------------------------------------------------------------------------------------------------------------
/**
  1. Создание таблицы с партициями для храниения информации о заявлениях
 */
create table nvpsv_integration.application_data
(
    id            bigint not null,
    creation_date date,
    creation_time timestamp without time zone,
    nsi_type      int,
    related_docs  text,
    attached_docs text
) PARTITION BY RANGE (creation_date);


CREATE INDEX IF NOT EXISTS idx_creation_date ON nvpsv_integration.application_data ((creation_date::DATE));

-- Создание партиций на 2021 год
CREATE TABLE application_data_y2021m07 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2021-07-01') TO ('2021-08-01');

CREATE TABLE application_data_y2021m08 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2021-08-01') TO ('2021-09-01');

CREATE TABLE application_data_y2021m09 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2021-09-01') TO ('2021-10-01');

CREATE TABLE application_data_y2021m10 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2021-10-01') TO ('2021-11-01');

CREATE TABLE application_data_y2021m11 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2021-11-01') TO ('2021-12-01');

CREATE TABLE application_data_y2021m12 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2021-12-01') TO ('2022-01-01');

CREATE TABLE application_data_y2022m01 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2022-01-01') TO ('2022-02-01');

CREATE TABLE application_data_y2022m02 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2022-02-01') TO ('2022-03-01');

CREATE TABLE application_data_y2022m03 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2022-03-01') TO ('2022-04-01');

CREATE TABLE application_data_y2022m04 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2022-04-01') TO ('2022-05-01');

CREATE TABLE application_data_y2022m05 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2022-05-01') TO ('2022-06-01');

CREATE TABLE application_data_y2022m06 PARTITION OF nvpsv_integration.application_data
    FOR VALUES FROM ('2022-06-01') TO ('2022-07-01');
