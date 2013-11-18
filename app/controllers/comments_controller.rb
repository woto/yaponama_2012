# encoding: utf-8
#
class CommentsController < ApplicationController
  respond_to :html, :js

  def new
    @comment = Comment.new
    @comment.parent_id = params[:parent_id]
    respond_with @comment
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    name = current_user.names.where(:name => params[:name], :creation_reason => Rails.configuration.user_name_creation_reason['self']).first
    unless name
      name = current_user.names.build
      name.name = params[:name]
      name.creation_reason = 'comment'
    end
    @comment.creator = current_user

    respond_to do |format|
      debugger
      if @comment.save && name.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js { render "error", :notice => 'a' }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
      format.js
    end
  end

  def comment_params
    params.require(:comment).permit!
  end

end
