# ClickHouseGram
## Получение текстовых сообщений из Telegram средствами Clickhouse

Предлагаемое решение состоит из таблицы TABLE.telegram, содержащей колонки token (уникальный токен бота, полученый от BotFather) и bot_type(назначение бота, например, test),
представления TABLE.telegram_messages, получающее все новые сообщения от текущего бота и представления TABLE.telegram_clear_messages, очищающее обработанные сообщения.
```SQL
/*
Примеры запросов
*/

-- Получение новых сообщений
SELECT * FROM TABLE.telegram_messages

-- Очистка сообщений
SELECT * FROM TABLE.telegram_clear_messages
```
