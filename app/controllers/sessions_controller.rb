class SessionsController < ApplicationController

 	def create
	  auth = request.env['omniauth.auth']
	  # find identity
	  @identity = Identity.find_with_omniauth(auth)

	  if @identity.nil?
	  	# no identity, create one
	    @identity = Identity.create_with_omniauth(auth)
	  end

	  if signed_in?
	    if @identity.user == current_user
	      # signed in and user already connected to this identity
	      redirect_to ENV['ROOT']
	    else
	      # signed in but this identity not associated with user, assoicate now
	      @identity.user = current_user
	      @identity.save()
	      redirect_to ENV['ROOT']
	    end
	  else
	    if @identity.user.present?
	      # signed in and identity present, sign user in
	      self.current_user = @identity.user
	      redirect_to ENV['ROOT']
	    else
	      	# now user with identity, create user, associate identity, sign user in
	     	@identity.user = User.create_with_omniauth(auth['info'])
	      	@identity.save()
            # Notifier.send_signup_email(@identity.user).deliver
	      	self.current_user = @identity.user
	      	redirect_to ENV['ROOT']
	    end
	  end
	end

  	def destroy
  		self.current_user = nil
  		redirect_to ENV['ROOT']
	end

end
