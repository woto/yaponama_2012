class Admin::EmailsController < EmailsController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
