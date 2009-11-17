# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RandomChildExtension < Radiant::Extension
  version "1.0"
  description "Adds tags for randomizing the children sort."
  url "http://github.com/acrookston/random_child"

  def activate
    Page.send :include, RandomChild
  end
  
  def deactivate
  end
  
end
