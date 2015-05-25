require 'test_helper'

class TalksControllerTest < ActionController::TestCase

  test 'Проверяем, что не произошел редирект' do
    xhr :post, :create, { 
      "talk" => {
        "somebody_attributes" => {
          "profile_attributes" => {
            "names_attributes" => {
              "0" => {
                "name" => "jafu39vnemg832uhg0poau4bbmdi"
              }
            },
            "emails_attributes" => {
              "0" => {
                "value" => "jkh03adf@kjaw908ufjfdgbwqpfugvnbf.ru"
              }
            }
          }
        },
        "text" => "slfdgkjhje4hsdbgiuqu3h4rfjhbsfd89yasf"
      }
    }
    assert_response 302 
  end
end

