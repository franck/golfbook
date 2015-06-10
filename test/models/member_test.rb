require 'test_helper'

describe 'Member' do

  let(:m1) { Member.create(email: 'bob@foo.fr') }
  let(:m2) { Member.create(email: 'bob@bar.fr') }

  after do
    clear_redis
  end

  subject { m1 }

  it "follows a member" do
    subject.follow!(m2)
    assert_includes m2.followers, m1
  end

  it "sees member followers" do
    subject.follow!(m2)
    assert m2.followers, [subject]
  end

  it "sees members I follow" do
    subject.follow!(m2)
    assert subject.followers, [m2]
  end

  it "unfollows a member" do
    subject.follow!(m2)
    subject.unfollow!(m2)
    assert subject.following, []
  end

  it "counts followers" do
    subject.follow!(m2)
    assert m2.followers_count, 1
  end

  it "counts following" do
    subject.follow!(m2)
    assert subject.following_count, 1
  end

  it "checks if member is following" do
    refute subject.following?(m2)
    subject.follow!(m2)
    assert subject.following?(m2)
  end

  it "checks if member is follower" do
    refute subject.follower?(m2)
    m2.follow!(subject)
    assert subject.follower?(m2)
  end

  protected

  def clear_redis
    Redis.current.flushdb
  end

end
