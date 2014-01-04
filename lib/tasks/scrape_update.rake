task :scrape_update => :environment do
  ApplicationController.helpers.scrape_update
end
