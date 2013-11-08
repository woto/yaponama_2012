module ProductsAttributes

  def post_supplier_account_transaction_check user_id, id
    {
     "product" => {
       "product_id"=>"",
       "catalog_number"=>"MR245368",
       "hide_catalog_number"=>"1",
       "brand_attributes"=>{"name"=>"MITSUBISHI", "id"=>"856124188"},
       "short_name"=>"НАСОС ОМЫВАТЕЛЯ",
       "quantity_ordered"=>"4",
       "buy_cost"=>"351.00",
       "sell_cost"=>"392.00",
       "long_name"=>"НАСОС ОМЫВАТЕЛЯ СТЕКЛА, ЛОБОВОГО",
       "quantity_available"=>"2",
       "probability"=>"95",
       "min_days"=>"5",
       "max_days"=>"9",
       "notes"=>"",
       "notes_invisible"=>""},
     "return_path" => '/user',
     "user_id" => user_id,
     "id" => id,
     "commit" => 'x'
   }
  end


  def new_brand
    {
     "catalog_number"=>"new",
     "hide_catalog_number"=>"0",
     "brand_attributes" => { "name" => "new" },
     "short_name"=>"new",
     "quantity_ordered"=>"1",
     "buy_cost"=>"1",
     "sell_cost"=>"1",
     "long_name"=>"new",
     "quantity_available"=>"1",
     "probability"=>"1",
     "min_days"=>"1",
     "max_days"=>"1",
     "notes"=>"new",
     "notes_invisible"=>"new"
    }
  end

end
