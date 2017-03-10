namespace :db do
  namespace :seed do
    task :single => :environment do
      filename = Dir[File.join(Rails.root, 'db', 'simulation', "#{ENV['SEED']}.rb")][0]
      puts "Seeding DB: #{ENV['SEED']}..."
      load(filename) if File.exist?(filename)
    end
  end
end