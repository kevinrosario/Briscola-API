# frozen_string_literal: true

require 'deck'
require 'computer_player'

class Game < ApplicationRecord
  belongs_to :user
  before_create :default_values
  before_update :play
  serialize :briscola, JSON
  serialize :player_one_hand, JSON
  serialize :player_two_hand, JSON
  serialize :player_one_earned, JSON
  serialize :player_two_earned, JSON
  serialize :current_cards, JSON
  serialize :player_two_last_selection, JSON
  serialize :deck, JSON

  def default_values
    deck = Deck.new
    deck.shuffle!
    self.briscola = deck.draw
    self.player_one_hand = deck.deal
    self.player_two_hand = deck.deal
    self.player_one_earned = []
    self.player_two_earned = []
    self.player_two_last_selection = []
    self.current_cards = []
    self.deck = deck.deck
  end

  def play
    computer = ComputerPlayer.new(player_two_hand, briscola)
    player_two_last_selection.clear
    if current_cards.length == 1 # user already played a card
      user_selection = first_current_card
      computer_selection = computer.after_user
      player_two_last_selection << computer_selection
      delete_from_hand(player_two_hand, computer_selection)
      compare_user_second(user_selection, computer_selection, computer)
    else # computer played first
      computer_selection = first_current_card
      user_selection = second_current_card
      compare_user_first(user_selection, computer_selection, computer)
    end
    draw
    self.over = true if player_one_hand.empty?
  end

  def compare_user_first(user_selection, computer_selection, computer)
    if (user_selection <=> computer_selection) == 1 &&
        # computer_selection.suit != briscola['suit'] # player wins
      add_to_earned(player_one_earned, user_selection, computer_selection)
      current_cards.clear
    else # computer wins
      add_to_earned(player_two_earned, user_selection, computer_selection)
      add_computer_selection(computer)
    end
  end

  def compare_user_second(user_selection, computer_selection, computer)
    if (computer_selection <=> user_selection) == 1 &&
       # user_selection.suit == briscola['suit'] # computer wins
      add_to_earned(player_two_earned, user_selection, computer_selection)
      add_computer_selection(computer)
    else # user wins
      add_to_earned(player_one_earned, user_selection, computer_selection)
      current_cards.clear
    end
  end

  def add_computer_selection(computer)
    current_cards.clear
    computer_selection = computer.before_user
    current_cards << computer_selection
    delete_from_hand(player_two_hand, computer_selection)
  end

  def draw
    if deck.length > 1
      player_one_hand.push(deck.shift)
      player_two_hand.push(deck.shift)
    elsif deck.length == 1 # draw last card in deck and add briscola
      player_one_hand.push(deck.shift)
      player_two_hand.push(briscola)
    end
  end

  def first_current_card
    if !current_cards.empty?
      Card.new(current_cards[0]['suit'],
               current_cards[0]['rank'],
               current_cards[0]['point_value'])
    end
  end

  def second_current_card
    if !current_cards.empty?
      Card.new(current_cards[1]['suit'],
               current_cards[1]['rank'],
               current_cards[1]['point_value'])
    end
  end

  def delete_from_hand(hand, card)
    hand.delete('suit' => card.suit, 'rank' => card.rank,
                'point_value' => card.point_value)
  end

  def add_to_earned(earned, user_card, computer_card)
    earned.push(user_card, computer_card)
  end
end
