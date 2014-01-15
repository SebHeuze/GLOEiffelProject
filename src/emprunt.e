-- =====================================
-- Représentation d'un emprunt
-- =====================================
indexing
	description:"Emprunt représenté par un emprunteur, un média emprunté, une date et une durée"
class EMPRUNT

creation{ANY}
	emprunt

feature {}
	emprunteur : ADHERENT
	media : IMEDIA
	date_emprunt : TIME
	duree_emprunt : TIME
	nombre_exemplaires : INTEGER

feature{ANY}

	emprunt(new_emprunteur : ADHERENT; new_media : IMEDIA; new_date_emprunt, new_duree_emprunt : TIME; new_nombre_exemplaire : INTEGER) is
	do
		emprunteur := new_emprunteur
		media := new_media
		date_emprunt := new_date_emprunt
		duree_emprunt := new_duree_emprunt
		nombre_exemplaires := new_nombre_exemplaire
	end

	-- =====================================
	-- Sauvegarde les infos de l'emprunt
	-- =====================================
	save : STRING is
	local
		stringsave : STRING
	do
		stringsave := "Emprunt ; "
      	stringsave.append_string("MediaTitre<")
      	stringsave.append_string(media.get_titre)
      	stringsave.append_string(">")
		stringsave.append_string(" ; MediaAuteur<")
  		--stringsave.append_string(media.get_auteur)
  		stringsave.append_string(">")
      	stringsave.append_string(" ; Emprunteur<")
      	stringsave.append_string(emprunteur.get_identifiant)
      	stringsave.append_string(">")
      	Result := stringsave
	end

	-- =====================================
	-- Retourne true si emprunt en retard
	-- =====================================
	estenretard : BOOLEAN is
	local
		current_time : MICROSECOND_TIME
		date_emprunt_micro : MICROSECOND_TIME
		duree_emprunt_micro : MICROSECOND_TIME
	do
		-- Récupération des temps
		date_emprunt_micro := date_emprunt.to_microsecond_time
		duree_emprunt_micro := duree_emprunt.to_microsecond_time

		-- Ajout de la durée d'emprunt à la date d'emprunt
		duree_emprunt_micro.add_microsecond(date_emprunt_micro.microsecond)

		-- Si la date courante est supérieure à la date d'emprunt + la durée d'emprunt c'est un retard
		if(duree_emprunt_micro.compare(current_time) = -1) then
			Result := True
		end
	end

	-- =====================================
	-- Retourne l'adhérent de l'emprunt
	-- =====================================
	get_adherent : ADHERENT is
	do
		Result := emprunteur
	end

	-- =====================================
	-- Retourne le média de l'emprunt
	-- =====================================
	get_media : IMEDIA is
	do
		Result := media
	end

	-- =====================================
	-- Retourne le média de l'emprunt
	-- =====================================
	afficher is
	local
		mois, annee : INTEGER
	do
		mois := duree_emprunt.month- date_emprunt.month
		annee := duree_emprunt.year - duree_emprunt.year
		io.put_string("%N************** EMPRUNT ******************%N")
		emprunteur.afficher
		media.afficher
		io.put_string("%N****** Date emprunt ******%N"+date_emprunt.day.to_string+"/"+date_emprunt.month.to_string+"/"+date_emprunt.year.to_string+"%N")
		io.put_string("%N***** Durée emprunt ******%N"+duree_emprunt.day.to_string+" jours, "+mois.to_string+" mois, "+annee.to_string+" années%N")
		io.put_string("%N***** Retard ******%N"+estenretard.to_string)
	end
end
