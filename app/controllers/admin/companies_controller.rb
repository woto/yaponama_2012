class Admin::CompaniesController < CompaniesController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
