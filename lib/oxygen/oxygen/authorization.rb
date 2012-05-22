module Oxygen
  module Authorization
    
    def authorize(action, record)
      # binding.pry
      if can?(action, record)
        true
      else
        redirect_to root_path, notice: "Sorry, you can't do that."
      end
    end
    
    def can?(action, record)
      current_user && ( current_user.is? :admin || permission_granted_for?(action, resource) )
    end
    
    def permission_granted_for?(action, record)
      if record.respond_to?(:grants) && record.grants[action.to_s]
        record.grants[action.to_s].include? current_user.id
      end
    end
    
  end
end