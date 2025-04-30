#!/bin/bash
set -e

# Удаляем PID-файл Puma, если он остался после перезапуска
rm -f tmp/pids/server.pid



# Прогоняем сиды, только если база пуста (например, нет пользователей)
if bin/rails runner "exit User.any? ? 0 : 1"; then
  echo "Skipping seeds (already seeded)"
else
  echo "Seeding database..."
  bin/rails db:seed
fi

# Запускаем сервер
exec "$@"
