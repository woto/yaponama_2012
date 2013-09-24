class Admin::PassportsController < PassportsController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
