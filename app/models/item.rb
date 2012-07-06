class Item < ActiveRecord::Base
  attr_accessible :country, :data, :item_quality, :item_type
  has_many :market_posts

  before_create :sanitize_fields
  after_commit :record_market_data

  def sanitize_fields
    self.country = self.country.split("/").last.to_i
    self.item_quality = self.item_quality.split("/").last.to_i
    self.item_type = self.item_type.split("/").last.to_i
  end

  def parse_data
    html = data

    return [] unless html.match(/successfully/).nil?
    return [] unless html.match(/There are no market offers matching your search./).nil?
    return [] unless html.match(/You can buy maximum [0-9]* products for this offer/).nil?
    return [] unless html.match(/companies for sale/).nil?
    return [] unless html.match(/This offer doesn't exist anymore./).nil?
    return [] unless html.match(/Storage capacity is limited./).nil?
    return [] unless html.match(/buy a company/).nil?

    doc = Nokogiri::HTML(html)

    parsed_data = []
    doc.css('tr').each_with_index do |row, i|
       provider_id = row.css('td.m_provider a').first.attribute_nodes.first.value.split("/").last
       parsed_data[i] = {
        provider: provider_id,
        stock: row.css('td.m_stock').children.first.to_s.to_i,
        price: (row.css('td.m_price > strong').children.first.to_s + row.css('td.m_price sup').children.first.to_s).to_f
      }
    end

    parsed_data
  end

  def record_market_data
    if market_posts.empty?
      merchandise = Merchandise.find_by_erep_item_code_and_quality(item_type,item_quality) || Merchandise.create(erep_item_code: item_type, quality: item_quality)
      country = Country.find_or_create_by_erep_country_id(country)

      spawn_block(nice: 19, kill: true) do
        begin
          market_data = parse_data

          post = nil
          ActiveRecord::Base.transaction do
            market_data.each do |m|
              post = self.market_posts.build provider: m[:provider], price: m[:price], stock: m[:stock]
              post.country = country
              post.merchandise = merchandise
              post.save
            end
          end
        rescue ActiveRecord::StatementInvalid
          sleep 1.0
          retry
        rescue Mysql2::Error
          sleep 1.0
          retry
        end
      end
    end
  # rescue NoMethodError
    # require 'pry'; binding.pry
  end

  def record_date
    created_at
  end
end

