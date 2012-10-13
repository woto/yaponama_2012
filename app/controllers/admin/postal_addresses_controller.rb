class Admin::PostalAddressesController < Admin::ApplicationController
  # GET /postal_addresses
  # GET /postal_addresses.json
  def index
    @postal_addresses = PostalAddress.order("#{sort_column} #{sort_direction}")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @postal_addresses }
    end
  end

  # GET /postal_addresses/1
  # GET /postal_addresses/1.json
  def show
    @postal_address = PostalAddress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @postal_address }
    end
  end

  # GET /postal_addresses/new
  # GET /postal_addresses/new.json
  def new
    @postal_address = PostalAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @postal_address }
    end
  end

  # GET /postal_addresses/1/edit
  def edit
    @postal_address = PostalAddress.find(params[:id])
  end

  # POST /postal_addresses
  # POST /postal_addresses.json
  def create
    @postal_address = PostalAddress.new(params[:postal_address])

    respond_to do |format|
      if @postal_address.save
        format.html { redirect_to admin_postal_address_path(@postal_address), :notice => 'PostalAddress was successfully created.' }
        format.json { render :json => @postal_address, :status => :created, :location => @postal_address }
      else
        format.html { render :action => "new" }
        format.json { render :json => @postal_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /postal_addresses/1
  # PUT /postal_addresses/1.json
  def update
    @postal_address = PostalAddress.find(params[:id])

    respond_to do |format|
      if @postal_address.update_attributes(params[:postal_address])
        format.html { redirect_to admin_postal_address_path(@postal_address), :notice => 'PostalAddress was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @postal_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /postal_addresses/1
  # DELETE /postal_addresses/1.json
  def destroy
    @postal_address = PostalAddress.find(params[:id])
    @postal_address.destroy

    respond_to do |format|
      format.html { redirect_to admin_postal_addresses_url }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    PostalAddress.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

end
