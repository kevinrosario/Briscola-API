# frozen_string_literal: true

require_relative 'card'

# Representation of a deck of briscas
class Deck
  include Enumerable
  attr_accessor :deck

  def initialize
    @deck = Card::SUITS.map do |suit|
      Card::RANKS.map do |rank|
        if rank == 'JACK'
          Card.new(suit, rank, 2)
        elsif rank == 'KNIGHT'
          Card.new(suit, rank, 3)
        elsif rank == 'KING'
          Card.new(suit, rank, 4)
        elsif rank == '3'
          Card.new(suit, rank, 10)
        elsif rank == 'ACE'
          Card.new(suit, rank, 11)
        else
          Card.new(suit, rank, 0)
        end
      end
    end.flatten
  end

  def each
    storage.each do |brisca|
      yield brisca
    end
  end

  def draw
    deck.shift
  end

  def shuffle!
    deck.shuffle!
    self
  end

  # draw three cards to the hand
  def deal
    hand = []
    3.times do
      hand << draw
    end
    hand
  end
end
