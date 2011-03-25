class Investment < ActiveRecord::Base

# Structure
#
#     company,      :string
#     partner,      :string
#     investment,   :decimal, :precision => 10, :scale => 0
#     reserves,     :decimal, :precision => 10, :scale => 0
#     outcome_0,    :decimal, :precision => 5, :scale => 2, :default => -1.00
#     outcome_1,    :decimal, :precision => 5, :scale => 2, :default => -0.80
#     outcome_2,    :decimal, :precision => 5, :scale => 2, :default => -0.50
#     outcome_3,    :decimal, :precision => 5, :scale => 2, :default => -0.20
#     outcome_4,    :decimal, :precision => 5, :scale => 2, :default =>  0.00
#     outcome_5,    :decimal, :precision => 5, :scale => 2, :default =>  0.40
#     outcome_6,    :decimal, :precision => 5, :scale => 2, :default =>  0.80
#     outcome_7,    :decimal, :precision => 5, :scale => 2, :default =>  1.00
#     outcome_8,    :decimal, :precision => 5, :scale => 2, :default =>  3.00
#     outcome_9,    :decimal, :precision => 5, :scale => 2, :default =>  6.00
#     date_initial  :date


  def self.show_investments(sort_order)
    case sort_order
      when "partner"
        find(:all, :order => "partner")
      when "investment"
        find(:all, :order => "investment")
      when "date"
        find(:all, :order => "date_initial")  
      when "company"
        find(:all, :order => "company") 
      when "reserves"
        find(:all, :order => "reserves")        
      else
        find(:all, :order => "date_initial")
      end
  end

  def self.run_sim
    
    # Monte carlo simulation  
    @return_histogram = Histogram.new(1.2, 0.1, 25)
    @distribution = Array.new
    @investments = find(:all, :order => "company") # returns array of investments


    for i in 0...@investments.length
      @distribution[i]  = 
                       [@investments[i].outcome_0,@investments[i].outcome_1,@investments[i].outcome_2,
                        @investments[i].outcome_3,@investments[i].outcome_4,@investments[i].outcome_5,
                        @investments[i].outcome_6,@investments[i].outcome_7,@investments[i].outcome_8,
                        @investments[i].outcome_9]
    end
    
    # This calculation currently includes reserves 
    10000.times do
      @tot_ret = 0
      for i in 0...@investments.length
        @tot_ret += (@investments[i].investment + @investments[i].reserves) * (@distribution[i][rand(10)] + 1)
      end
      @return_multiple = @tot_ret / (@investments.sum { |investment| investment.investment + investment.reserves })
      @return_histogram.add_data(@return_multiple)
    end      
      
    return @return_histogram
  end


  def multiple
    outcome_0 * 0.1 +
    outcome_1 * 0.1 +
    outcome_2 * 0.1 +
    outcome_3 * 0.1 +
    outcome_4 * 0.1 +
    outcome_5 * 0.1 +
    outcome_6 * 0.1 +
    outcome_7 * 0.1 +
    outcome_8 * 0.1 +
    outcome_9 * 0.1 + 1
  end
  
  def loss_prob
    @loss_prob = 0
    for i in [outcome_0, outcome_1, outcome_2, outcome_3, outcome_4, outcome_5, outcome_6, outcome_7, outcome_8, outcome_9]
      @loss_prob = @loss_prob + 10 if i<0
    end
    return @loss_prob
  end
  
  validates_presence_of       :company, :partner, :investment
  validates_numericality_of   :investment, :reserves
  validates_numericality_of   :outcome_0, :outcome_1, :outcome_2, :outcome_3, :outcome_4
  validates_numericality_of   :outcome_5, :outcome_6, :outcome_7, :outcome_8, :outcome_9
  validates_uniqueness_of     :company
  
  protected
  def validate
    errors.add(:investment, "Should be at least 1,000,000") if investment.nil? || investment < 1000000
    errors.add(:outcome_0,  "Should be in range -1 to +20") if outcome_0.nil?  || outcome_0  < -1 || outcome_0 > 20
    errors.add(:outcome_1,  "Should be in range -1 to +20") if outcome_1.nil?  || outcome_1  < -1 || outcome_1 > 20
    errors.add(:outcome_2,  "Should be in range -1 to +20") if outcome_2.nil?  || outcome_2  < -1 || outcome_2 > 20
    errors.add(:outcome_3,  "Should be in range -1 to +20") if outcome_3.nil?  || outcome_3  < -1 || outcome_3 > 20
    errors.add(:outcome_4,  "Should be in range -1 to +20") if outcome_4.nil?  || outcome_4  < -1 || outcome_4 > 20
    errors.add(:outcome_5,  "Should be in range -1 to +20") if outcome_5.nil?  || outcome_5  < -1 || outcome_5 > 20
    errors.add(:outcome_6,  "Should be in range -1 to +20") if outcome_6.nil?  || outcome_6  < -1 || outcome_6 > 20
    errors.add(:outcome_7,  "Should be in range -1 to +20") if outcome_7.nil?  || outcome_7  < -1 || outcome_7 > 20
    errors.add(:outcome_8,  "Should be in range -1 to +20") if outcome_8.nil?  || outcome_8  < -1 || outcome_8 > 20
    errors.add(:outcome_9,  "Should be in range -1 to +20") if outcome_9.nil?  || outcome_9  < -1 || outcome_9 > 20    
  end
  
end
