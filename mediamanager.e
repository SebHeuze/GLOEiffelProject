-- ImplÃ©mentation de la classe IMedia reprÃ©sentant un Livre
indexing
	description:"ImplÃ©mentation de IMedia pour un Livre"

class MEDIAMANAGER

creation {ANY}
	init_media_manager

feature {}
	liste_medias : ARRAY[IMEDIA]

feature{ANY}
	init_media_manager is
	local
		text_file_read: TEXT_FILE_READ;
		path_media: STRING; i : INTEGER;
		a_dvd : DVD;
		a_livre : LIVRE;
		contenu_ligne: STRING;
		string_tmp: STRING;
		string_data: STRING;
		titre: STRING;
		type: STRING;
		dispo: INTEGER;
		auteurs : ARRAY[STRING];
		acteurs : ARRAY[STRING];
		realisateurs : ARRAY[STRING];
		nombre : INTEGER;
		annee : INTEGER;
		index : INTEGER;
		index2 : INTEGER;
		contenu_fichier : ARRAY[STRING];
	do
		--Initialisation des variables nécessaires à l'ouverture du fichier
		path_media := "medias.txt"
		create text_file_read.connect_to(path_media)
		create contenu_fichier.with_capacity(56,1)

		--Initialisation des listes de médias
		create liste_medias.with_capacity(60,1)

		--Initialisation des variables temporaires
		create auteurs.with_capacity(20,1)
		create acteurs.with_capacity(20,1)
		create realisateurs.with_capacity(20,1)

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
			io.put_string("Cannot read file %"" + path_media + "%" in the current working directory.%N")
		end

		--Parcours de chaque ligne du fichier
		from
			i := contenu_fichier.lower
		until
			i > contenu_fichier.upper
		loop
			if contenu_fichier.item(i) /= Void then
				--On récupère le contenu de la ligne
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
						if string_tmp.has_substring ("Titre") then
							titre := string_data
						elseif string_tmp.has_substring ("Auteur") then
							auteurs.add_last(string_data)
						elseif string_tmp.has_substring ("Nombre") then
							nombre := string_data.to_integer
						elseif string_tmp.has_substring ("Titre") then
							titre := string_data
						elseif string_tmp.has_substring ("Annee") then
							annee := string_data.to_integer
						elseif string_tmp.has_substring ("Acteur") then
							acteurs.add_last(string_data)
						elseif string_tmp.has_substring ("Realisateur") then
							realisateurs.add_last(string_data)
						elseif string_tmp.has_substring ("Nombre") then
							nombre := string_data.to_integer
						elseif string_tmp.has_substring ("Type") then
							type := string_data
						end
						index := index +1
					end
				end

				if contenu_ligne.has_substring ("Livre ; ") then
					create a_livre.livre(auteurs, "", "", titre, 0, nombre, dispo)
					liste_medias.add_last(a_livre)
					create auteurs.with_capacity(20,1)
				end
				if contenu_ligne.has_substring ("DVD ; ") then
					create a_dvd.dvd(realisateurs, acteurs, type, titre, annee, nombre, dispo)
					liste_medias.add_last(a_dvd)
					create acteurs.with_capacity(20,1)
					create realisateurs.with_capacity(20,1)
				end
				
				-- Réinitialisation des propriétés communes
				create titre.make_empty
				create type.make_empty
				nombre := 0
				dispo := 0
				annee := 0
			else
				io.put_string ("Chaine vide")
			end
			i := i +1
		end
	end

	-- =====================================
	-- affiche les livres
	-- =====================================
	afficher_livres is
	local
		i : INTEGER
	do
		from
			i := liste_medias.lower
		until
			i > liste_medias.upper
		loop
			if liste_medias.item(i).generating_type.is_equal("LIVRE")
			then
				liste_medias.item(i).afficher
			end
			i := i +1
		end
	end

	-- =====================================
	-- affiche les dvd
	-- =====================================
	afficher_dvd is
	local
		i : INTEGER
	do
		from
			i := liste_medias.lower
		until
			i > liste_medias.upper
		loop
			if liste_medias.item(i).generating_type.is_equal("DVD")
			then
				liste_medias.item(i).afficher
			end
			i := i + 1
		end
	end
	
	-- =====================================
	-- Recherche un média depuis son titre (recherche de la chaîne demandée dans le titre)
	-- =====================================
	rechercher_media_depuis_titre(titre : STRING) : IMEDIA is
	local
		i : INTEGER
	do
		from
			i:= liste_medias.lower
		until
			i > liste_medias.upper
		loop
			if liste_medias.item(i).get_titre.has_substring(titre)
			then
				Result := liste_medias.item(i)
			end
			i := i + 1
		end
	end
end
