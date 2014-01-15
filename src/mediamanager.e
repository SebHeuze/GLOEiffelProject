-- Implémentation de la classe IMedia représentant un Livre
indexing
	description:"Classe de gestion des médias"

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
		auteur : STRING;
		acteurs : ARRAY[STRING];
		realisateur : STRING;
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
		create acteurs.with_capacity(20,1)

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
							auteur := string_data
						elseif string_tmp.has_substring ("Nombre") then
							nombre := string_data.to_integer
						elseif string_tmp.has_substring ("Titre") then
							titre := string_data
						elseif string_tmp.has_substring ("Annee") then
							annee := string_data.to_integer
						elseif string_tmp.has_substring ("Acteur") then
							acteurs.add_last(string_data)
						elseif string_tmp.has_substring ("Realisateur") then
							realisateur := string_data
						elseif string_tmp.has_substring ("Disponible") then
							dispo := string_data.to_integer
						elseif string_tmp.has_substring ("Type") then
							type := string_data
						end
						index := index +1
					end
				end

				if contenu_ligne.has_substring ("Livre ; ") then
					create a_livre.livre(auteur, "", "", titre, 0, dispo,nombre)
					liste_medias.add_last(a_livre)
				end
				if contenu_ligne.has_substring ("DVD ; ") then
					create a_dvd.dvd(realisateur, acteurs, type, titre, annee,dispo, nombre)
					liste_medias.add_last(a_dvd)
					create acteurs.with_capacity(20,1)
				end
				-- Reinitialisation des proprietes communes
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
	-- Sauvegarde les medias
	-- =====================================
	save_to_file is
    local
      output : TEXT_FILE_WRITE
      stringsave : STRING
      j : INTEGER
    do
      create output.connect_to("medias.txt")

      from j := liste_medias.lower
      until j > liste_medias.upper
      loop
      	if(liste_medias.item(j).generating_type.is_equal("LIVRE"))
      	then
      		stringsave := liste_medias.item(j).save
      		output.put_string(stringsave)
      	else
      		stringsave := liste_medias.item(j).save
      		output.put_string(stringsave)
      	end
        output.put_new_line
        j := j + 1
      end
      output.disconnect

      io.put_string("Sauvegarde.")
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
	-- Recherche un média depuis son titre et son auteur (clé unique)
	-- =====================================
	rechercher_media_depuis_titre_et_auteur(titre, auteur : STRING) : IMEDIA is
	require
		titre /= Void
		auteur /= Void
		titre.count > 0
		auteur.count > 0
	local
		i : INTEGER
		auteur_courant_to_upper, titre_courant_to_upper : STRING
		media_courant : IMEDIA
		livre_courant : LIVRE
		dvd_courant : DVD
	do
		from
			i:= liste_medias.lower
		until
			i > liste_medias.upper
		loop
			create titre_courant_to_upper.copy(liste_medias.item(i).get_titre)
			titre_courant_to_upper.to_upper
			titre.to_upper
			if titre_courant_to_upper.has_substring(titre)
			then

				-- Récupération du média courant (on ne sait pas encore de quel type il est)
				media_courant := liste_medias.item(i)

				-- En fonction de son type, on ne va pas appeler la même méthode pour l'auteur / réalisateur
				if(liste_medias.item(i).generating_type.is_equal("DVD"))
				then

					-- Le magnifique down cast Eiffel
					dvd_courant ?= media_courant
					create auteur_courant_to_upper.copy(dvd_courant.get_realisateur)
					auteur_courant_to_upper.to_upper
					auteur.to_upper
					if auteur_courant_to_upper.has_substring(auteur)
					then
						Result := liste_medias.item(i)
					end
				elseif(liste_medias.item(i).generating_type.is_equal("LIVRE"))
				then

					-- S'il est pas beau mon poisson !!
					livre_courant ?= media_courant
					create auteur_courant_to_upper.copy(livre_courant.get_auteur)
					auteur_courant_to_upper.to_upper
					auteur.to_upper
					if auteur_courant_to_upper.has_substring(auteur)
					then
						Result := liste_medias.item(i)
					end
				end
			end
			i := i + 1
		end
	end

	-- =====================================
	-- Création d'un dvd et ajout dans la collection
	-- =====================================
	ajouter_dvd(new_realisateurs : ARRAY[STRING]; new_acteurs : ARRAY[STRING]; new_type : STRING; new_titre : STRING; new_annee, new_nombre_disponible, new_nombre_possede : INTEGER) : DVD is
	require

	local
	do
	end
end
