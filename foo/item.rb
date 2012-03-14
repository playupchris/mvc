#!/usr/bin/env ruby
require "controller"

if __FILE__ == $0
  item = Controller["foo.item"].new(:foo => "bar")
  puts item
end
