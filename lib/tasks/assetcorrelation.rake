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
        s.price_quotes.destroy_all
      end
    }

    puts "=== Finished ==="

  end

  #--------------------------------------------------------------------------------------------
  # Remove invalid securities which no longer have a price history in Yahoo
  #--------------------------------------------------------------------------------------------
  desc "Remove invalid securities"
  task :locate_splits => :environment do

    puts "=== Locating invalid securities without any price history in Yahoo ==="

    Security.find_each { |s|
      if !s.has_history?
        puts("#{s.created_at} : #{s.ticker} -- No history returned from Yahoo")
        # s.destroy
      end
    }

    puts "=== Finished ==="

  end

end




