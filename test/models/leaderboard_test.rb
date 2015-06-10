require 'test_helper'

describe "Leaderboard" do

  let(:m1) { Member.create(email: 'bob@foo.fr') }
  let(:m2) { Member.create(email: 'bob@bar.fr') }
  let(:m3) { Member.create(email: 'bob@toto.fr') }

  after do
    clear_redis
  end

  it "displays a list of top 10 members by followers count" do
    m1.follow!(m3)
    m2.follow!(m1)
    m3.follow!(m1)
    assert_equal Leaderboard.top10.to_a, [m1, m3]
  end

  protected

  def clear_redis
    Redis.current.flushdb
  end

end
