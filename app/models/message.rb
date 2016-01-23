class Message # Tabel-less model demo murdo.ch
  include ActiveModel::Model #BFF of ActiveRecord, has an initialize method
                            # similar to the one we lost by removing ActiveRecord
  attr_accessor :name, :email, :subject, :content # define attributes on message class
  validates :name, :email, :subject, :content, presence: true # verify state of message objects
end
