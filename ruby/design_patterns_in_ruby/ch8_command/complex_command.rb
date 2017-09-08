class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute
  end
end

class CreateFile < Command
  attr_reader :path, :contents

  def initialize(path, contents)
    super "Create file: #{path}"

    @path     = path
    @contents = contents
  end

  def execute
    f = File.open(path, "w")

    f.write contents
    f.close
  end
end

class DeleteFile < Command
  attr_reader :path

  def initialize(path)
    super "Delete file #{path}"
    @path = path
  end

  def execute
    File.delete(path)
  end
end
