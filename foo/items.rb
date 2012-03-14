#!/usr/bin/env ruby
require "controller"

if __FILE__ == $0
  items = Controller["foo.items"].new(
    [
      { :foo => "bar1" },
      { :foo => "bar2" },
      { :foo => "bar3" }
    ].map { |data| Controller["foo.item"].new(data) }
  )
  puts items
end
