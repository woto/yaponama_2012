class Admin::SuppliersController < Admin::ApplicationController
  # GET /admin/suppliers
  # GET /admin/suppliers.json
  def index
    @suppliers = Supplier.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suppliers }
    end
  end

  # GET /admin/suppliers/1
  # GET /admin/suppliers/1.json
  def show
    @supplier = Supplier.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supplier }
    end
  end

  # GET /admin/suppliers/new
  # GET /admin/suppliers/new.json
  def new
    @supplier = Supplier.new

    if @supplier.account.blank?
      @supplier.account = Account.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplier }
    end
  end

  # GET /admin/suppliers/1/edit
  def edit
    @supplier = Supplier.find(params[:id])
  end

  # POST /admin/suppliers
  # POST /admin/suppliers.json
  def create
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to admin_supplier_path(@supplier), notice: 'Supplier was successfully created.' }
        format.json { render json: @supplier, status: :created, location: @supplier }
      else
        format.html { render action: "new" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/suppliers/1
  # PUT /admin/suppliers/1.json
  def update
    @supplier = Supplier.find(params[:id])

    respond_to do |format|
      if @supplier.update_attributes(supplier_params)
        format.html { redirect_to admin_supplier_path(@supplier), notice: 'Supplier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/suppliers/1
  # DELETE /admin/suppliers/1.json
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to admin_suppliers_url }
      format.json { head :no_content }
    end
  end

  def supplier_params
    params.require(:supplier).permit!
  end

end
