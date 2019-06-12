# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
  attributes :id, :briscola, :player_one_hand, :player_one_earned,
             :current_cards, :deck, :over

  has_one :user
end
