  KINECTED NOTES  
-================-

Chat:       Firebase with Angular. 

  Resources: 
  - http://websocket-rails.github.io/
  - http://stackoverflow.com/questions/8405457/rails-threaded-private-messaging (associations)
  - http://railscasts.com/episodes/163-self-referential-association?view=asciicast
  - http://stackoverflow.com/questions/6559164/rails-associations-has-many-through-but-same-model (self-referential associations)

Conditional association with a lambda: 
  has_many :projects, through: :assignments, if: -> (o){o.type == 'contractor'}