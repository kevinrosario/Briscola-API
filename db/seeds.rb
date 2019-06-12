# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'a@a', password: 'a', password_confirmation: 'a')
User.create(email: 'b@b', password: 'b', password_confirmation: 'b')
Game.create(user_id: 1)
Game.create(user_id: 2)
Game.create(user_id: 1)
Game.create(user_id: 2)
