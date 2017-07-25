namespace :import do
  desc 'Import xml from "https://www.hydrodata.ch/data/hydroweb.xml" into database'
  task bafu_hydrodata: :environment do
    BafuImporter.new.call
  end
end
