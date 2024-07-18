Дано('я гость') do
  context.set_user Testing::Guest.new
end

Дано('я участник') do
  context.set_user User.create(username: 'TestUser')
end

Когда(/^я открываю (.+)$/) do |path|
  visit path
end

Когда(/^нажимаю на(?: кнопку)? "(.*?)"$/) do |item|
  click_on item
end

Когда(/^создан мой versus$/) do
  context.set_versus Competition.create(name: 'Test',
                                        description: 'TestDescription',
                                        author_id: context.current_user.id)
end

Тогда(/^вижу текст "([^"]*)"$/) do |text|
  expect(page).to have_content text
end

Тогда(/^заполняю поле "([^"]*)" со значением "([^"]*)"$/) do |item, text|
  fill_in item, with: text
end

Тогда(/^открывается страница редатирования моего versus$/) do
  visit "/competitions/#{context.current_versus.id}/edit"
end