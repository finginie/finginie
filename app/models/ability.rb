class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    # user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    if user
      can :manage, Portfolio, :user_id => user.id
      can :manage, Subscription, :user_id => user.id
      can :manage, Subscription, :subscribable_type => 'User', :subscribable_id => user.id
      can :read, EventUpdate
      can :manage, User, :id => user.id
      can :read, User
      can [:create, :destroy], :public_portfolio
      can [:current_holdings, :profit_loss, :historical_transactions], :public_portfolio
      can :manage, TradeAccount, :user_id => user.id
      cannot [:update, :destroy], TradeAccount, :issued => true
      can :index, :response
    end

    can :show, :public_portfolio
  end
end
