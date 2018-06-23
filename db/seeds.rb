mark = User.create(daily_calories: 2200, username: "Mark", email: "mark@fmail.com", password_digest: BCrypt::Password.create('markymark'))
Meal.create(name: "Cheeseburger", calories: 1000, user: mark)
Meal.create(name: "Scrambled Eggs", calories: 400, user: mark)
Meal.create(name: "Sandwich", calories: 1250, user: mark)
