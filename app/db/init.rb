require 'data_mapper'

if ENV['RACK_ENV'] == 'test'
  DataMapper.setup(:default, 'mysql://root:root@localhost/flippd_test')
else
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, 'mysql://root:root@localhost/flippd')
end

# Require all of the files under /app/models/
Dir[File.join(File.dirname(__FILE__), '..', 'models', '**', '*.rb')].each { |file| require file }

DataMapper.finalize

if ENV['RACK_ENV'] == 'test'
  DataMapper.auto_migrate!
else
  DataMapper.auto_upgrade!
end
