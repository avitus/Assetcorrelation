Airbrake.configure do |config|
  config.project_key = '66eb3b084b1e68dbc06d9ac0c711e51e'
  config.project_id = 81439
  config.environment = Rails.env
  config.ignore_environments = %w(development test cucumber)
  config.root_directory = '/home/avitus/assetcorrelation.com/current'
end

# This can be removed once we upgrade to Passenger v 5.0 (ALV Feb 2016)
Airbrake.add_filter do |notice|
  # See: https://github.com/phusion/passenger/issues/1730
  passenger_error = proc do |error|
    error[:backtrace].empty? &&
      error[:type] == 'NoMethodError' && 
      error[:message] =~ %r{undefined method `call'}
  end

  notice.ignore! if notice[:errors].any?(&passenger_error)
end

Airbrake.add_filter do |notice|
  # The library supports nested exceptions, so one notice can carry several
  # exceptions.
  if notice[:errors].any? { |error| error[:type] == 'ActionNotFound' }
    notice.ignore!
  end
end
