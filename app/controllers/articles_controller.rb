class ArticlesController < ApplicationController

	def index
		@articles = Article.all
	end

	def new
		@article = Article.new
	end

	def create 
		# in order to display what is being passed in from the form html:
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
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
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Article has been successfully updated"
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def show
		@article = Article.find(params[:id])
	end


	private
		
		def article_params
			params.require(:article).permit(:title, :description)
		end

end