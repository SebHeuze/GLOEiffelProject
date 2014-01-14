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
	require
		new_duree_emprunt.to_microsecond_time.microsecond > 0
	do
		emprunteur := new_emprunteur
		media := new_media
		date_emprunt := new_date_emprunt
		duree_emprunt := new_date_emprunt
		nombre_exemplaires := new_nombre_exemplaire
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
		create current_time
		date_emprunt_micro := date_emprunt.to_microsecond_time
		duree_emprunt_micro := duree_emprunt.to_microsecond_time
		
		-- Ajout de la durée d'emprunt à la date d'emprunt
		duree_emprunt_micro.add_microsecond(date_emprunt_micro.microsecond)
		if(duree_emprunt_micro > current_time) then
			Result := True
		else
			Result := False
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
end

