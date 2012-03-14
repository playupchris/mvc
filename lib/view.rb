require "terminal-table"

module View
  def to_s
    opts = { :title => self.class.name }
    if @model.is_a?(Collection)
      keys = @model.first.model.class.properties
      opts.update(:headings => keys)
      rows = @model.map { |item| keys.map { |k| item.model.send(k) } }
    else
      rows = @model.class.properties.map { |prop| [prop, @model.send(prop)] }
    end
    opts.update(:rows => rows)
    Terminal::Table.new(opts).to_s
  end
end
