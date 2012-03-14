module Foo::Views::Item
  def self.extended(base)
    base.class.class_eval do
      property :bar
    end
  end

  def foo
    super.upcase
  end

  def bar
    "|"
  end
end
