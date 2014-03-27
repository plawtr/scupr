class ChargesController < ApplicationController

  def new
	end

	def create
		begin
		  # Amount in pennies
		  @amount = 1000
		  Stripe.api_key = ENV['SECRET_KEY']
		  @business = Business.find(params["business-id"])

		  customer = Stripe::Customer.create(
		    :email 	=> 'snapr.love@gmail.com',
		    :card => params[:stripeToken]
		  )

		  charge = Stripe::Charge.create(
		    :customer    => customer.id,
		    :amount      => @amount,
		    :description => "Business: #{@business.name} - Yonder! customer",
		    :currency    => 'gbp'
		  )

		  @business.radius *= 2 
		 	render :json => { :business => @business.as_json } if @business.save

		rescue Exception => e
		  render :json => { :business => @business.errors.messages.merge({stripe: e.message})}
		end
	end
end
