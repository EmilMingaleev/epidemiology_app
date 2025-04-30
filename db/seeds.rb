Report.delete_all
Department.delete_all
User.delete_all
AdminUser.delete_all
# Создаем администратора
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

# Создаем отделы
departments = [
  { name: "Реанимационное отделение", description: "" },
  { name: "Стационарное отделение", description: "" },
  { name: "Приемное отделение", description: "" },
  { name: "Диагностическое отделение", description: "" }
]

departments.each do |department|
  Department.create!(department)
end

# Создаем пользователей
users = [
  { email: "test1@mail.ru", password: "password", last_name: "Фаридовна", first_name: "Эльвира",
    middle_name: "Насипова", position: "Эпидемиолог", description: "Насипова Эльвира Фаридовна — эпидемиолог, со стажем 25 лет. Принимает в клиниках: Эпидемиологический отдел МКДЦ и Межрегиональный клинико-диагностический центр. ", avatar: "user_1.png" },
  { email: "test2@mail.ru", password: "password", last_name: "Ершова", first_name: "Ксения", middle_name: "Сергеевна",
    position: "Эпидемиолог", description: "Ершова Ксения Сергеевна — эпидемиолог, со стажем 10 лет. Принимает в клиниках: Эпидемиологический отдел МКДЦ и Межрегиональный клинико-диагностический центр. Образование\r\n2015\r\nКазанский государственный медицинский университет", avatar: "user_2.png" },
  { email: "test3@mail.ru", password: "password", last_name: "Олеговна", first_name: "Александра",
    middle_name: "Бушуйкина", position: "Главный врач", description: "Бушуйкина Александра Олеговна — эпидемиолог, со стажем 10 лет. Принимает в клиниках: Эпидемиологический отдел МКДЦ и Межрегиональный клинико-диагностический центр.\r\n\r\nОбразование\r\n2015\r\nКазанский государственный медицинский университет", avatar: "user_3.png" },
  { email: "test4@mail.ru", password: "password", last_name: "Ивановна", first_name: "Валентина",
    middle_name: "Шарафутдинова", position: "Заведующая эпидемиологическим отделом ГУ МКДЦ.", description: "Биография\r\n\r\nРодилась 12 мая 1959г в г. Саранске. \r\n1985г –окончила Казанский государственный медицинский институт им. С.В. Курашова по специальности «Санитария, гигиена и эпидемиология». \r\nС 01.08.1985г. по 14.06.1994 г. врач-эпидемиолог Вахитовского центра санэпиднадзора.\r\nС 14.06.1994 г по  11.11.1999 г – заведующая эпидемиологическим отделом РККВД.\r\nС 11.11.1999г. - заведующая эпидемиологическим отделом ГУ МКДЦ.\r\n\r\n \r\n", avatar: "user_4.png" }
]

users.each do |attrs|
  user = User.find_or_create_by!(email: attrs[:email]) do |u|
    u.password = attrs[:password]
    u.last_name = attrs[:last_name]
    u.first_name = attrs[:first_name]
    u.middle_name = attrs[:middle_name]
    u.position = attrs[:position]
    u.description = attrs[:description]
  end

  avatar_path = Rails.root.join("db/seeds/images", attrs[:avatar])
  next unless File.exist?(avatar_path)

  user.avatar.attach(
    io: File.open(avatar_path),
    filename: attrs[:avatar],
    content_type: "image/png"
  )
end

pdf_path = Rails.root.join("db/seeds/files/epid.pdf")
user = User.first

if File.exist?(pdf_path) && user.present?
  Department.find_each do |department|
    report = Report.new(department: department, user: user)
    report.pdf.attach(
      io: File.open(pdf_path),
      filename: "epid.pdf",
      content_type: "application/pdf"
    )
    report.save!
  end
end
