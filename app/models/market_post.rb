class MarketPost < ActiveRecord::Base
  attr_accessible :country, :merchandise, :price, :provider, :stock
  belongs_to :country
  belongs_to :merchandise
  belongs_to :item

  delegate :record_date, to: :item
  # after_commit :update_candlestick

  def as_json(opts = {})
    super.merge({ record_date: self.record_date, country: self.country.to_s, item: self.merchandise.to_s })
  end

  def update_candlestick
    # spawn_block(nice: 19, kill: true) do
      begin
        candle = Candlestick.find :first, conditions: ["date = ? and country_id = ? and merchandise_id = ?", record_date.to_date, country, merchandise]
        candle = Candlestick.create date: record_date.to_date, country: country, merchandise: merchandise unless candle

        candle.open    = price if candle.open.nil?

        candle.high    = price if candle.high.nil?
        candle.high    = price if !candle.high.nil? && price > candle.high

        candle.low     = price if candle.low.nil?
        candle.low     = price if !candle.low.nil? && candle.low > price

        candle.volume  = stock if candle.volume.nil?
        candle.volume += stock if !candle.volume.nil?

        candle.close   = price
        candle.save
      rescue ActiveRecord::StatementInvalid
        sleep 1.0
        retry
      rescue Mysql2::Error
        sleep 1.0
        retry
      end
    # end
  end
end

