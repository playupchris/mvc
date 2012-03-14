require "view"

Dir[File.expand_path('../../**/{models,views}/*.rb', __FILE__)].each { |f| require f }

class Controller
  include View

  attr_reader :model

  class << self
    attr_writer :scope

    def [](name)
      scope = name.split(".").map(&:capitalize)
      top_mod = scope[0..-2].inject(Object) { |mod, x|
        begin
          mod::const_get(x)
        rescue NameError
          mod::const_set(x, Module.new)
        end
      }
      begin
        top_mod::const_get(scope.last)
      rescue NameError
        Class::new(self).tap { |klass| top_mod::const_set(scope.last, klass) }
      end
    end
  end

  def scope
    @scope ||= self.class.name.split("::").map(&:to_sym)
  end

  def get_class(mod, scope)
    class_scope = scope.dup.insert(-2, mod)
    class_scope.inject(Module) { |m, name| m.const_get(name) }
  end

  def initialize(data)
    @model = get_class(:Models, scope).new(data)
    @model.extend(get_class(:Views, scope))
  end
end

