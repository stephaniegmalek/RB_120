=begin
# ----- Algorithm -----
# 1. Check length of text
#    - if > 76 characters
#      - wrap text to as many lines as needed
#        1. create wrapped text array
#        2. create index variable set to 0
#        3. loop through input text until we've gone thru full text length
#           - slice out input text thats 76 characters long and add to array
#           - increment index by 76
#       4. return wrapped text array

#   - if < 76 characters
#     - do nothing to text

# 2. determine borders for box
#    - if length of text > 76
#      - horizontal line is '+' + '-' * 76 + 2 + '+'
#      - empty line is '|' + ' ' * 76 + 2 + '|'
#    - if length of text < 76
#      - horizontal line is '+' + '-' * text length + 2 + '+'
#      - empty line is '|' + ' ' * text length + 2 + '|'


# 3. print out full box
#    - check text length
#    - determine borders for box
#    - print borders 
#    - print message text
#       - iterate thru wrapped text array
#       - add '| ' before each line of text and ' |' after and print

=end

class Banner
  # TEXT_WIDTH = 76
  
  def initialize(message, text_width=76)
    @text_width = text_width
    if message.size > @text_width
      @message = wrapped_text(message)
      @wrapped = true
    else
      @message = message
      @wrapped = false
    end
  end
  
  def wrapped_text(message)
    text_array = []
    idx = 0
    while idx < message.length
      text_array << message[idx, @text_width]
      idx += @text_width
    end
    text_array
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  # private
  
  def horizontal_rule
    @wrapped == true ? "+-#{'-' * @text_width}-+" : "+-#{'-' * @message.size}-+"
  end
  
  def empty_line
    @wrapped == true ? "| #{' ' * @text_width} |" : "| #{' ' * @message.size} |"
  end
  
  def message_line
    if @wrapped == true
      @message.map { |line| "| #{line.center(@text_width, ' ')} |" } 
    else
      "| #{@message} |"
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner

banner1 = Banner.new('')
puts banner1

quote = "To be, or not to be, that is the question: Whether 'tis nobler in the mind to suffer The slings and arrows of outrageous fortune, Or to take arms against a sea of troubles And by opposing end them."
banner3 = Banner.new(quote, 55)
puts banner3
# p banner3.message_line



