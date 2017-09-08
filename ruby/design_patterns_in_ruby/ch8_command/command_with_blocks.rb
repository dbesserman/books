class SlickButton
  attr_accessor :command

  def initialize(&block)
    @command = block
  end
  
  def execute
    command.call if command
  end
end

save_button = SlickButton.new do
  # save
end
