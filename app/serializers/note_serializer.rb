class NoteSerializer < ActiveModel::Serializer
  attributes :title, :body, :created_at, :updated_at, :tags, :user, :id

  def user
    # object.user ? object.user.slice(:username) : {username: "anonymous"}
    object.user.slice(:username) if object.user
  end

  def tags
    object.tags.map{ |t| t.slice(:name) }
  end
  #has_many :tags
  # belongs_to :user
end
