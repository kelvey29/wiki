class ChargesController < ApplicationController
    
    def new
        @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key] }",
            description: "BigMoney Membership - #{current_user.email}",
            amount: 10_00
        }
    end
    
    def create
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )
        
        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: 10_00,
            description: "BigMoney Membership - #{current_user.email}",
            currency: 'usd'
        )
        
        current_user.update_attributes(role: "premium")
        flash[:notice] = "#{current_user.email}, thank you for becoming a premium member!"
        redirect_to root_path
        
        rescue Stripe::CardError => e
            flash[:error] = e.message
            redirect_to new_charge_path
    end
    
    def downgrade
        current_user.update_attributes(role: "standard")
        
        redirect_to root_path, notice: "You've been downgraded successfully"
    end

end
