module RegistersAttributes

  def empty_fields_with_phone
    {
      "with" => "phone", 
      "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "phones_attributes" => {
              "0" => {
                "value" => "", "hidden_recreate" => "1"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }
  end

  def empty_fields_with_email
    {
      "with" => "email", 
      "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "emails_attributes" => {
              "0" => {
                "value" => "", "hidden_recreate" => "1"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }
  end

  def wrong_phone_format
    {
      "with" => "phone", 
      "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "phones_attributes" => {
              "0" => {
                "value" => "123", "hidden_recreate" => "1"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }
  end

  def wrong_email_format
    {
      "with" => "email", 
      "user" => {
        "profiles_attributes" => {
          "0" => {
            "names_attributes" => {
              "0" => {
                "name" => "", "hidden_recreate" => "1"
              }
            },
            "emails_attributes" => {
              "0" => {
                "value" => "123", "hidden_recreate" => "1"
              }
            }
          }
        },
        "password"=>"",
        "password_confirmation"=>""
      }
    }
  end

  def already_confirmed_phone
    {
      "with" => "phone", 
      "user" => 
      {
        "profiles_attributes" =>
        {
          "0" =>
          {
            "names_attributes" => {
              "0" => {
                "name" => "Otto", "hidden_recreate" => "1"
              }
            },
           "phones_attributes" => {
              "0" => {
                "value" => "+7 (555) 555-55-55", "hidden_recreate" => "1"
              }
            }
          }
        },
        "password" => "555555",
        "password_confirmation" => "555555"
      }
    }
  end

  def not_confirmed_phone
    {
      "with" => "phone", 
      "user" => 
      {
        "profiles_attributes" =>
        {
          "0" =>
          {
            "names_attributes" => {
              "0" => {
                "name" => "Otto", "hidden_recreate" => "1"
              }
            },
            "phones_attributes" => {
              "0" => {
                "value" => "+7 (111) 111-11-11", "hidden_recreate" => "1"
              }
            }
          }
        },
        "password" => "1111111111",
        "password_confirmation" => "1111111111"
      }
    }
  end

  def already_confirmed_email
    {
      "with" => "email", 
      "user" => 
      {
        "profiles_attributes"=>
        {
          "0"=>
          {
            "names_attributes" => {
              "0" => {
                "name" => "Otto", "hidden_recreate" => "1"
              }
            },
            "emails_attributes" => {
              "0" => {
                "value" => "fake@example.com", "hidden_recreate"=>"1"
              }
            }
          }
        },
        "password"=>"555555",
        "password_confirmation"=>"555555"
      }
    }
  end

  def not_confirmed_email
    {
      "with" => "email", 
      "user" => 
      {
        "profiles_attributes"=>
        {
          "0"=>
          {
            "names_attributes" => {
              "0" => {
                "name" => "Otto", "hidden_recreate"=>"1"
              }
            },
            "emails_attributes" => {
              "0" => {
                "value" => "foo@example.com", "hidden_recreate"=>"1"
              }
            }
          }
        },
        "password"=>"555555",
        "password_confirmation"=>"555555"
      }
    }
  end


end
