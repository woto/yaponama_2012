class Admin::PostalAddressesController < PostalAddressesController
  include Admin::Admined
  include Admin::ProfileablesConcern
end
