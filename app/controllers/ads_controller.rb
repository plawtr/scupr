class AdsController < ApplicationController
	def index
		@ads = Ad.all
  	render :json => { 
  			:ads => @ads.as_json }
	end

end

__END__
{ :success => true, 
  :user => @user.as_json(:only => [:email]) }