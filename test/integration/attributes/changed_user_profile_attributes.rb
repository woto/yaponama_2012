module ChangedUserProfileAttributes

  def changed_user_profile_attributes 
    {
      'profile' => {
        'names_attributes' => {
          '0' => {
            'name' => '2',
            'id' => Name.last.id
          }
        },
        'phones_attributes' => {
          '0' => {
            'phone' => '2222222222',
            'phone_type' => 'mobile_russia',
            'id' => Phone.last.id
          }
        },
        'email_addresses_attributes' => {
          '0' => {
            'email_address' => 'q@q.ru',
            'id' => EmailAddress.last.id
          }
        },
        'passports_attributes' => {
          '0' => {
            'data_rozhdeniya(1i)' => '2002',
            'data_rozhdeniya(2i)' => '2',
            'data_rozhdeniya(3i)' => '2',
            'data_vidachi(1i)' => '2002',
            'data_vidachi(2i)' => '2',
            'data_vidachi(3i)' => '2',
            'gender' => 'female',
            'kod_podrazdeleniya' => '2',
            'mesto_rozhdeniya' => '2',
            'nomer' => '2',
            'passport_vidan' => '2',
            'seriya' => '2',
            'id' => Passport.last.id
          }
        }
      },
      'notes' => '2'
    }
  end

end
