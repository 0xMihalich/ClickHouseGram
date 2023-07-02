-- TABLE.telegram_messages source
CREATE VIEW TABLE.telegram_messages
(
    `text`               String                     COMMENT 'Текст сообщения',
    `date`               DateTime                   COMMENT 'Время сообщения по UTC',
    `id`                 FixedString(255)           COMMENT 'ID пользователя',
    `first_name`         FixedString(255)           COMMENT 'Имя пользователя',
    `last_name`          FixedString(255)           COMMENT 'Фамилия пользователя',
    `username`           FixedString(255)           COMMENT 'Юзернейм',
    `is_bot`             Bool                       COMMENT 'Отправитель Бот или человек',
    `chat_id`            FixedString(255)           COMMENT 'ID чата',
    `chat_type`          FixedString(255)           COMMENT 'Статус чата',
    `forward_date`       Nullable(DateTime)         COMMENT 'Время изначального сообщения UTC',
    `forward_id`         FixedString(255)           COMMENT 'ID изначального пользователя',
    `forward_first_name` FixedString(255)           COMMENT 'Имя изначального пользователя',
    `forward_last_name`  FixedString(255)           COMMENT 'Фамилия изначального пользователя',
    `forward_username`   FixedString(255)           COMMENT 'Юзернейм изначального пользователя',
    `forward_is_bot`     Nullable(Bool)             COMMENT 'Изначальный отправитель бот или человек',
    `message_id`         FixedString(255)           COMMENT 'ID сообщения в чате',
    `update_id`          Int32                      COMMENT 'ID для обработки сообщения'
) AS
SELECT
    JSON_VALUE(msg, '$.message.text')                                       AS text,
    JSON_VALUE(msg, '$.message.date')                                       AS date,
    JSON_VALUE(msg, '$.message.from.id')                                    AS id,
    JSON_VALUE(msg, '$.message.from.first_name')                            AS first_name,
    JSON_VALUE(msg, '$.message.from.last_name')                             AS last_name,
    JSON_VALUE(msg, '$.message.from.username')                              AS username,
    JSON_VALUE(msg, '$.message.from.is_bot')                                AS is_bot,
    JSON_VALUE(msg, '$.message.chat.id')                                    AS chat_id,
    JSON_VALUE(msg, '$.message.chat.type')                                  AS chat_type,
    JSON_VALUE(msg, '$.message.forward_date')                               AS forward_date,
    JSON_VALUE(msg, '$.message.forward_from.id')                            AS forward_id,
    multiIf(notEmpty(JSON_VALUE(msg, '$.message.forward_sender_name')),
            JSON_VALUE(msg, '$.message.forward_sender_name'),
            JSON_VALUE(msg, '$.message.forward_from.first_name'))           AS forward_first_name,
    JSON_VALUE(msg, '$.message.forward_from.last_name')                     AS forward_last_name,
    JSON_VALUE(msg, '$.message.forward_from.username')                      AS forward_username,
    multiIf(notEmpty(JSON_VALUE(msg, '$.message.forward_from.is_bot')),
            JSONExtractBool(msg, '$.message.forward_from.is_bot'),
            NULL)                                                           AS forward_is_bot,
    JSON_VALUE(msg, '$.message.message_id')                                 AS message_id,
    JSON_VALUE(msg, '$.update_id')                                          AS update_id
FROM
(
    SELECT arrayJoin(JSONExtractArrayRaw(*,
                     'result')) AS msg
    FROM url((
              SELECT concat('https://api.telegram.org/bot',
                            token,
                            '/getupdates')
                FROM TABLE.telegram AS t
               WHERE t.bot_type = 'bot_for_tests'
             ), 'JSONAsString')
);
