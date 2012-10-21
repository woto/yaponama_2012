class Email < ActiveRecord::Base
  include PingCallback
  belongs_to :email_address
  attr_accessible :bcc, :bcc_addrs, :body, :cc, :cc_addrs, :classes, :content_types, :date, :from, :from_addrs, :html_part, :in_reply_to, :is_multipart, :message_id, :name, :parts_length, :resent_bcc, :resent_cc, :return_path, :subject, :text_part, :to, :to_addrs, :user_id, :email_address
  has_many :attachments
  has_many :requests
end
