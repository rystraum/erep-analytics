class Item < ActiveRecord::Base
  attr_accessible :country, :data, :item_quality, :item_type

  before_create :sanitize_fields

  def sanitize_fields
    self.country = self.country.split("/").last.to_i
    self.item_quality = self.item_quality.split("/").last.to_i
    self.item_type = self.item_type.split("/").last.to_i
  end

  def parse_data
    html = data

    raise BoughtMessage unless html.match(/successfully/).nil?

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

end

