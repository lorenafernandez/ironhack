require 'pry'
require 'colorize'

require 'terminfo'

#binding.pry

class KeyNote

	def initialize(file)
		@file = file
	end
	
	def term_size
		p = p TermInfo.screen_size
		@p_height = p[0]
		@p_width = p[1]
		self.read_file
	end

	def read_file
		file = IO.read(@file)
		find_mark = file.index('----')
		@selected = file[0..find_mark-1]
		prepare_to_print(@selected)
	end

	def prepare_to_print (selected)
		length_selected = @selected.length
		free_width = @p_width - length_selected
		@spaces = free_width / 2
		colorize(@selected, @spaces)	
	end

	def colorize(selected,spaces)
		array_selected = @selected.split(" ")
		@blue = array_selected[0]
		@black = array_selected[1..@selected.length-1].inject{|sum , x| sum + " " + x }
		print(@spaces,@blue, @black, @p_height)
	end

	def print (blue , black, spaces, p_height)
		(1..@p_height/2).each do |j|
			puts ""
		end
		puts " " * @spaces + @blue.blue + ' ' + @black
		puts " > "
		netx = gets.chomp
	end

end

keyNote = KeyNote.new('file.txt').term_size
