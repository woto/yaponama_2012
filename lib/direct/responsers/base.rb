class Direct::Responsers::Base
  def parse(response)
    @response = JSON.parse(response)
    if @response['error_code'].present?
      puts @response['error_code']
      puts @response['error_str']
      puts @response['error_detail']
      binding.pry
    end
  end
end

