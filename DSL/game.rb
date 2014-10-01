i = 1
COMMANDS =[]
Rooms = []
Paths = []

loop do
  print "#{i}> "
  i+=1
  raw_input = gets
  if raw_input.nil?
    puts
    break
  else
    input = raw_input.chomp
  end
  COMMANDS << input
  command, *params = input.split /\s/
  case command
    when /\Ahelp\z/i
      puts "+++"
      puts "open #loads a file"
      puts "exit #will exit"
      puts "do <ruby code> #evals <ruby code>"
      puts "anything else doesn't work"
      puts "+++"
    when /\Aopen\z/i
      puts "should open #{params.first}"
    when /\Ado\z/i
      puts(eval(*params.join))
    when /\Aexit\z/i
      break
    when /\Alast\z/i
      puts COMMANDS[-2]
    when /\Acreate\z/i
      if params[0] == "room"
        print "Enter Room > "
        room = gets
        puts "You created #{room}"
        Rooms << room
      elsif params[0] == "path"
        print "Enter Path > "
        path = gets
        puts "You created #{path}"
        Paths << path
      else
        puts "Create expects Room or Path"
      end
    else
      puts 'Invalid command'
  end
end
