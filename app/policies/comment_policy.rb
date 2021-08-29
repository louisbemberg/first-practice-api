class CommentPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.user == user || record.user.email == 'louisbemberg@my-first-api.com'
  end
end
