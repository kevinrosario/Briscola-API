# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
  attributes :id, :briscola, :player_one_hand, :current_cards, :over
  has_one :user
end
