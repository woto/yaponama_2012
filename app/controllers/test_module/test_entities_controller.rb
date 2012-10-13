class TestModule::TestEntitiesController < ApplicationController

  # GET /test_module/test_entities
  # GET /test_module/test_entities.json
  def index
    @test_module_test_entities = TestModule::TestEntity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @test_module_test_entities }
    end
  end

  # GET /test_module/test_entities/1
  # GET /test_module/test_entities/1.json
  def show
    @test_module_test_entity = TestModule::TestEntity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @test_module_test_entity }
    end
  end

  # GET /test_module/test_entities/new
  # GET /test_module/test_entities/new.json
  def new
    @test_module_test_entity = TestModule::TestEntity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @test_module_test_entity }
    end
  end

  # GET /test_module/test_entities/1/edit
  def edit
    @test_module_test_entity = TestModule::TestEntity.find(params[:id])
  end

  # POST /test_module/test_entities
  # POST /test_module/test_entities.json
  def create
    @test_module_test_entity = TestModule::TestEntity.new(params[:test_module_test_entity])

    respond_to do |format|
      if @test_module_test_entity.save
        format.html { redirect_to @test_module_test_entity, :notice => 'Test entity was successfully created.' }
        format.json { render :json => @test_module_test_entity, :status => :created, :location => @test_module_test_entity }
      else
        format.html { render :action => "new" }
        format.json { render :json => @test_module_test_entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /test_module/test_entities/1
  # PUT /test_module/test_entities/1.json
  def update
    @test_module_test_entity = TestModule::TestEntity.find(params[:id])

    respond_to do |format|
      if @test_module_test_entity.update_attributes(params[:test_module_test_entity])
        format.html { redirect_to @test_module_test_entity, :notice => 'Test entity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @test_module_test_entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /test_module/test_entities/1
  # DELETE /test_module/test_entities/1.json
  def destroy
    @test_module_test_entity = TestModule::TestEntity.find(params[:id])
    @test_module_test_entity.destroy

    respond_to do |format|
      format.html { redirect_to test_module_test_entities_url }
      format.json { head :no_content }
    end
  end
end
