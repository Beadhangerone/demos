def play?
	exit if $balance <= 0
	print "\"Enter\" to play, \"q\" to quit"
	choose= gets.strip.capitalize

	exit if choose == "Q"
end
module Numbers

	class N1
		def self.choose
			@n1=rand(0..9)
			@n1
		end
	end

	class N2
		def self.choose
			@n2= rand(0..9)
			@n2
		end
	end

	class N3
		def self.choose
			@n3= rand(0..9)
			@n3
		end
	end


end

class Combination
	@prize = nil

	def self.display
		print $nr1
		sleep 0.5
		print $nr2
		sleep 0.5
		puts $nr3
		sleep 0.5
		$combination= "#{$nr1}#{$nr2}#{$nr3}"
	end

	def self.has_combinations?
		if $nr1==$nr2 && $nr2==$nr3
			$prize = 100
			return true

		elsif $nr1 == $nr2
			$prize = 20
			return true
		elsif $nr2 == $nr3
			$prize = 20
			return true
		elsif $nr1 == $nr3
			$prize = 20
			return true
		else
			return false
		end
	end



end

class Balance
	$balance = 100

	def self.operations
		if Combination.has_combinations?
			$balance = $balance+$prize
			puts "You won #{$prize} coins."
		end

		if not Combination.has_combinations?
			$balance = $balance-10
			puts "You lost 10 coins."
		end
	end
end



loop do
puts "Balance: #{$balance}"
play?
$nr1=Numbers::N1.choose
$nr2=Numbers::N2.choose
$nr3=Numbers::N3.choose
Combination.display #combination display
Balance.operations
end
