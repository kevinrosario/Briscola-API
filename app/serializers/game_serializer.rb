# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
  attributes :id, :briscola, :player_one_hand, :current_cards, :deck,
             :player_one_earned
  # :player_two_hand, , :player_two_earned,
  has_one :user
end
