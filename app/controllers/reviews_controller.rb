class ReviewsController < ApplicationController
    # find_champion is ran first to get the champion passed through
    before_action :find_champion

    # edit, update and destroy methods get access to the review being passed through
    before_action :find_review, only: [:edit, :update, :destroy]

    # updates new review in the model
    def new
        @review = Review.new
    end

    # functionality for creating a review
    def create
        @review = Review.new(review_params)
        @review.champion_id = @champion.id
        @review.user_id = current_user.id

        # if the review saves, redirect to index
        if @review.save
            redirect_to champion_path(@champion)
        
        # otherwise return to the new review page
        else
            render 'new'
        end
    end

    # functionality for editing a review, handled by the before_action, uses find_review private method
    def edit
    end

    # functionality for updating a review in the database
    def update
        @review = Review.find(params[:id])

        if @review.update(review_params)
            redirect_to champion_path(@champion)
        else
            render 'edit'
        end
    end

    #functionality foe deleting a review in the database
    def destroy
        @review.destroy
        redirect_to champion_path(@champion)
    end

    private
        # required params to make a review
        def review_params
            params.require(:review).permit(:rating, :comment)
        end

        # pulls champion from request
        def find_champion
            @champion = Champion.find(params[:champion_id])
        end

        # pulls review from request
        def find_review
            @review = Review.find(params[:id])
        end
end
