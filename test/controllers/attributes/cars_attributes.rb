# encoding: utf-8
#
module CarsAttributes

  def new_car
    {
    "vin_or_frame"=>"frame",
    "vin"=>"",
    "frame"=>"1234",
    "brand_attributes"=>{"name"=>"New brand"},
    "model_attributes"=>{"name"=>"New model"},
    "generation_attributes"=>{"name"=>"New generation"},
    "modification_attributes"=>{"name"=>"New modification"},
    "god"=>"",
    "period"=>"",
    "dvigatel"=>"",
    "tip"=>"",
    "moschnost"=>"",
    "privod"=>"",
    "tip_kuzova"=>"",
    "kpp"=>"",
    "kod_kuzova"=>"",
    "kod_dvigatelya"=>"",
    "rinok"=>"",
    "komplektaciya"=>"",
    "dverey"=>"",
    "rul"=>"",
    "car_number"=>"",
    "notes"=>"",
    "notes_invisible"=>""
    }
  end

  def update_empty
    {"vin_or_frame"=>"frame",
     "vin"=>"",
     "frame"=>"",
     "brand_attributes"=>{"name"=>""},
     "model_attributes"=>{"name"=>""},
     "generation_attributes"=>{"name"=>""},
     "modification_attributes"=>{"name"=>""},
     "god"=>"",
     "period"=>"",
     "dvigatel"=>"",
     "tip"=>"",
     "moschnost"=>"",
     "privod"=>"",
     "tip_kuzova"=>"",
     "kpp"=>"",
     "kod_kuzova"=>"",
     "kod_dvigatelya"=>"",
     "rinok"=>"",
     "komplektaciya"=>"",
     "dverey"=>"",
     "rul"=>"",
     "car_number"=>"",
     "notes"=>""}
  end

end
