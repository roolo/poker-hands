require 'spec_helper'

describe Hand do
  it 'loads cards' do
    hand = Hand.new 'QS 3D TC'

    hand.values.should  eq %w(Q 3 T)
    hand.suits.should   eq %w(S D C)
  end

  describe 'Hand Ranking' do
    it 'recognize Straight flush' do
      hand = Hand.new '9D TD JD QD KD'

      hand.rank.should eq [:straight_flush, 0]
    end

    it 'recognize Four of a kind' do
      hand = Hand.new '9C 9D 9H 9S KC'

      hand.rank.should eq [:four_of_kind, '9']
    end

    it 'recognize Full House' do
      hand = Hand.new '8C 8D 8H KS KC'

      hand.rank.should eq [:full_house, '8']
    end
  end
end
