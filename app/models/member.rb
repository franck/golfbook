class Member < ActiveRecord::Base

  def follow!(member)
    redis.multi do
      redis.sadd(self.redis_key(:following), member.id)
      redis.sadd(member.redis_key(:followers), self.id)
    end
  end

  def unfollow!(member)
    redis.multi do
      redis.srem(self.redis_key(:following), member.id)
      redis.srem(member.redis_key(:followers), self.id)
    end
  end

  def followers
    member_ids = redis.smembers(redis_key(:followers))
    Member.where(id: member_ids)
  end

  def following
    member_ids = redis.smembers(redis_key(:following))
    Member.where(id: member_ids)
  end

  protected

  def redis
    Redis.current
  end

  def redis_key(str)
    "member:#{self.id}:#{str}"
  end

end
