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
    if @suits.uniq.count == 1
      if is_consecutive_values
        ranking = [:straight_flush, 0]
      else
        ranking = [:flush, highest_value]
      end
    elsif @values.uniq.count <= @values.count-3
      if same_four_val
        ranking = [:four_of_kind, same_four_val]
      elsif same_three_val
        ranking = [:full_house, same_three_val]
      end
    elsif is_consecutive_values
      ranking = [:straight, highest_value]
    elsif same_three_val
      ranking = [:three_of_kind, same_three_val]
    end

    ranking
  end

  # Determines if hand has consecutive values
  #
  # @todo This is not solution for when the cards are not sorted on input
  #
  # @return [TrueClass]
  def is_consecutive_values
    @values.map { |val|
      PokerHands::VALUES.index(val)
    }.sort == @values.map { |val|
      PokerHands::VALUES.index(val)
    } && @values.uniq.count >= 5
  end

  # @return [String]
  def same_three_val
    @values.detect{|val| @values.count(val) >= 3 }
  end

  # @return [String]
  def same_four_val
    @values.detect{|val| @values.count(val) >= 4 }
  end

  # Detects higher value in hand
  #
  # @return [String] Higher value by poker rules
  def highest_value
    PokerHands::VALUES[@values.inject(0){|highest_index, val|
      value_poker_index = PokerHands::VALUES.index(val)
      if value_poker_index > highest_index
        value_poker_index
      else
        highest_index
      end
    }]
  end
end
