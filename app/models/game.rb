# frozen_string_literal: true

require 'deck'

class Game < ApplicationRecord
  belongs_to :user
  before_create :default_values
  serialize :briscola, JSON
  serialize :player_one_hand, JSON
  serialize :player_two_hand, JSON
  serialize :player_one_earned, JSON
  serialize :player_two_earned, JSON
  serialize :current_cards, JSON
  serialize :deck, JSON

  def default_values
    deck = Deck.new
    deck.shuffle!
    self.briscola = deck.draw
    self.player_one_hand = deck.deal
    self.player_two_hand = deck.deal
    self.player_one_earned = []
    self.player_two_earned = []
    self.current_cards = []
    self.deck = deck.deck
  end
end
