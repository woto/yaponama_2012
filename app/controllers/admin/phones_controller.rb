class Admin::PhonesController < PhonesController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
