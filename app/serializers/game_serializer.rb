# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
  attributes :id, :briscola, :player_one_hand, :current_cards, :deck,
             :player_one_earned, :player_two_last_selection, :over
  has_one :user
end
