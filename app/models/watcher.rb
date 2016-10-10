class Watcher < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :friends, -> { order(first_name: :asc) }

  validates :vk_id, :name, :photo, :domain, :user, presence: true
  validates :vk_id, numericality: true

  default_scope { order(created_at: :desc) }

  def update_friends_count
    self.friends_count = friend_ids.count
  end

  def self.parse_vk_id(vk_url)
    return if vk_url.empty?
    regex = %r{(http(s)?:\/\/)?(vkontakte\.ru|vk\.com)?\/?[a-zA-Z0-9._]+}
    match = regex.match(vk_url)
    match[0].split('/').last
  end
end
