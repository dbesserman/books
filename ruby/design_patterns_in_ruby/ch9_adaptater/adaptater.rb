class Encrypter
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def encrypt(reader, writer)
    key_index = 0
    while not reader.eof?
      clear_char = reader.getc
      encrypted_char = clear_char ^ key[key_index]
      writer.putc(encrypted_char)
      key_index = (key_index + 1) % key.size
    end
  end
end

reader = File.open('message.txt')
writer = File.open('message.encrypted', 'w')
encrypter = Encrypter.new('my secret key')
encrypter.encrypt(reader, writer)

class StringIOAdaptater
  attr_reader :string, :position

  def initialize(string)
    @string   = string
    @position = 0
  end

  def getc
    if position > string.length
      raise EOFError
    end

    ch = string[position]
    position += 1

    ch
  end

  def eof?
    position >= string.length
  end
end
