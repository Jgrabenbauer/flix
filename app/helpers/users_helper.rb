module UsersHelper

  def profile_image(user, size = 100)
    gravatar_image_url = "http://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
    image_tag(gravatar_image_url, alt: user.name)
  end

  def form_submit(user)
    if user.new_record?
      "Create Account"
    else
      "Update Account"
    end
  end

end
