class Admin::CarsController < CarsController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
