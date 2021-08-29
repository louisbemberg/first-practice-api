class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true # anyone can see a specific post
  end

  def update?
    record.user == user || record.user.email = 'louisbemberg@my-first-api.com'
  end
end
