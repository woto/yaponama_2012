# encoding: utf-8
#
module UserProfileAttributes

  def user_profile_attributes 
    {
      'profile' => {
        'names_attributes' => {
          '0' => { 
            'name' => '1'
          }
        },
        'phones_attributes' => {
          '0' => {
            'value' => '1',
            'mobile' => '0'
          }
        },
        'emails_attributes' => {
          '0' => {
            'value' => 'a@a.ru'
          }
        },
        'passports_attributes' => {
          '0' => {
            'data_rozhdeniya(1i)' => '2001',
            'data_rozhdeniya(2i)' => '1',
            'data_rozhdeniya(3i)' => '1',
            'data_vidachi(1i)' => '2001',
            'data_vidachi(2i)' => '1',
            'data_vidachi(3i)' => '1',
            'gender' => 'male',
            'kod_podrazdeleniya' => '1',
            'mesto_rozhdeniya' => '1',
            'nomer' => '1',
            'passport_vidan' => '1',
            'seriya' => '1'
          }
        },
        'notes' => '1'
      }
    }
  end

end
