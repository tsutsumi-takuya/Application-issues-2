class RelationshipsController < ApplicationController

  before_action :authenticate_user!

def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    redirect_back(fallback_location: root_path)
end

def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
end

def create_params
    params.permit(:following_id).merge(follower_id: current_user.id)
end
end
