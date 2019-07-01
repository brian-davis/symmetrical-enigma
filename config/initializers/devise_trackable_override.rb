# https://www.rubydoc.info/github/plataformatec/devise/Devise/Models/Trackable#extract_ip_from-instance_method
# gems/devise-4.6.2/lib/devise/models/trackable.rb
module Devise
  module Models
    module TrackableOverride
      def update_tracked_fields(request)
        old_current, new_current = self.current_sign_in_user_agent, extract_user_agent_from(request)
        self.last_sign_in_user_agent     = old_current || new_current
        self.current_sign_in_user_agent  = new_current
        super
      end

      protected

      def extract_user_agent_from(request)
        request.user_agent
      end
    end
  end
end

Devise::Models::Trackable.prepend(Devise::Models::TrackableOverride)
