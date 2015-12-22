class Task < ActiveRecord::Base
  belongs_to :user
  after_initialize :init

# setting up the after_initialize default as shown in this SO answer
# we want a status for all tasks and we want them to default to available on creation
# http://stackoverflow.com/questions/328525/how-can-i-set-default-values-in-activerecord
# doesn't overide initilize which would require the call to super in the self
# such that it would be self.super.task_status ||= "available"
private
   def init
     self.task_status  ||= "available" #will set the default value only if it's nil
     #self.address ||= build_address #let's you set a default association
   end
end
