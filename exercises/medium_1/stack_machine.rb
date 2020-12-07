class MinilangError < StandardError; end
class BadCommandError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  VALID_COMMANDS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT).freeze

  def initialize(programs)
    @programs = programs
  end

  def eval
    @register = 0
    @stack = []
    
    @programs.split.each { |program| run(program) }
  rescue MinilangError => error
    puts error.message
  end

  def run(command)
    if VALID_COMMANDS.include?(command)
      send(command.downcase)
    elsif command =~ /[0-9]/
      @register = command.to_i
    else
      raise BadCommandError, "Invalid command: #{command}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Error. Empty stack." if @stack.empty?
    @register = @stack.pop
  end
  
  def add
    @register += pop
  end
  
  def sub
    @register -= pop
  end

  def mult
    @register *= pop
  end

  def div
    @register /= pop
  end
  
  def mod
    @register %= pop
  end

  def print
    puts @register
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)