# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
  attributes :id, :deck, :briscola, :player_one_hand, :player_two_hand,
             :player_one_earned, :player_two_earned, :current_cards, :over
  has_one :user
end
