-- TABLE.telegram_clear_messages source
CREATE VIEW TABLE.telegram_clear_messages
(
    `time`       DateTime COMMENT 'Время последней очистки',
    `clear_data` Bool     COMMENT 'Статус операции'
) AS
SELECT
    now() AS time,
    JSON_VALUE(*, '$.ok') AS clear_data
FROM url((
          SELECT concat('https://api.telegram.org/bot',
                        token,
                        '/getupdates?offset=',
                        toString(update_id))
          FROM (
                SELECT max(update_id) + 1 AS update_id
                FROM TABLE.telegram_messages
               ) AS tm, TABLE.telegram AS t
               WHERE t.bot_type = 'bot_for_tests'
         ), 'JSONAsString');
