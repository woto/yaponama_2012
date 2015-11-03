class Admin::Guess::CarForm
  include ActiveModel
  include ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Dirty

  attr_accessor :input
  attr_accessor :results

  validates :input, presence: true

  def initialize(params={})
    self.input = params[:input]
  end

  def call
    if valid?
      @results = Car.find_by_sql(
        "SELECT similarity(CONCAT(brands.name, ' ', models.name, ' ', generations.name, ' ', modifications.name), '#{input}') AS similarity,
            brands.id brand_id,
            models.id model_id,
            generations.id generation_id,
            modifications.id modification_id
        FROM brands
        LEFT
              JOIN models ON models.brand_id = brands.id
        LEFT
              JOIN generations ON generations.model_id = models.id
        LEFT
              JOIN modifications ON modifications.generation_id = generations.id
        WHERE brands.is_brand = 't'
        ORDER BY similarity DESC LIMIT 10;".squish)
      true
    end
  end

  def persisted?
    false
  end

end

