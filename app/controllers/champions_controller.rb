class ChampionsController < ApplicationController
    # show, edit, update and destory methods can gain access to the champion requested
    before_action :find_champion, only: [:show, :edit, :update, :destroy]

    # index page functionality
    def index
        # if there's no category selected show all champions
        if params[:category].blank?
            @champions = Champion.all.order("created_at DESC")

        # otherwise get the champions for that specific category, in descending order
        else
            @category_id = Category.find_by(name: params[:category]).id
            @champions = Champion.where(:category_id => @category_id).order("created_at DESC")
        end
    end

    # functionality for creating a new champion in the database, assignes category name and id to it
    def new
        @champion = current_user.champions.build
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    # functionality for the champion page once clicked, the before_action calls 
    # the private function called find_champion below
    def show
    end

    # functionality for creating a new champion
    def create
        @champion = current_user.champions.build(champion_params)
        @champion.category_id = params[:category_id]

        #if the champion is saved redirect to the index page. otherwise renders new.html.erb
        if @champion.save
            redirect_to root_path
        else
            render 'new'
        end
    end

    # functionality for the search feature
    def search
        # if nothing is in the search field, show all champions
        if params[:search].blank?
          redirect_to champions_path
        
        #otherwise if the search matches show all champions that match
        elsif params[:search]
          @parameter = params[:search].downcase
          @search_results = Champion.all.where("lower(name) like ?", "#{@parameter}%")
        
        #if the search doesnt match a champion
        else
          flash.alert = "Could not find a champion with that query"
        end
    end
    
    # functionality for ediitng, handled by the before_action, calls the find_champion method
    def edit
        # populates the category with the existing category assigned
        @categories = Category.all.map{ |c| [c.name, c.id] }
    end

    # functionality for the update feature in the database
    # if update sucessful, redirect to index page, else go to edit page
    def update
        @champion.category_id = params[:category_id]
        if @champion.update(champion_params)
            redirect_to champion_path(@champion)
        else
            render 'edit'
        end
    end

    # unctionality for deleting champions, handled by the before_action, if sucesful redirect to index page.
    def destroy
        @champion.destroy
        redirect_to root_path
    end

    private

        # required parameters for making a new champion
        def champion_params
            params.require(:champion).permit(:name, :alias, :category_id, :champion_img)
        end
        # finds which champion is being passed through as a parameter.
        def find_champion
            @champion = Champion.find(params[:id])
        end
end
