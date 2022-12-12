class CommentsController < ApplicationController
    def create 
        @comment = Comment.create(comment_params)
        if @comment
            head :ok
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:description, :user_id, :bug_id)
      end
end