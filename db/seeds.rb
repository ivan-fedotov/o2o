# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
tst = true
# Set admin account
#a = Account.create(name: 'Admin', is_root: true, email: 'root@this_site.com')
a = Account.create(name: 'Admin', is_root: true, email: 'ivan.fedotov@rt.ru')
p = a.password.set_password('123123')
a.password.update_attribute(:active, true)

# Set ticket types
TicketType.create(title: 'Аварийная')
TicketType.create(title: 'Плановая')

# Set default statuses
Status.create(position: 1, title: 'Новая', is_first: true)
Status.create(position: 2, title: 'В работе')
Status.create(position: 3, title: 'На внутр. проверке')
Status.create(position: 4, title: 'На проверке')
Status.create(position: 5, title: 'Работы завершены')
Status.create(position: 6, title: 'Расчет')
Status.create(position: 7, title: 'Проверка расчета')
Status.create(position: 8, title: 'Закрыта', is_hidden: true)
Status.create(position: 9, title: 'Отменена', is_hidden: true)

# Set default roles
Role.create(title: 'Заказчик')
Role.create(title: 'Диспетчер')
Role.create(title: 'Исполнитель')
Role.create(title: 'Координатор')
Role.create(title: 'Сметчик')
Role.create(title: 'Контроллер')
Role.create(title: 'Тех.поддержка')

if tst
  #
  c1 = Account.create(name: 'Иванов И.И.', email: 'user1@t2.ru', is_client: true)
  c1.password.set_password('1234')
  c1.password.update_attribute(:active, true)
  c2 = Account.create(name: 'Петров И.И.', email: 'user2@t2.ru', is_client: true)
  c2.password.set_password('1234')
  c2.password.update_attribute(:active, true)

  # Brigades
  b1 = Brigade.create(title: 'Бригада 1')
  b2 = Brigade.create(title: 'Бригада 2')

  # Objects
  Site.create(network_name: 'EK0001', adress_info: 'Адрес', distance: 100, brigade_id: b1.id)
  Site.create(network_name: 'EK0002', adress_info: 'Адрес 2', distance: 120, brigade_id: b2.id)
end
