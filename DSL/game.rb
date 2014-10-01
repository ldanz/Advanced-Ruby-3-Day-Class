i = 1

COMMANDS =[]
Rooms = []
Paths = []

Room = Struct.new(:name, :north, :east, :south, :west) do
  def to_s
    name
  end
end

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
        room = Room.new(gets.chomp)
        puts "You created #{room}"
        Rooms << room
      elsif params[0] == "path"
        print "Enter starting room > "
        room_name = gets.chomp
        starting_room = Rooms.find { |room| room.name == room_name }
        if starting_room.nil?
          puts "No room named #{room_name} exists"
          next
        end

        print "Enter destination room > "
        room_name = gets.chomp
        destination_room = Rooms.find { |room| room.name == room_name }
        if destination_room.nil?
          puts "No room named #{room_name} exists"
          next
        end

        print "Enter direction > "
        direction = gets.chomp.downcase
        unless %w{north south east west}.include? direction
          puts 'You must enter north, south, east, or west'
          next
        end

        if starting_room.send(direction)
          puts "#{starting_room} already has a neighbor to the #{direction}"
          next
        end

        starting_room.send("#{direction}=", destination_room)
        puts "You've added a path from #{starting_room}, heading #{direction}, to #{destination_room}."
      else
        puts "Create expects Room or Path"
      end
    else
      puts 'Invalid command'
  end
end
