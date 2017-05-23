=begin
!каждый ход будет добавлен в хеш onboard
!все комбинации будут прописаны в combinations как ключ, и решения данной кобинации как значение
!если в хеше onboard есть та или иная комбинация, ПК принимает решиение в соответствии с значением
!когда ПК заблокировал один ряд, удаляется данная комбинация из combinations, чтобы ПК больше не распознавал ее
!если в хеше нету комбинации, он выбирает любую ячейку
=end
@arrX = []
@arrO = []
@board={
"1" =>    "__|",
"2" =>       "__|",
"3" =>           "__\n",
"4" =>    "__|",
"5" =>        "__|",
"6" =>          "__\n",
"7" =>    "  |",
"8" =>        "  |",
"9" =>           "  \n"
}

@wincomb = [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9'],
	['1', '4', '7'], ['2', '5', '8'], ['3', '6', '9'],
	['1', '5', '9'], ['7', '5', '3']]

@combinations={
["1", "4"] => "7",
["3", "6"] => "9",
["1", "2"] => "3",
["2", "5"] => "8",
["7", "8"] => "9",
["8", "5"] => "2",
["9", "8"] => "7",
["4", "5"] => "6",
["6", "5"] => "4",
["1", "5"] => "9",
["5", "9"] => "1",
["7", "5"] => "3",
["3", "5"] => "7",
["1", "3"] => "2",
["3", "9"] => "6",
["9", "7"] => "8",
["7", "1"] => "4",
["1", "9"] => "5",
["7", "3"] => "5",
}

@onboard={
}

@blocked=[]


def displayboard
	@board.each do |k, v|
		if @onboard.key? k
			@board[k][1]=@onboard[k]
			print v
		else
			print v
		end
	end

end



def hturn
	print "\nMake choice "
		@hfinal_choice=gets.strip.to_s
	while  @onboard.key?"#{@hfinal_choice}"
		puts "You can't take this cell"
		print "Make choice (1-9)"
			@hfinal_choice=gets.strip.to_s
		end
	@onboard ["#{@hfinal_choice}"] = "X"
	@arrX << @hfinal_choice.to_s
	return @hfinal_choice

end


def cturn
first_turn = ["1", "3", "9", "7", "5"]
	@cfinal_choice = nil
	if @arrO.length == 0
		rnd=rand(0..(first_turn.length)-1)
		@cfinal_choice =first_turn[rnd]
		while  @onboard.key?"#{@cfinal_choice}"
			rnd=rand(0..(first_turn.length)-1)
			@cfinal_choice = first_turn[rnd]
		end
	first_turn.delete_at (rnd)
	else @cfinal_choice = nil
	end

	@combinations. each do |k, v|
        	if @cfinal_choice == nil
			if not @onboard[v.to_s] == "X" #закрытие ряда О
				if @arrO.include? (k[0].to_s)
					if @arrO.include? (k[1].to_s)
						@cfinal_choice = v
						break
					end
				end
			else @cfinal_choice = nil
			end
		end
	end

	@combinations. each do |k, v|
		if @cfinal_choice == nil
			if not @onboard[v.to_s] == "O"	#блокировка почти зарытого ряда Х
				if @arrX.include? (k[0].to_s)
					if @arrX.include? (k[1].to_s)
						@cfinal_choice = v
						break
					end
				end
			else @cfinal_choice = nil
			end
		end
	end #Iteration

	if @cfinal_choice == nil
		rnd=rand(0..(first_turn.length)-1)
		@cfinal_choice =first_turn[rnd]
		while  @onboard.key?"#{@cfinal_choice}"
			rnd=rand(0..(first_turn.length)-1)
			@cfinal_choice = first_turn[rnd]
		end
	first_turn.delete_at (rnd)
	end


	@onboard ["#{@cfinal_choice}"] = "O"
	@arrO << @cfinal_choice.to_s
        return @cfinal_choice
end #def cturn

def take_winner
        winner = nil
	 if winner == nil
		@combinations.each do |k,v|
			if @arrX.include? k[0]
				if @arrX.include? k[1]
					if @arrX.include? v
						winner = "X"
						break
					end
				end
			end

			if @arrO.include? k[0]
				if @arrO.include? k[1]
					if @arrO.include? v
						winner = "O"
						break
					end
				end
			else winner = nil
			end
		end
	end

return winner
end


#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
puts "this is a game in tic-tac-toes with your computer. Press enter"
gets
displayboard
loop do
take_winner
	if take_winner == nil
		hturn
		displayboard
	elsif @onboard.length == 9
		print "Round draw!!!"
		gets
		exit
	else
		print "#{take_winner} wins"
		gets
		exit
	end

take_winner
	if take_winner == nil
		cturn
		puts ""
		print "Computer thinks..."
		sleep 2
		print "\r                  "
		print "\n"
		displayboard
	elsif @onboard.length == 9
		print "Round draw!!!"
		gets
		exit
	else
		print "#{take_winner} wins"
		gets
		exit
	end
end
