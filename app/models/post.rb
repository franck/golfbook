class Post
  include RedisModel

  def self.create(opts)
    message = opts[:message]
    member_id = opts[:member_id]

    if message.blank? or message.blank?
      return false
    else
      post_id = redis.incr(:posts_ids)
      redis.multi do
        redis.hmset("post:#{post_id}", :message, message)
        redis.lpush("posts:#{member_id}", post_id)
      end
    end
  end

  def self.for_member(member_id, per_page=10)
    post_ids = redis.lrange("posts:#{member_id}", 0, per_page)
    posts = post_ids.map do |post_id|
      redis.hgetall("post:#{post_id}")
    end
    return posts
  end

  def self.redis
    Redis.current
  end

end
