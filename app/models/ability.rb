class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new

    if user.dater?

      # Messages. A dater can read messages sent to them and manage messages they've sent.
      can :manage, Message, user_id: user.id
      can :read, Message, recipient_id: user.id
      can :update, Message, recipient_id: user.id

      # Permissions. A dater can block or allow any other user to message them.
      can :manage, Permission, user_id: user.id
      can :read, Permission, target_user_id: user.id
      

      # Favorites. They can create or destroy as many as they want for other users.
      can :manage, Favorite, user_id: user.id


      # Daters. They can edit themselves, and view members of the opposite sex.
      can :manage, User, id: user.id
      can :read, User do |u|
        user.can_view_profile?(u)
      end


    elsif user.concierge?

    elsif user.admin?
      can :manage, :all
    else
    end
  
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
