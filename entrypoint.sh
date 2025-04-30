#!/bin/bash
set -e

rm -f tmp/pids/server.pid

bin/rails db:prepare

if bin/rails runner "exit User.any? ? 0 : 1"; then
  echo "Skipping seeds (already seeded)"
else
  echo "Seeding database..."
  bin/rails db:seed
fi

exec "$@"
