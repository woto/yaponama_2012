class PaymentsController < ApplicationController

  layout false, only: ['print']

  private

    def set_resource_class
      @resource_class = Payment
    end

    def new_resource
      @resource = Payment.new resource_params

      if @somebody.profiles.any?
        @resource.profile_type = 'old'
      else
        @resource.profile_type = 'new'
      end

      if @somebody.postal_addresses.any?
        @resource.postal_address_type = 'old'
      else
        @resource.postal_address_type = 'new'
      end


      @resource.new_profile = @somebody.profiles.new
      @resource.new_postal_address = @somebody.postal_addresses.new

    end

end
