class Email < ActiveRecord::Base
  attr_accessible :from, :from_addrs, :in_reply_to, :return_path, :subject, :html_part, :text_part, :to_addrs
  belongs_to :user
end
