class ProfilesController < ProfileablesController

  def new
    super
    @resource.names.new
    @resource.phones.new(hide_remove_button_on_first_on_new: true, mobile: true)
  end

  private

  def set_preferable_columns
    super
    @grid.cached_names_visible = '1'
    @grid.cached_phones_visible = '1'
  end

end
