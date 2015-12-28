class Task < ActiveRecord::Base
  belongs_to :user
  # after_initialize do
  #   if new_record?
  #     :init
  #   end
  # end
  # after_initialize :init, unless: :persisted? # This worked for
  # listing but removed other unowned data from the same status fields
   after_initialize :init, :if => :new_record? # think it failed same as above
  # Rails 4 Way pg 279, paragraph prior to code example
  # This was failing due to task_status not within white-listed strong params in task_controller




# setting up the after_initialize default as shown in Rails 4 way pg 279 and this SO answer.
# we want a status for all tasks and we want them to default to available on creation
# http://stackoverflow.com/questions/328525/how-can-i-set-default-values-in-activerecord
# doesn't overide initilize which would require the call to super in the self
# such that it would be self.super.task_status ||= "available"
private
   def init
     self.accepted_by_user_id  ||= 0 #will set the default value only if it's nil
    #  self.task_status  ||= "available" #will set the default value only if it's nil
    #  self.address ||= build_address #let's you set a default association
   end
end
