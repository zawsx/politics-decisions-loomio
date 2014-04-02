namespace :loomio do
  task :dump_emails => :environment do
    File.open('emails_from_1march.txt', 'w') do |f|
      User.where('created_at > ?', Date.parse('1 march')).each do |u|
        f.puts u.email
      end
    end
  end

  task :close_lapsed_motions => :environment do
    MotionService.close_all_lapsed_motions
  end
  task :generate_error => :environment do
    raise "Testing error reporting for rake tasks, chill, no action requied if you see this"
  end
end
