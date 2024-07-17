module UsersHelper
  def gravatar_for user, options = {size: Settings.gravatar.size}
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravater"
  end

  def can_destroy? user
    current_user.admin? && !current_user?(user)
  end
end
