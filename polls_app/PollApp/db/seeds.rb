# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
chris = User.create(user_name: 'Chris')
brady = User.create(user_name: 'Brady')
elliot = User.create(user_name: 'Elliot')
larry = User.create(user_name: 'Larry')

Poll.destroy_all
p1 = Poll.create(title: 'Favorite color', author_id: chris.id)
p2 = Poll.create(title: 'Favorite fruit', author_id: brady.id)

Question.destroy_all
q11 = Question.create(text: 'What is your favorite color?', poll_id: p1.id)
q21 = Question.create(text: 'What is your favorite fruit?', poll_id: p2.id)
q12 = Question.create(text: 'What is your second favorite?', poll_id: p1.id)
q22 = Question.create(text: 'What is your second favorite?', poll_id: p2.id)

AnswerChoice.destroy_all
ac111 = AnswerChoice.create(text: 'Blurple', question_id: q11.id)
ac112 = AnswerChoice.create(text: 'Gred', question_id: q11.id)
ac121 = AnswerChoice.create(text: 'Blurple', question_id: q12.id)
ac122 = AnswerChoice.create(text: 'Gred', question_id: q12.id)
ac211 = AnswerChoice.create(text: 'Snozberry', question_id: q21.id)
ac212 = AnswerChoice.create(text: 'Grapple', question_id: q21.id)
ac221 = AnswerChoice.create(text: 'Snozberry', question_id: q22.id)
ac222 = AnswerChoice.create(text: 'Grapple', question_id: q22.id)

Response.destroy_all
r111 = Response.create(answer_id: ac112.id, user_id: chris.id)
r121 = Response.create(answer_id: ac121.id, user_id: chris.id)
r211 = Response.create(answer_id: ac212.id, user_id: chris.id)
r221 = Response.create(answer_id: ac221.id, user_id: chris.id)
r112 = Response.create(answer_id: ac111.id, user_id: brady.id)
r122 = Response.create(answer_id: ac122.id, user_id: brady.id)
r212 = Response.create(answer_id: ac211.id, user_id: brady.id)
r222 = Response.create(answer_id: ac222.id, user_id: brady.id)
re11 = Response.create(answer_id: ac111.id, user_id: elliot.id)
re12 = Response.create(answer_id: ac121.id, user_id: elliot.id)
re21 = Response.create(answer_id: ac211.id, user_id: elliot.id)
re22 = Response.create(answer_id: ac221.id, user_id: elliot.id)
larry11 = Response.create(answer_id: ac111.id, user_id: larry.id)
larry12 = Response.create(answer_id: ac121.id, user_id: larry.id)
larry21 = Response.create(answer_id: ac211.id, user_id: larry.id)
