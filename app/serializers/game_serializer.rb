# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
  attributes :id, :briscola, :player_one_hand, :player_two_hand, :current_cards,
             :player_one_earned, :player_two_earned, :deck
  has_one :user
end
