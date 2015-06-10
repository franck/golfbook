class Leaderboard

  def self.top10
    member_ids = redis.zrange(:topfollowed, 0, 10)
    Member.where(id: member_ids)
  end

  def self.rank_member(member_id, score)
    redis.zadd(:topfollowed, score, member_id)
  end

  protected

  def self.redis
    Redis.current
  end

end
