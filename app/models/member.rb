class Member < ActiveRecord::Base

  def follow!(member)
    redis.multi do
      redis.sadd(self.redis_key(:following), member.id)
      redis.sadd(member.redis_key(:followers), self.id)
    end

    member.update_member_rank
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

  def followers_count
    redis.scard(self.redis_key(:followers))
  end

  def following_count
    redis.scard(self.redis_key(:following))
  end

  def following?(member)
    redis.sismember(self.redis_key(:following), member.id)
  end

  def follower?(member)
    redis.sismember(self.redis_key(:followers), member.id)
  end

  protected

  def update_member_rank
    Leaderboard.rank_member(self.id, self.followers_count)
  end

  def redis
    Redis.current
  end

  def redis_key(str)
    "member:#{self.id}:#{str}"
  end

end
