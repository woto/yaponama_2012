class Deliveries::Place::PlaceUploader < ApplicationUploader

  version :thumb do
    process :resize_to_fit => [110, 110]
  end

end
