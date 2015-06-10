require 'test_helper'

describe 'MemberTest' do

  let(:m1) { Member.create(email: 'bob@foo.fr') }
  let(:m2) { Member.create(email: 'bob@bar.fr') }

  after do
    clear_redis
  end

  it "I can follow a member" do
    m1.follow!(m2)
    assert_includes m2.followers, m1
  end

  it "I can see my followers" do
    m1.follow!(m2)
    assert m2.followers, [m1]
  end

  it "I can see members I follow" do
    m1.follow!(m2)
    assert m1.followers, [m2]
  end

  it "I can unfollow a member" do
    m1.follow!(m2)
    m1.unfollow!(m2)
    assert m1.following, []
  end

  protected

  def clear_redis
    Redis.current.flushdb
  end

end
