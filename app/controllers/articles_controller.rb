class ArticlesController < ApplicationController
	# the order of our before_action's matters. THey are called in the order they are executed.
	before_action :set_article, only: [:edit, :update, :show, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def index
		# instead of Artice.all like we had initially, here we are using the pagination gem to create pagination
		# to all available articles:
		@articles = Article.paginate(page: params[:page], per_page: 3)
	end

	def new
		@article = Article.new
	end

	def create 
		# the following can be used to 'pause' the server when this line is hit and therefore ensure that we can debug the application.
		# - by clicking 'n' it ensures that we can run the next line in sequence.
		# debugger
		
		# in order to display what is being passed in from the form html:
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
		
		# short term fix that whenever a new article is created then the first user in the db is set as the person that created it.
		# @article.user = User.first
		# Long term we want the article to reference the user that has logged in: we can therefore use our helper method.
		@article.user = current_user
		if @article.save
			#create a flash notice to the user:
			flash[:notice] = "article has been successfully added."
			redirect_to article_path(@article)
		else
			# render the page we are still on:
			render :new
		end
	end

	def update
		# due to before action: @article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Article has been successfully updated"
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def edit
		# due to before action: @article = Article.find(params[:id])
	end

	def show
		# due to before action: @article = Article.find(params[:id])
	end

	def destroy
		# due to before action: @article = Article.find(params[:id])
		@article.destroy	
		flash[:notice] = "Article has been destroyed"
		redirect_to article_path
	end

	private

		def set_article
			@article = Article.find(params[:id])
		end
		
		def article_params
			params.require(:article).permit(:title, :description, category_ids: [])
		end

		# in order to require that the same user that can access the articles is the same person that is logged in:
		def require_same_user
			if current_user != @article.user and !current_user.admin?
				flash[:danger] = "You can only edit or delete your own articles"
				redirect_to root_path
			end
		end

end