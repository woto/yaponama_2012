# encoding: utf-8
#
module ProfilesAttributes

  def avtorif_new_profile(somebody_id)
    { "profile"=>{"names_attributes"=>{"0"=>{"surname"=>"фамилия", "name"=>"имя", "patronymic"=>"отчество", "notes"=>"", "notes_invisible"=>"", "hidden_recreate"=>"1"}}, "phones_attributes"=>{"0"=>{"mobile"=>"0", "value"=>"телефон", "hide_remove_button_on_first_on_new"=>"true", "hidden_recreate"=>"1", "notes"=>"", "notes_invisible"=>"", "confirmed"=>"0", "confirmation_datetime(3i)"=>"27", "confirmation_datetime(2i)"=>"10", "confirmation_datetime(1i)"=>"2013"}}, "emails_attributes"=>{"1382875829779"=>{"_destroy"=>"false", "value"=>"fake@mail.ru", "notes"=>"", "notes_invisible"=>"", "confirmed"=>"0", "confirmation_datetime(3i)"=>"27", "confirmation_datetime(2i)"=>"10", "confirmation_datetime(1i)"=>"2013", "hidden_recreate"=>"1"}}, "passports_attributes"=>{"1382875837399"=>{"_destroy"=>"false", "seriya"=>"серия", "nomer"=>"номер", "passport_vidan"=>"паспорт выдан", "data_vidachi(3i)"=>"1", "data_vidachi(2i)"=>"1", "data_vidachi(1i)"=>"1913", "kod_podrazdeleniya"=>"код подразделения", "gender"=>"male", "data_rozhdeniya(3i)"=>"1", "data_rozhdeniya(2i)"=>"1", "data_rozhdeniya(1i)"=>"1913", "mesto_rozhdeniya"=>"место рождения", "notes"=>"", "notes_invisible"=>"", "hidden_recreate"=>"1"}}, "notes"=>"", "notes_invisible"=>""},"supplier_id"=>somebody_id }
  end

  def mile_update_not_main_profile(somebody_id, profile_id, name_id, phone_id)
    {
      "supplier_id"=> somebody_id, "id"=>profile_id, "profile"=>{"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"5", "patronymic"=>"", "notes"=>"", "notes_invisible"=>"", "hidden_recreate"=>"1", "id"=>name_id}}, "phones_attributes"=>{"0"=>{"_destroy"=>"false", "mobile"=>"0", "value"=>"5", "hide_remove_button_on_first_on_new"=>"false", "hidden_recreate"=>"1", "notes"=>"", "notes_invisible"=>"", "confirmed"=>"0", "confirmation_datetime(3i)"=>"27", "confirmation_datetime(2i)"=>"10", "confirmation_datetime(1i)"=>"2013", "id"=>phone_id}}, "notes"=>"", "notes_invisible"=>""} 
    }
  end

  def mile_update_main_profile(somebody_id, profile_id, name_id, phone_id)
    { 
      "supplier_id"=> somebody_id, "id"=>profile_id, "profile"=>{"names_attributes"=>{"0"=>{"surname"=>"", "name"=>"5", "patronymic"=>"", "notes"=>"", "notes_invisible"=>"", "hidden_recreate"=>"1", "id"=>name_id}}, "phones_attributes"=>{"0"=>{"_destroy"=>"false", "mobile"=>"0", "value"=>"5", "hide_remove_button_on_first_on_new"=>"false", "hidden_recreate"=>"1", "notes"=>"", "notes_invisible"=>"", "confirmed"=>"0", "confirmation_datetime(3i)"=>"27", "confirmation_datetime(2i)"=>"10", "confirmation_datetime(1i)"=>"2013", "id"=>phone_id}}, "notes"=>"", "notes_invisible"=>""} 
    }
  end

end
