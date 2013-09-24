class Admin::NamesController < NamesController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
