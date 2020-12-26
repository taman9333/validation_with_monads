# Validation with Monads

So one of the problems when your project get bigger in Ruby on Rails is that you will end up have fat model and that's because of depending on great functionalities that [Active Record](https://guides.rubyonrails.org/active_record_basics.html) give you out of box (validations, callbacks, data access, business logic & ...etc)

In this repo we will depend on [dry validation](https://dry-rb.org/gems/dry-validation/master/) instead of active record validation to split validations from Model. so you will have a validation class which is far
better for composability & separating your code.

UpdateService is a serivce object which you can use to put your business logic instead of adding it also inside model.

Also this repo uses Monads & depends on railway oriented programming for dealing with errors as values and handling those errors concisely.
