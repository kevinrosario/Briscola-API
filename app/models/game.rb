# frozen_string_literal: true

require 'deck'

class Game < ApplicationRecord
  belongs_to :user
  before_save :default_values

  def default_values
    deck = Deck.new
    deck.shuffle!
    self.briscola = deck.draw.to_json
    self.player_one_hand = deck.deal.to_json
    self.player_two_hand = deck.deal.to_json
    self.deck = deck.deck.to_json
  end
end
