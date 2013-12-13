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
			text_file_read: TEXT_FILE_READ; path_media: STRING; path_utilisateurs: STRING; i : INTEGER;
			a_dvd : DVD;
			a_livre : LIVRE;
			a_user : UTILISATEUR;
			tmp_string: STRING;
			tmp_string2: STRING;
			string_data: STRING;
			titre: STRING;
			type: STRING;
			nom: STRING;
			prenom: STRING;
			identifiant: STRING;
			is_admin: BOOLEAN;
			auteurs : ARRAY[STRING];
			acteurs : ARRAY[STRING];
			realisateurs : ARRAY[STRING];
			nombre : INTEGER;
			annee : INTEGER;
			index : INTEGER;
			index2 : INTEGER;
			contenu_fichier : ARRAY[STRING];
		do
			io.put_string("Initialisation::Début.%N")
			path_media := "medias.txt"
			path_utilisateurs := "utilisateurs.txt"
			create text_file_read.connect_to(path_media)
			create contenu_fichier.with_capacity(56,1)
			create auteurs.with_capacity(20,1)
			create acteurs.with_capacity(20,1)
			create liste_dvd.with_capacity(20,1)
			create liste_livres.with_capacity(20,1)
			create liste_utilisateurs.with_capacity(20,1)
			create realisateurs.with_capacity(20,1)
			is_admin:=False;

			if text_file_read.is_connected then
				from
					text_file_read.read_line
				until
					text_file_read.end_of_input
				loop
					tmp_string := ""
					tmp_string.copy (text_file_read.last_string)
					contenu_fichier.add_last(tmp_string)
					text_file_read.read_line
				end
				text_file_read.disconnect
			else
				io.put_string("Cannot read file %"" + path_media + "%" in the current working directory.%N")
			end

			from
				i := contenu_fichier.lower
			until
				i > contenu_fichier.upper
			loop
				if contenu_fichier.item(i) /= Void then
					tmp_string := contenu_fichier.item(i)
					index := 1;
					if tmp_string.has_substring ("Livre ; ") then
						from
						until index = 0
						loop
							index := tmp_string.index_of (';', index)
							index2 := tmp_string.index_of (';', index+1)

							if index /= 0 then
								if index2 = 0 then
									index2 := tmp_string.count + 2
								end

								tmp_string2 := tmp_string.substring (index + 2, index2-2)

								string_data := tmp_string2.substring (tmp_string2.index_of ('<', 1)+1, tmp_string2.index_of ('>', 1)-1);
								if tmp_string2.has_substring ("Titre") then
									titre := string_data
								end
								if tmp_string2.has_substring ("Auteur") then
									auteurs.add_last(string_data)
								end
								if tmp_string2.has_substring ("Nombre") then
									nombre := string_data.to_integer
								end
								index := index +1
							end
							create a_livre.livre(auteurs, "", "", titre, 0, nombre)
							liste_livres.add_last(a_livre);
						end
					end
					if tmp_string.has_substring ("DVD ; ") then
						from
						until index = 0
						loop
							index := tmp_string.index_of (';', index)
							index2 := tmp_string.index_of (';', index+1)

							if index /= 0 then
								if index2 = 0 then
									index2 := tmp_string.count + 2
								end

								tmp_string2 := tmp_string.substring (index + 2, index2-2)

								string_data := tmp_string2.substring (tmp_string2.index_of ('<', 1)+1, tmp_string2.index_of ('>', 1)-1);
								if tmp_string2.has_substring ("Titre") then
									titre := string_data
								end
								if tmp_string2.has_substring ("Annee") then
									annee := string_data.to_integer
								end
								if tmp_string2.has_substring ("Acteur") then
									acteurs.add_last(string_data)
								end
								if tmp_string2.has_substring ("Realisateur") then
									realisateurs.add_last(string_data)
								end
								if tmp_string2.has_substring ("Nombre") then
									nombre := string_data.to_integer
								end
								if tmp_string2.has_substring ("Type") then
									type := string_data
								end
								index := index +1
							end
						end
						create a_dvd.dvd(realisateurs, acteurs, type, titre, annee, nombre)
						liste_dvd.add_last(a_dvd);
					end
				else
					io.put_string ("Chaine vide")
				end
				i := i +1
			end

			create text_file_read.connect_to(path_utilisateurs)

			if text_file_read.is_connected then
				from
					text_file_read.read_line
				until
					text_file_read.end_of_input
				loop
					tmp_string := ""
					tmp_string.copy (text_file_read.last_string)
					contenu_fichier.add_last(tmp_string)
					text_file_read.read_line
				end
				text_file_read.disconnect
			else
				io.put_string("Cannot read file %"" + path_utilisateurs + "%" in the current working directory.%N")
			end

			from
				i := contenu_fichier.lower
			until
				i > contenu_fichier.upper
			loop
				if contenu_fichier.item(i) /= Void then
					tmp_string := contenu_fichier.item(i)
					index := 1;

					from
					until index = 0
					loop
						index := tmp_string.index_of (';', index)
						index2 := tmp_string.index_of (';', index+1)

						if index /= 0 then
							if index2 = 0 then
								index2 := tmp_string.count + 2
							end

							tmp_string2 := tmp_string.substring (index + 2, index2-2)

							string_data := tmp_string2.substring (tmp_string2.index_of ('<', 1)+1, tmp_string2.index_of ('>', 1)-1);
							if tmp_string2.has_substring ("Nom") then
								nom := string_data
							end
							if tmp_string2.has_substring ("Prenom") then
								prenom := string_data
							end
							if tmp_string2.has_substring ("Identifiant") then
								identifiant := string_data
							end
							if tmp_string2.has_substring ("Admin") then
								if string_data = "OUI" then
									is_admin := True
								else
									is_admin := False
								end
							end
							index := index +1
						end
						create a_user.utilisateur(nom, prenom, identifiant, is_admin)
						liste_utilisateurs.add_last(a_user);
					end
				else
					io.put_string ("Chaine vide")
				end
				i := i +1
			end
		end

end -- class HELLO_WORLD