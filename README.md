
# TAG  You're It
##### _Simplifying life for individuals and businesses_

### TAG is a conceptual PASS application

TAG's platform allows registered users to post their immediate needs as tasks in which other users can view and accept. At the same time, TAG grants the ability for users to generate income by accomplishing these tasks.

The landing page displays available task on a map using GoogleMap's api with Javascript. A mouse over pop-up window displays a link for more information or to accept the task.

New users register through a facebook OAuth login or a Sign-Up form. Confirmation e-mail is asynchronously sent in the background using the delayed_jobs gem.

Once registered, a user can list and edit task. Accept task and have access to a TAG users email for quick communication.

Data is stored in a Postgresql database

Bootstrap & Sass are used for quick styling

TAG's [task and go](http://taskandgo.herokuapp.com) demo on heroku has 80% of it's functionality enabled. facebook OAuth is by invitation, please use the Sign-Up form.

A composition change can be seen on TAG's  [Contact](http://taskandgo.herokuapp.com/contact) page. It utilizes a tabel-less model, pastel palette change, adjustments in fonts, and google's reCAPTCHA api for a clean spam-free communication.

Note, please read the authored docs for proper gem integration.
- pg
- devise
- bootstrap-sass
- jquery-turbolinks
- rails_12factor
- geocoder
- recaptcha
- delayed_job_active_record
- omniauth-facebook
- bootstrap3-datetimepicker-rails
- momentjs-rails

TODO
- stripe connect transaction and verification
- push notification between TAG clients
- testing and refactoring
