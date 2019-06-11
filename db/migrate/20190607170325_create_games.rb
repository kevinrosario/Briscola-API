# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[5.2]
  attr_accessor :deck
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.string :deck
      t.json :briscola
      t.string :player_one_hand
      t.string :player_two_hand
      t.string :player_one_earned
      t.string :player_two_earned
      t.string :current_cards
      t.boolean :over, null: false, default: false

      t.timestamps
    end
  end
end
