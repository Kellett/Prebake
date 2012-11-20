results = './results'

sites = []

File.open("obtrusive.txt") do |f|

	site = {:address => "", :selector => ""}

	f.each_line do |line|
		unless line.match(/^!/) || line.match(/^\[/) || line.match(/^\n/)
			line = line.partition("##") 
			site[:address] = line.first
			site[:selector] = line.last.chomp
			# p site
			sites.push(site)
			site = {:address => "", :selector => ""}
		end
	end

end

sites.each do |site|
	puts "Testing #{site[:address]}..."
	system("capturejs --uri http://#{site[:address]} --selector '#{site[:selector]}' --output #{results}/#{site[:address]}.png --viewportsize 960x300")
end
