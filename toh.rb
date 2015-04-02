require 'pry'

class TowerOfHanoi
	# Set the initial height of the tower
	def initialize(height)
		@height = height
		@board = [[],[],[]]
		1.upto(height) { |i| @board[0].push(i) }
	end

	# Play method
	def play
		puts "This will start the game"
		self.render
		until is_victory? || quit?
			puts "Enter your move:"
			@move = gets.chomp
		end


		# Leave a message when the game ends
		if is_victory?
			puts "You win! Congratulations!"
		else
			puts "Thanks for playing!"
		end
	end

	# Did we win?
	def is_victory?

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
