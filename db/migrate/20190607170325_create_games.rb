# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.2]
  attr_accessor :deck
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.json :deck, array: true
      t.json :briscola
      t.json :player_one_hand, array: true
      t.json :player_two_hand, array: true
      t.json :player_one_earned, array: true
      t.json :player_two_earned, array: true
      t.json :current_cards, array: true
      t.boolean :over, null: false, default: false

      t.timestamps
    end
  end
end
