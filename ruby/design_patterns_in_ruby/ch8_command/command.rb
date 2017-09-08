class SlickButton
  attr_accessor :command

  def initialize(command)
    @command = command
  end
  
  def execute
    command.execute if command
  end
end

class SaveCommand
  def execute
    # saves the document
  end
end

save_button = SlickButton.new(SaveCommand.new)
