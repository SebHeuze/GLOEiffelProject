class APPLICATION
--
-- The "Hello World" example.
--
-- To compile type command: se c hello_world
--
-- Then, run the generated executable file named "a.out" or "hello_world.exe"
-- depending of your favorite operating system / C-compiler.
--
-- To compile an optimized version type : se c hello_world -boost -O2
--

creation {ANY}
	main

feature {}
	liste_dvd : ARRAY[DVD]
	liste_livres : ARRAY[LIVRE]
	liste_utilisateurs : ARRAY[UTILISATEUR]

feature {ANY}
	main is
		do
			io.put_string("Main.%N")
			initialisation
		end

	initialisation is
		local
			text_file_read: TEXT_FILE_READ; path: STRING; i : INTEGER;
			tmp_var: STRING;
			contenu_fichier : ARRAY[STRING]
		do
			io.put_string("Initialisation::Début.%N")
			path := "medias.txt"
			create text_file_read.connect_to(path)
			create contenu_fichier.with_capacity(56,1)
			if text_file_read.is_connected then
				from
					text_file_read.read_character
				until
					text_file_read.end_of_input
				loop
					tmp_var := ""
					tmp_var.copy (text_file_read.last_string)
					contenu_fichier.add_last(tmp_var)
					text_file_read.read_line
				end
				text_file_read.disconnect
			else
				io.put_string("Cannot read file %"" + path + "%" in the current working directory.%N")
			end
			
			from
				i := contenu_fichier.lower
			until
				i >= contenu_fichier.upper
			loop
				io.put_string(contenu_fichier.item(i))
				i := i +1
			end
		end

end -- class HELLO_WORLD
