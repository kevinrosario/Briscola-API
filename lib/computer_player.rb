# frozen_string_literal: true

require_relative 'card'

# Algorithm to choose the best available card
class ComputerPlayer
  attr_accessor :hand, :user_selection, :computer_selection, :briscola
  def initialize(hand, briscola)
    @briscola = briscola
    @hand = hand.map do |card|
      Card.new(card['suit'], card['rank'],
               card['point_value'])
    end
  end

  def after_user
    hand.sample
  end

  def before_user
    hand.sample
  end
end
