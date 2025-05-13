require 'telegram/bot'

class TelegramNotifier
  TOKEN = "7610107799:AAHE0kIKjK8fyjX5zKXYHh2-ltiRZe-VgvM"
  CHAT_ID = "384335477"

  def self.send_message(text, **options)
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.api.send_message({
        chat_id: CHAT_ID,
        text: text
      }.merge(options))
    end
  rescue StandardError => e
    Rails.logger.error("TelegramNotifier error: #{e.message}")
  end
end
