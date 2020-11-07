
tests = [
	"uma",
	"tres horas",
	"catorze horas",
	"vinte e uma hora",
	"um",
	"vinte e oito minutos",
	"quarenta e tres",
	"dois minutos",
	"meia",
	"um quarto",
	"tres quartos",
	"dois quartos"	
]

# for each of the motherfucking symbols above
for i, test in zip(range(len(tests)), tests):
	# make a motherfucking list out said symbols
	test_list = list(test.split(" "))
	# and proper motherfucking file name so you can easily idenfity the correct test to run
	test_file_name = "tests/" + "_".join(test_list) + ".txt"

	# create the motherfucking test file
	with open(test_file_name, "w+") as file:

		# iterating the motherfucking symbols and their length
		# write the motherfucking transitions
		for j, sym in zip(range(len(test)), test_list):
			file.write(str(j) + "\t" + str(j + 1) + "\t" + sym + "\t" + sym + "\n")
		
		# and let's not forget the m o t h e r f u c k i n g accepting state
		file.write(str(j + 1))
