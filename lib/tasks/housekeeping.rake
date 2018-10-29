namespace :housekeeping do
  desc 'Export and removes old entries from the database'
  task export: :environment do
    Measurement.where('datetime < ?', 60.days.ago).find_each do |measurement|
      measurement_date = measurement.datetime.to_date
      archive_directory = "archive/#{measurement_date.year}-#{measurement_date.month.to_s.rjust(2, '0')}"
      archive_filename = "#{archive_directory}/#{measurement.datetime.to_date}"

      FileUtils.mkdir_p archive_directory
      File.open(archive_filename, 'a') { |f| f.write "#{measurement.to_json}\n" }

      measurement.destroy!
    end
  end

  desc 'Vacuums the postgres database to free up space'
  task db: :environment do
    ActiveRecord::Base.connection.execute('VACUUM FULL')
  end
end
