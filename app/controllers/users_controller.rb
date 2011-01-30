#
#
#
class UsersController < ApplicationController
 
  #
  # GET /users
  # GET /users.xml
  #
  def index
    @users = User.all(:order => "nick, id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  
  #
  # GET /users/1
  # GET /users/1.xml
  #
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  
  #
  # GET /users/new
  # GET /users/new.xml
  #
  def new
  end

  
  #
  # GET /users/1/edit
  #
  def edit
    @user = User.find(params[:id])
  end

  
  #
  # POST /users
  # POST /users.xml
  #
  def create
  end

  
  #
  # PUT /users/1
  # PUT /users/1.xml
  #
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      @user.email       = params[:user][:email]
      @user.nick        = params[:user][:nick]
      @user.email_alert = params[:user][:email_alert]
      @user.estime      = params[:user][:estime]
      @user.eetime      = params[:user][:eetime]
      @user.sms_alert   = params[:user][:sms_alert]
      @user.sms_address = params[:user][:sms_address]
      @user.sstime      = params[:user][:sstime]
      @user.setime      = params[:user][:setime]
      @user.weekend     = params[:user][:weekend]

      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => "User was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  #
  # DELETE /users/1
  # DELETE /users/1.xml
  #
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
end # of class

