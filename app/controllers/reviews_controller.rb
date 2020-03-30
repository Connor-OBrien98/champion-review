class ReviewsController < ApplicationController
    before_action :find_champion
    before_action :find_review, only: [:edit, :update, :destroy]

    def new
        @review = Review.new
    end

    def create
        @review = Review.new(review_params)
        @review.champion_id = @champion.id
        @review.user_id = current_user.id

        if @review.save
            redirect_to champion_path(@champion)
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        @review = Review.find(params[:id])

        if @review.update(review_params)
            redirect_to champion_path(@champion)
        else
            render 'edit'
        end
    end

    def destroy
        @review.destroy
        redirect_to champion_path(@champion)
    end

    private

        def review_params
            params.require(:review).permit(:rating, :comment)
        end

        def find_champion
            @champion = Champion.find(params[:champion_id])
        end

        def find_review
            @review = Review.find(params[:id])
        end
end
