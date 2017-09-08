class CompositeCommand < Command
  attr_reader :commands

  def initialize
    @commands = []
  end

  def add_command(cmd)
    commands << cmd
  end

  def execute
    commands.each(&:execute)
  end

  def description
    description = ''
    commands.each { |cmd| description += cmd.description + '\n' }
  end
end

###

cmd.execute
