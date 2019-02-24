class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Activity

    can %i[show create], Quotation
    # Users can update quotations who are still
    # waiting to be approved by the admin
    can :update, Quotation, pending: true

    if user.admin?
      can :manage, :all
    end

    if user.customer?
      can :read, Quotation, approved: true

      can :read, Party
      can :manage, Party, host_id: user.id
    end

    if user.guide?
      can :read, Party
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
