# frozen_string_literal: true

require 'deck'
require 'computer_player'

class Game < ApplicationRecord
  belongs_to :user
  before_create :default_values
  before_update :play

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

  def play
    computer = ComputerPlayer.new(player_two_hand, briscola)
    if current_cards.length == 1 # user already played a card
      user_selection = first_current_card
      computer_selection = computer.after_user
      delete_from_hand(player_two_hand, computer_selection)
    else # computer played first
      computer_selection = first_current_card
      user_selection = second_current_card
    end
    current_cards.clear
    draw
    compare(user_selection, computer_selection, computer)
  end

  def compare(player_card, computer_card, computer)
    if (player_card <=> computer_card) == 1 # player wins
      add_to_earned(player_one_earned, player_card, computer_card)
    else # computer wins
      add_to_earned(player_two_earned, player_card, computer_card)
      computer_selection = computer.before_user
      current_cards << computer_selection
      delete_from_hand(player_two_hand, computer_selection)
    end
  end

  def draw
    if deck.length > 1
      player_one_hand.push(deck.shift)
      player_two_hand.push(deck.shift)
    elsif deck.length == 1
      player_one_hand.push(deck.shift)
      player_two_hand.push(briscola)
    end
  end

  def first_current_card
    Card.new(current_cards[0]['suit'],
             current_cards[0]['rank'],
             current_cards[0]['point_value'])
  end

  def second_current_card
    Card.new(current_cards[1]['suit'],
             current_cards[1]['rank'],
             current_cards[1]['point_value'])
  end

  def delete_from_hand(hand, card)
    hand.delete('suit' => card.suit, 'rank' => card.rank,
                'point_value' => card.point_value)
  end

  def add_to_earned(earned, user_card, computer_card)
    earned.push(user_card, computer_card)
  end
end
