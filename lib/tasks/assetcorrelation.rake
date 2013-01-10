namespace :utils do

  #--------------------------------------------------------------------------------------------
  # Locate securities with price splits that aren't reflected in database
  #--------------------------------------------------------------------------------------------
  desc "Locate securities with price splits"
  task :locate_splits => :environment do

    puts "=== Locating securities with price splits not recorded in our database ==="

    Security.find_each { |s|
      if s.has_split?
        puts("#{s.created_at} : #{s.ticker}")
      end
    }

    puts "=== Finished ==="

  end

end




