class Admin::EmailAddressesController < Admin::ApplicationController
  # GET /email_address
  # GET /email_address.json
  def index
    @email_addresses = EmailAddress.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @email_addresses }
    end
  end

  # GET /email_address/1
  # GET /email_address/1.json
  def show
    @email_address = EmailAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @email_address }
    end
  end

  # GET /email_address/new
  # GET /email_address/new.json
  def new
    @email_address = EmailAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @email_address }
    end
  end

  # GET /email_address/1/edit
  def edit
    @email_address = EmailAddress.find(params[:id])
  end

  # POST /email_address
  # POST /email_address.json
  def create
    @email_address = EmailAddress.new(params[:email_address])

    respond_to do |format|
      if @email_address.save
        format.html { redirect_to admin_email_address_path(@email_address), :notice => 'EmailAddress was successfully created.' }
        format.json { render :json => @email_address, :status => :created, :location => @email_address }
      else
        format.html { render :action => "new" }
        format.json { render :json => @email_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /email_address/1
  # PUT /email_address/1.json
  def update
    @email_address = EmailAddress.find(params[:id])

    respond_to do |format|
      if @email_address.update_attributes(params[:email_address])
        format.html { redirect_to admin_email_address_path(@email_address), :notice => 'EmailAddress was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @email_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /email_address/1
  # DELETE /email_address/1.json
  def destroy
    @email_address = EmailAddress.find(params[:id])
    @email_address.destroy

    respond_to do |format|
      format.html { redirect_to admin_email_addresses_url }
      format.json { head :no_content }
    end
  end
end
