#user test
user = User.find_or_create_by!(email: "test@test.com") do |u|
  u.password = "password"
end

#routine test
routine = Routine.find_or_create_by!(name: "Full Body Strength", user: user)

#chat test
chat = Chat.find_or_create_by!(title: "Chat test", user: user)

# exo pour routine test
Exercice.find_or_create_by!(name: "Squat", routine: routine, chat: chat) do |e|
  e.description = "Fléchissez les genoux jusqu'à 90 degrés, dos droit."
  e.rep_amount = 12
  e.video_url = "https://www.youtube.com/embed/aclHkVaku9U"
end

Exercice.find_or_create_by!(name: "Pompes", routine: routine, chat: chat) do |e|
  e.description = "Corps gainé, descendre jusqu'au sol, pousser."
  e.rep_amount = 15
  e.video_url = "https://www.youtube.com/embed/IODxDxX7oi4"
end

Exercice.find_or_create_by!(name: "Fentes", routine: routine, chat: chat) do |e|
  e.description = "Un pas en avant, genou à 90 degrés."
  e.rep_amount = 10
  e.video_url = "https://www.youtube.com/embed/QOVaHwm-Q6U"
end
