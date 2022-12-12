module BugsHelper
    def show_assigned_user user_id
        User.find_by(id: user_id)&.name if user_id
    end
end
