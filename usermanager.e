-- Implémentation de la classe IMedia représentant un Livre
indexing
	description:"Implémentation de IMedia pour un Livre"

class USERMANAGER

creation {ANY}
	init_user_manager

feature {}
	liste_utilisateurs : ARRAY[IUTILISATEUR]

feature{ANY}
	init_user_manager is
	local
		text_file_read: TEXT_FILE_READ;
		path_utilisateurs: STRING; i : INTEGER;
		a_documentaliste : DOCUMENTALISTE;
		a_adherent : ADHERENT;
		contenu_ligne: STRING;
		string_tmp: STRING;
		string_data: STRING;
		nom: STRING;
		prenom: STRING;
		age : INTEGER;
		adresse : STRING;
		identifiant: STRING;
		index : INTEGER;
		index2 : INTEGER;
		contenu_fichier : ARRAY[STRING];
	do
		--Initialisation des variables n�cessaires � l'ouverture du fichier
		path_utilisateurs := "utilisateurs.txt"
		create text_file_read.connect_to(path_utilisateurs)
		create contenu_fichier.with_capacity(56,1)

		--Initialisation des listes de m�dias
		create liste_utilisateurs.with_capacity(60,1)

		--Ouverture du fichier
		if text_file_read.is_connected then
			from
				text_file_read.read_line
			until
				text_file_read.end_of_input
			loop
				contenu_ligne := ""
				contenu_ligne.copy (text_file_read.last_string)
				contenu_fichier.add_last(contenu_ligne)
				text_file_read.read_line
			end
			text_file_read.disconnect
		else
			io.put_string("Cannot read file %"" + path_utilisateurs + "%" in the current working directory.%N")
		end

		--Parcours de chaque ligne du fichier
		from
			i := contenu_fichier.lower
		until
			i > contenu_fichier.upper
		loop
			if contenu_fichier.item(i) /= Void then
				--On r�cup�re le contenu de la ligne
				contenu_ligne := contenu_fichier.item(i)
				index := 1;
				from
				until index = 0
				loop
					index := contenu_ligne.index_of (';', index)
					index2 := contenu_ligne.index_of (';', index+1)
					if index /= 0 then
						if index2 = 0 then
							index2 := contenu_ligne.count + 2
						end

						string_tmp := contenu_ligne.substring (index + 2, index2-2)

						string_data := string_tmp.substring (string_tmp.index_of ('<', 1)+1, string_tmp.index_of ('>', 1)-1);
						if string_tmp.has_substring ("Nom") then
							nom := string_data
						end
						if string_tmp.has_substring ("Prenom") then
							prenom := string_data
						end
						if string_tmp.has_substring ("Identifiant") then
							identifiant := string_data
						end
						if string_tmp.has_substring ("Adresse") then
							adresse := string_data
						end
						if string_tmp.has_substring ("Age") then
							age := string_data.to_integer
						end
						index := index +1
					end

				end

				if contenu_ligne.has_substring ("Documentaliste ; ") then
					create a_documentaliste.documentaliste(nom, prenom, adresse, identifiant, age)
					liste_utilisateurs.add_last(a_documentaliste)
				end
				if contenu_ligne.has_substring ("Adherent ; ") then
					create a_adherent.adherent(nom, prenom, adresse, identifiant, age)
					liste_utilisateurs.add_last(a_adherent);
				end

			else
				io.put_string ("Chaine vide")
			end
			i := i +1
		end
	end


end
