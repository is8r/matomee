class Category < ActiveRecord::Base
  has_many :sites

  include GoogleSpreadsheets::Enhanced::Syncing
  sync_with :category_rows, spreadsheet_id: '0ArhV7gTgs6Z8dHlSRUF2SzFXWjlkU1V2d29KR2pkdXc'
  after_commit :sync_category_rows
end
