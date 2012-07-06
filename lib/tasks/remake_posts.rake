namespace :db do
  desc "Update statistics"
  task :remake_posts => :environment do
    Item.all.each &:clean_and_save
    Country.delete_all
    Merchandise.delete_all
    MarketPost.delete_all
    Statistic.delete_all
    Item.all.each &:update_market_data
  end
end

