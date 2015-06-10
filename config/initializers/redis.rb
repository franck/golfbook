if Rails.env == 'test'
  Redis.current = Redis.new(host: 'localhost', port: 6379, db: 12)
else
  Redis.current = Redis.new(host: 'localhost', port: 6379, db: 13)
end
