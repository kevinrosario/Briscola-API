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
    computer_player = ComputerPlayer.new(player_two_hand)
    # user played first first
    if current_cards.length == 1
      user_played_first(computer_player)
    else
      user_play_second(computer_player)
    end
  end

  def user_played_first(computer)
    user_selection = user_card
    computer_selection = computer.after_user
    current_cards.clear
    delete_from_hand(player_two_hand, computer_selection)
    draw
    if (user_selection <=> computer_selection) == 1
      add_to_earned(player_one_earned, user_selection, computer_selection)
    else
      add_to_earned(player_two_earned, user_selection, computer_selection)
      user_play_second(computer)
    end
  end

  def user_play_second(computer)
    computer_selection = computer.before_user
    current_cards.push(computer_selection)
    delete_from_hand(player_two_hand, computer_selection)
  end

  def draw
    player_one_hand.push(deck.shift)
    player_two_hand.push(deck.shift)
  end

  def user_card
    Card.new(current_cards[0]['suit'],
             current_cards[0]['rank'],
             current_cards[0]['point_value'])
  end

  def delete_from_hand(hand, card)
    hand.delete('suit' => card.suit, 'rank' => card.rank,
                'point_value' => card.point_value)
  end

  def add_to_earned(earned, user_card, computer_card)
    earned.push(user_card, computer_card)
  end
end
