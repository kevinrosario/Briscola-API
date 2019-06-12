# frozen_string_literal: true

class GameSerializer < ActiveModel::Serializer
<<<<<<< HEAD
  attributes :id, :briscola, :player_one_hand, :player_one_earned,
             :current_cards, :deck, :over

=======
  attributes :id, :briscola, :player_one_hand, :current_cards, :deck,
             :player_one_earned, :player_two_last_selection, :over
>>>>>>> development
  has_one :user
end
