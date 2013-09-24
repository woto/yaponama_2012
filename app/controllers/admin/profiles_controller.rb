class Admin::ProfilesController < ProfilesController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
