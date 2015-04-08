# Real-time adjustments via env config
worker_processes Integer(ENV['WEB_CONCURRENCY'] || 1)


timeout 3000000000000000000000
preload_app true
listen ENV['PORT'], :backlog => Integer(ENV['UNICORN_BACKLOG'] || 200)


before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  # If you are using Redis but not Resque, change this
  # if defined?(Resque)
  #   Resque.redis.quit
  #   Rails.logger.info('Disconnected from Redis')
  # end

  if defined?(::REDIS_DB)
    ::REDIS_DB.client.disconnect
  end

  sleep 1
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    config = Rails.application.config.database_configuration[Rails.env]
    # config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds  # only available in Rails 4
    config['pool']            = ENV['WEB_DB_POOL'] || 5    
    ActiveRecord::Base.establish_connection
    # User::Gis.establish_connection :gis
    Rails.logger.info('Connected to ActiveRecord')
  end

  if defined?(EventMachine)
    unless EventMachine.reactor_running? && EventMachine.reactor_thread.alive?
      if EventMachine.reactor_running?
        EventMachine.stop_event_loop
        EventMachine.release_machine
        EventMachine.instance_variable_set("@reactor_running",false)
      end
      Thread.new { EventMachine.run }
    end
  end

  # Signal.trap("INT") { EventMachine.stop rescue nil }
  # Signal.trap("TERM") { EventMachine.stop rescue nil }

  # If you are using Redis but not Resque, change this
  if defined?(::REDIS_DB)
    ::REDIS_DB.client.connect
    Rails.logger.info "Reconnecting to redis"
  end

  # if defined?($pubnub_init)
  #   $pubnub_init.call
  # end
end
