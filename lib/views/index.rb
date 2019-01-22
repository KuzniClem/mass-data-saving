# frozen_string_literal: true

class Index
	def initialize
		puts "La récupération de données vient de commencer. Cela peut durer un moment."
		(1..10).each do |i|
			print "."
			sleep(0.2)
		end
		@scrapped_data = Scrapper.new
		puts "\n\nLa récupération de données a été effectuées avec succès."
		ask_for_format
	end

	private

	def ask_for_format
		puts "Sous quel format souhaitez-vous les stocker ? Taper:\n\n1 pour JSON\n2 pour Google Sheet\n3 pour CSV\n"
		print ">"
		storage_choice_private(gets.chomp)
	end

	def storage_choice_private(choix)
		case choix
		when '1'
			@scrapped_data.save_as_JSON
			puts "Le fichier cities.json a été créé dans ../db"
		when '2'
			@scrapped_data.save_as_spreadsheet
			puts "Le fichier cities a été créé dans Google Sheets"
		when '3'
			@scrapped_data.save_as_csv
			puts "Le fichier cities.csv a été créé dans ../db"
		else
			puts "Ce choix ne correspond à aucun format proposé."
			ask_for_format
		end
		Done.new
	end
end
