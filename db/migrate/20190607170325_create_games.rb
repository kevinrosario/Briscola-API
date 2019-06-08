# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.2]
  attr_accessor :deck
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.json :deck
      t.json :briscola
      t.json :player_one_hand
      t.json :player_two_hand
      t.string :player_one_earned, array: true, default: []
      t.string :player_two_earned, array: true, default: []
      t.string :current_cards, array: true, default: []
      t.boolean :over, null: false, default: false

      t.timestamps
    end
  end
end
