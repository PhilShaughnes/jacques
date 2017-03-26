class NoteSerializer < ActiveModel::Serializer
  attributes :title, :body, :created_at, :updated_at, :tags, :user

  def user
    object.user ? object.user.slice(:username) : {username: "anonymous"}
  end

  def tags
    object.tags.map{ |t| t.slice(:name) }
  end
  #has_many :tags
  # belongs_to :user
end
