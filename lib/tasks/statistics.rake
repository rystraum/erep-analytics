namespace :db do
  desc "Update statistics"
  task :update_stats => :environment do
    MarketPost.includes(:country, :merchandise, :item).find(:all, order: "created_at asc").each &:update_statistics
  end
end

