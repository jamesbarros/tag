class Message # Tabel-less model demo murdo.ch
  include ActiveModel::Model #BFF of ActiveRecord, has an initialize method
                            # similar to the one we lost by removing ActiveRecord
   # define attributes on message class
   attr_accessor :name
   attr_accessor :email # and below a regex to get proper email strings from mail_form github dox
   validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
   attr_accessor :subject
   attr_accessor :content

  validates :name, :email, :subject, :content, presence: true # verify state of message objects

  # def headers
  #   {
  #     :subject => "My Contact Form",
  #     :from => %("#{name}" <#{email}>)
  #   }
  # end


end
