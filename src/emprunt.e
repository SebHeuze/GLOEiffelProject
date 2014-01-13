-- =====================================
-- Représentation d'un emprunt
-- =====================================
class EMPRUNT

creation{ANY}
	emprunt

feature {}
	emprunteur : ADHERENT
	media : IMEDIA
	date_emprunt : TIME
	duree_emprunt : TIME

feature{ANY}

	emprunt(new_emprunteur : ADHERENT; new_media : IMEDIA; new_date_emprunt, new_duree_emprunt : TIME) is
	do
		emprunteur := new_emprunteur
		media := new_media
		date_emprunt := new_date_emprunt
		duree_emprunt := new_date_emprunt
	end

	-- =====================================
	-- compare deux utilisateurs
	-- =====================================
	--is_equal(utilisateur2 : ADHERENT):BOOLEAN is
	--do
	--	Result := (identifiant.is_equal(utilisateur2.identifiant) and password.is_equal(utilisateur2.password))
	--end
	
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
end

