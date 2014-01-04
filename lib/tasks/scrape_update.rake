task :rake scrape_update => :environment do
  ApplicationController.scrape_update
end
