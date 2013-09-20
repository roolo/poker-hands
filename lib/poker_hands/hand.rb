class Hand
  # @attr_accessor All values in hand
  attr_accessor :values
  # @attr_accessor All suits in hand
  attr_accessor :suits

  # @param [String] cards Cards in hand (e.g. 'QS 3D TC' )
  def initialize cards
    @values = []
    @suits  = []

    cards.split(/\s/).each do |card|
      @values.push card[0]
      @suits.push  card[1]
    end
  end

  # @return [Array(Symbol,Integer)] Word ranking and supplementary ranking for
  #   case of match
  def rank
    is_consecutive_values = @values.map{|val|
      PokerHands::VALUES.index(val)
    }.sort == @values.map{|val|
      PokerHands::VALUES.index(val)
    }
    same_four_val = @values.detect{|val| @values.count(val) >= 4 }

    if @suits.uniq.count == 1 && is_consecutive_values
      ranking = [:straight_flush, 0]
    elsif @values.uniq.count <= @values.count-3 && same_four_val
      ranking = [:four_or_kind, same_four_val]
    end

    ranking
  end
end
