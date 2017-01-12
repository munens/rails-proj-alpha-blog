module ApplicationHelper
    # to get the gravatars size the function below can take another argument - options:
    def gravatar_for(user,  options = {size: 80})
        # gravatar urls are based on the users hash: We will use the gravatar_id variable to do this:
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        
        size = options[:size]
        # append the size to the end:
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        
        # the image tag method can take in the url, the 'alt' and the class - which in this case we want a circle:
        image_tag(gravatar_url, alt: user.username, class: "img-circle")
    end
end
