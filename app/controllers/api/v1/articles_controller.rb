module Api
    module V1
        class ArticlesController < ApplicationController
            def index
                articles = Article.order('created_at DESC');
                render json: {status: 'SUCCESS', message: 'Loaded articles', data:articles }, status: :ok
            end
            def show
                articles = Article.find(params[:id])
                render json: {status: 'SUCCESS', message: 'Loaded article ', data:articles }, status: :ok
            end

            def create
                articles = Article.new(article_params)

                if articles.save
                    render json: {status: 'SUCCESS', message: 'Saved article ', data:articles }, status: :ok
                else
                    render json: {status: 'ERROR', message: 'Article not saved ', data:article.errors }, status: :unprocessable_entity
                end
            end

            def destroy
                articles = Article.find(params[:id])
                articles.destroy
                render json: {status: 'SUCCESS', message: 'Deleted article ', data:articles }, status: :ok

            end

            def update
                articles = Article.find(params[:id])
                if articles.update_attributes(article_params)
                    render json: {status: 'SUCCESS', message: 'Updated article ', data:articles }, status: :ok
                else 
                    render json: {status: 'ERROR', message: 'Article not updated ', data:article.errors }, status: :unprocessable_entity
                end   
            end

            private
            def article_params
                params.permit(:title, :body)
            end
            
        end
    end
end