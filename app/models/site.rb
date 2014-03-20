class Site < ActiveRecord::Base
  has_many :posts
  belongs_to :category

  include GoogleSpreadsheets::Enhanced::Syncing
  sync_with :site_rows, spreadsheet_id: '0ArhV7gTgs6Z8dHlSRUF2SzFXWjlkU1V2d29KR2pkdXc'
  after_commit :sync_site_rows
end
