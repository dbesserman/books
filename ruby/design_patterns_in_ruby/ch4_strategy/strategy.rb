class Formatter
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title     = 'Monthly report'
    @text      = ['Things are going', 'really, really well']
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

HTTPFormatter = lambda do |context|
  puts "<html>"
  puts "  <head>"
  puts "    <title>#{context.title}</title>"
  puts "  </head>"
  puts "  <body>"
  text.each do |line|
    puts "    <p>#{context.line}</o>"
  end
  puts "  </body>"
  puts "</html>"
end

PlainTextFormatter = lambda do |context|
  puts "***** #{context.title} *****"
  context.text.each do |line|
    puts line
  end
end
