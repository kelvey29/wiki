class RegistrationsController < Devise::RegistrationsController
    
    def update
        super
        if :role == true
           self.update_attributes(role: 0)
        end
    end
    
    private
    def user_params
       params.require(:user).permit(:role) 
    end
end