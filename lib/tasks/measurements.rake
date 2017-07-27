namespace :measurements do
  desc 'removes measurements that are older than four days from database'
  task remove_old: :environment do
    Measurement.where('created_at < ?', 4.day.ago).delete_all
  end
end
