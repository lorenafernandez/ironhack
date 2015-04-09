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
	end

	def read_file
		@file = IO.read(@file)
		@line = 0
		select_line(@line)
	end

	def select_line(line)
		@number_of_lines = @file.split("\n----\n").length
		@selected = @file.split("\n----\n")[@line]
		prepare_to_print
	end

	def prepare_to_print 
		puts length_selected = @selected.length
		free_width = @p_width - length_selected
		@spaces = free_width / 2
		colorize
	end

	def colorize
		array_selected = @selected.split(" ")
		@blue = array_selected[0]
		@black = array_selected[1..@selected.length-1].inject{|sum , x| sum + " " + x }
		print
	end

	def print
		(1..@p_height/2).each do |j|
			puts ""
		end
		puts " " * @spaces + @blue.blue + ' ' + @black
		(1..@p_height/2).each do |j|
			puts ""
		end
		next_step
	end

	def next_step
		puts " > "
		text = gets.chomp
		if text == 'next'
			puts @line = @line + 1
		elsif text == 'previous'
			puts @line = @line - 1
		else
			exit
		end
		is_there_more_lines
	end

	def is_there_more_lines
		if @line < @number_of_lines
			puts "Bien!!"
			select_line(@line)
		end
	end

end

keyNote = KeyNote.new('file.txt')
keyNote.term_size
keyNote.read_file