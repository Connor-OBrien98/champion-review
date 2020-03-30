class ChampionsController < ApplicationController
    before_action :find_champion, only: [:show, :edit, :update, :destroy]

    def index
        if params[:category].blank?
            @champions = Champion.all.order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @champions = Champion.where(:category_id => @category_id).order("created_at DESC")
        end
    end

    def new
        @champion = current_user.champions.build
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def show
    end

    def create
        @champion = current_user.champions.build(champion_params)
        @champion.category_id = params[:category_id]

        if @champion.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    def edit
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    def update
        @champion.category_id = params[:category_id]
        if @champion.update(champion_params)
            redirect_to champion_path(@champion)
        else
            render 'edit'
        end
    end

    def destroy
        @champion.destroy
        redirect_to root_path
    end

    private

        def champion_params
            params.require(:champion).permit(:name, :alias, :category_id, :champion_img)
        end

        def find_champion
            @champion = Champion.find(params[:id])
        end
end
