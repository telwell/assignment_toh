class TowerOfHanoi
	# Set the initial height of the tower
	def initialize(height)
		@height = height
		@board = [[],[],[]]
		1.upto(height) { |i| @board[0].push(i) }
	end

	# Play method
	def play
		# Start the error message off as nothing
		error_message = nil

		# Initiate move counter
		total_moves = 0
		puts "Let the game begin!!!\nEnter the column you want to move from\nthen the column you want to move to.\nComma separated like: _,_\nEnjoy!\n\n"
		until is_victory?
			self.render
			# Display error message if there is one
			if error_message
				puts "#{error_message}"
			else
				puts "Enter your move:"
			end

			# Get move from user
			@move = gets.chomp

			# Quit the game if user inputs Quit or q
			if quit?
				break
			end

			# Take the input and converting it from a 
			# string to an array. 
			@move = @move.split(",").map { |s| s.to_i }

			if valid_input?
				@move_from, @move_to = @move[0]-1, @move[1]-1
				if valid_move?
					temp = @board[@move_from].shift
					@board[@move_to].unshift(temp)
					error_message = nil
					total_moves += 1
				else
					error_message = "Oops! That's an illegal move. Try again!"
					redo
				end
			else
				error_message = "Invalid input, please enter in the form of _,_ and ensure\nyou're only using numbers between 1-3!"
				redo
			end
		end

		# Leave a message when the game ends
		self.render
		puts "You win! Congratulations!\nIt only took you #{total_moves} moves!"
	end

	# Check to see if the input itself is in
	# a proper format.
	def valid_input?
		if @move.length == 2
			@move.each do |input|
				if input.nil? || input < 1 || input > 3
					return false
				end
			end
		else
			return false
		end
		return true
	end

	# Check to see if the move is valid
	def valid_move?
		# Now let's make sure all of the moves are valid.
		# I'll do this by seeing if the sorted version of each
		# column equals the @board version.
		temp_board = Marshal.load(Marshal.dump(@board))
		temp = temp_board[@move_from].shift
		temp_board[@move_to].unshift(temp)

		temp_board.each do |column|
			if column.sort != column
				return false
			end
		end
		# If they all pass, we're good!
		return true
	end

	# Did we win?
	def is_victory?
		if @board[2].length == @height
			true
		else
			false
		end
	end

	# Did the user quit?
	def quit? 
		if @move == "quit" || @move == "q"
			true
		end
	end

	# Render will display the visual output of the tower
	# It will be represented as a nested array with board[0] being the 
	# left-most peg and board[2] being the right-most peg.
	def render
		# binding.pry
		# First let's create an output buffer. This will be 
		# where all of our output lines are stored.
		output_buffer = ""

		# The outer part of the loop will loop the @height of the board.
		@height.downto(1) do |row|

			# The inner loop will loop through the number of columns there are
			# which will always be 3.
			0.upto(2) do |column|
				# I want to use another temporary buffer which will only 
				# send to the output_buffer when it reaches the height 
				# (which is also the max width) + 1.
				temp_buffer = ""

				# We're only going to add o's if there s number on the board.
				if @board[column][-row]
					@board[column][-row].times {temp_buffer << "o"}
				end

				# Either way, add _'s until we're at the right length.
				until temp_buffer.length == @height+1
					temp_buffer << "_"
				end

				# Add a space between the columns then push everything to the 
				# main output buffer.
				if column == 2
					output_buffer << temp_buffer
				else
					output_buffer << temp_buffer + " "
				end
			end

			# Don't forget to add a new line after the last column
			output_buffer << "\n"
		end

		# Now let's add the footer to the output.
		1.upto(3) do |column|
			temp_buffer = ""
			temp_buffer << column.to_s
			until temp_buffer.length == @height+1
				temp_buffer << " "
			end
			if column == 3
				output_buffer << temp_buffer + "\n\n"
			else
				output_buffer << temp_buffer + " "
			end
		end

		# Finally, print the output_buffer
		print output_buffer
	end
end
