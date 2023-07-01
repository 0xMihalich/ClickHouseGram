# ClickHouseGram
## Получение текстовых сообщений из Telegram средствами Clickhouse
<img src="https://github.com/0xMihalich/ClickHouseGram/blob/main/telegram_messages.jpg" width="1024">
Предлагаемое решение состоит из таблицы TABLE.telegram, содержащей колонки token (уникальный токен бота, полученый от [@BotFather](https://t.me/BotFather))
и bot_type(назначение бота, например, bot_for_tests),
представления TABLE.telegram_messages, получающее все новые сообщения от текущего бота и
представления TABLE.telegram_clear_messages, очищающее обработанные сообщения.

```SQL
/*
Примеры запросов
*/

-- Получение новых сообщений
SELECT * FROM TABLE.telegram_messages

-- Очистка сообщений
SELECT * FROM TABLE.telegram_clear_messages
```
