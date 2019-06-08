# frozen_string_literal: true

# Representation of each card
class Card
  include Comparable
  SUITS = %w[SUN CUP CLUB SPADE].freeze
  RANKS = [%w[2 4 5 6 7], %w[JACK KNIGHT KING 3 ACE]].flatten.freeze
  POINT_VALUE = [0, 2, 3, 4, 10, 11].freeze

  attr_reader :suit, :rank, :point_value
  def initialize(suit, rank, point_value)
    unless SUITS.include?(suit) && RANKS.include?(rank) &&
           POINT_VALUE.include?(point_value)
      raise ArgumentError, 'Invalid card'
    end

    @suit = suit
    @rank = rank
    @point_value = point_value
  end

  def <=>(other)
    if suit == other.suit && point_value < other.point_value
      other
    elsif suit == other.suit && RANKS.index(rank) < RANKS.index(other.rank)
      other
    else
      self
    end
  end

  def to_json
    { 'suit' => @suit, 'rank' => @rank, 'point_value' => @point_value }.to_json
  end

  def self.from_json(string)
    data = JSON.parse(string)
    new(data['suit'], data['rank'], data['point_value'])
  end
end
