task :rake update => :environment do
  ApplicationController.scrape_update
end
