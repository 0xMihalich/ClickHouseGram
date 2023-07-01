-- TABLE.telegram definition
CREATE TABLE TABLE.telegram
(
    `token`    String COMMENT 'Токен бота',
    `bot_type` String COMMENT 'Назначение бота'
)
ENGINE = MergeTree
PRIMARY KEY token
ORDER BY token
SETTINGS index_granularity = 8192;
