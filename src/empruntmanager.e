-- Classe représentant le gestionnaire des emprunts

indexing
	description:"Classe de gestion des emprunts"

class EMPRUNTMANAGER

creation {ANY}
	init_emprunt_manager,
	emprunt_manager,
	emprunt_manager_empty

feature {}
	liste_emprunts : ARRAY[EMPRUNT]

feature{ANY}


	-- =====================================
	-- Construit et charge les emprunts
	-- =====================================
	init_emprunt_manager(media_manager_input : MEDIAMANAGER; user_manager_input : USERMANAGER) is
	local
		text_file_read: TEXT_FILE_READ;
		path_emprunts: STRING; i : INTEGER;
		a_emprunt : EMPRUNT;
		contenu_ligne: STRING;
		string_tmp: STRING;
		string_data: STRING;
		media_titre : STRING;
		media_auteur : STRING;
		identifiant_emprunteur : STRING;
		emprunteur : ADHERENT
		media_emprunte : IMEDIA
		date_emprunt : TIME
		date_emprunt_micro : MICROSECOND_TIME
		duree_emprunt : TIME
		nombre_exemplaires : INTEGER
		index : INTEGER;
		index2 : INTEGER;
		trash : BOOLEAN;
		contenu_fichier : ARRAY[STRING];
	do
		--Initialisation des variables nécessaires à l'ouverture du fichier
		path_emprunts := "emprunts.txt"
		create text_file_read.connect_to(path_emprunts)
		create contenu_fichier.with_capacity(56,1)

		--Initialisation des listes d'emprunts
		create liste_emprunts.with_capacity(60,1)

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
			io.put_string("Cannot read file %"" + path_emprunts + "%" in the current working directory.%N")
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
						if string_tmp.has_substring ("DateEmprunt") then
							date_emprunt_micro.set_microsecond(string_data.to_integer)
							date_emprunt := date_emprunt_micro.time
							date_emprunt.update
						elseif string_tmp.has_substring ("DureeEmprunt") then
							trash := duree_emprunt.set(duree_emprunt.year, duree_emprunt.month,string_data.to_integer, duree_emprunt.hour, duree_emprunt.minute, duree_emprunt.second)
						elseif string_tmp.has_substring ("NombreExemplaires") then
							nombre_exemplaires := string_data.to_integer
						elseif string_tmp.has_substring ("Emprunteur") then
							identifiant_emprunteur := string_data
						elseif string_tmp.has_substring ("MediaTitre") then
							media_titre := string_data
						elseif string_tmp.has_substring ("MediaAuteur") then
							media_auteur := string_data
						end
						index := index +1
					end
				end
				if contenu_ligne.has_substring ("Emprunt ; ") then
					emprunteur ?= user_manager_input.rechercher_utilisateur_depuis_identifiant(identifiant_emprunteur)
					media_emprunte := media_manager_input.rechercher_media_depuis_titre_et_auteur(media_titre, media_auteur)
					create a_emprunt.emprunt(emprunteur, media_emprunte, date_emprunt, duree_emprunt, nombre_exemplaires)
					liste_emprunts.add_last(a_emprunt)
				end
				-- Reinitialisation des proprietes communes
				nombre_exemplaires := 0
			else
				io.put_string ("Chaine vide")
			end
			i := i +1
		end
	end

	-- =====================================
	-- Sauvegarde les emprunts
	-- =====================================
	save_to_file is
    local
      output : TEXT_FILE_WRITE
      stringsave : STRING
      j : INTEGER
    do
      create output.connect_to("testemprunts.txt")

      from j := liste_emprunts.lower
      until j > liste_emprunts.upper
      loop
      	stringsave := liste_emprunts.item(j).save
      	output.put_string(stringsave)
        output.put_new_line
        j := j + 1
      end
      output.disconnect

      io.put_string("Sauvegarde Emprunts.")
    end

	-- =====================================
	-- Constructeur
	-- =====================================
	emprunt_manager(input_liste_emprunts : ARRAY[EMPRUNT]) is
	require
		liste_non_vide : input_liste_emprunts.count > 0
	do
		liste_emprunts := input_liste_emprunts
	end

	-- =====================================
	-- Constructeur par défaut
	-- =====================================
	emprunt_manager_empty is
	do
		--Initialisation des listes de emprunts
		create liste_emprunts.with_capacity(60,1)
	end

	-- =====================================
	-- Création d'un emprunt
	-- =====================================
	ajouter_emprunt(input_adherent : ADHERENT; input_media : IMEDIA; input_date_emprunt, input_duree : TIME; input_nombre_exemplaires : INTEGER) is
	require
		adherent_emprunt_ok : input_adherent /= Void and input_adherent.get_nom.count > 0 and input_adherent.get_identifiant.count > 0
		media_emprunt_ok : input_media /= Void and input_media.get_titre.count > 0 and input_media.get_nombre_disponible > 0
		nbre_emprunts_ok : input_media.get_nombre_disponible >= input_nombre_exemplaires
	local
		emprunt : EMPRUNT
	do
		create emprunt.emprunt(input_adherent, input_media, input_date_emprunt, input_duree, input_nombre_exemplaires)
		liste_emprunts.add_last(emprunt)
		input_adherent.ajouter_emprunt(emprunt)
		input_media.set_nombre_disponible(input_media.get_nombre_disponible - input_nombre_exemplaires)
	end

	-- =====================================
	-- Suppression d'un emprunt
	-- =====================================
	supprimer_emprunt(input_adherent : IUTILISATEUR; input_media : IMEDIA) is
	require
		adherent_non_null : input_adherent /= Void
		media_non_null : input_media /= Void
	local
		i : INTEGER
	do
		from
			i:= liste_emprunts.lower
		until
			i > liste_emprunts.upper
		loop
			
			-- En fonction de son type, on ne va pas appeler la même méthode pour l'auteur / réalisateur
			if(liste_emprunts.item(i).get_media.generating_type.is_equal("DVD") and input_media.generating_type.is_equal("DVD"))
			then
				
				if liste_emprunts.item(i).get_media.get_titre.is_equal(input_media.get_titre) and liste_emprunts.item(i).get_adherent.get_identifiant.is_equal(input_adherent.get_identifiant)
				then
					liste_emprunts.item(i).get_media.set_nombre_disponible(input_media.get_nombre_disponible + 1)
					liste_emprunts.remove(i)
				end
				
				
			elseif(liste_emprunts.item(i).get_media.generating_type.is_equal("LIVRE") and input_media.generating_type.is_equal("LIVRE"))
			then

				if liste_emprunts.item(i).get_media.get_titre.is_equal(input_media.get_titre) and liste_emprunts.item(i).get_adherent.get_identifiant.is_equal(input_adherent.get_identifiant)
				then
					liste_emprunts.item(i).get_media.set_nombre_disponible(input_media.get_nombre_disponible + 1)
					liste_emprunts.remove(i)
				end
				
			end
			i := i + 1
		end
	end

	-- =====================================
	-- Récupération des emprunts d'un adhérent
	-- =====================================
	get_emprunts_adherent(identifiant : STRING) : ARRAY[EMPRUNT] is
	require
		identifiant_non_null : identifiant /= Void
		identifiant_non_vide : identifiant.count > 0
	local
		retour : ARRAY[EMPRUNT]
		i : INTEGER
	do
		--Initialisation des listes de médias
		create retour.with_capacity(60,1)
		from
			i:= liste_emprunts.lower
		until
			i > liste_emprunts.upper
		loop
			if(liste_emprunts.item(i).get_adherent.get_identifiant = identifiant)
			then
				retour.add_last(liste_emprunts.item(i))
			end
			i := i + 1
		end
	end

	-- =====================================
	-- Affiche les emprunts
	-- =====================================
	afficher_emprunts is
	local
		i : INTEGER
	do
		from
			i := liste_emprunts.lower
		until
			i > liste_emprunts.upper
		loop
			liste_emprunts.item(i).afficher
			i := i + 1
		end
	end
end
