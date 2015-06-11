class MembersController < ApplicationController

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.wall
  end


  def follow
    @member = Member.find(params[:id])
    current_member.follow!(@member)
    redirect_to member_path(@member)
  end

  def unfollow
    @member = Member.find(params[:id])
    current_member.unfollow!(@member)
    redirect_to member_path(@member)
  end

end
