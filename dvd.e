-- Implémentation de la classe IMedia représentant un DVD
indexing
	description:"Implémentation de IMedia pour un DVD"

class DVD inherit IMEDIA
	
creation {ANY}
	dvd

feature {}
	realisateur : STRING
	acteurs : ARRAY[STRING]
	type : STRING
	
feature {ANY}

	dvd(new_realisateur : STRING; new_acteurs : ARRAY[STRING]; new_type : STRING; new_titre : STRING; new_annee, new_nombre_disponible : INTEGER) is
	do
		realisateur := new_realisateur
		acteurs := new_acteurs
		type := new_type
		init(new_titre, new_annee, new_nombre_disponible)
	end
	
	-- =====================================
	-- Renvoie le réalisateur du DVD courant
	-- =====================================
	get_realisateur : STRING is
	do
		Result := realisateur
	end
	
	-- =====================================
	-- Modifie le réalisateur du DVD courant
	-- =====================================
	set_realisateur(new_realisateur : STRING) is
	do
		titre := new_realisateur
	end
	
	-- =====================================
	-- Ajoute un acteur dans la liste des acteurs
	-- =====================================
	add_acteur(acteur : STRING) is
	do
		acteurs.put(acteur, acteurs.count)
	end
	
	-- =====================================
	-- Récupère un acteur dans la liste des acteurs
	-- =====================================
	get_acteur(rang : INTEGER) : STRING is
	require
		rang >= 0
	do
		Result := acteurs @ rang
	end
	
	-- =====================================
	-- Renvoie la liste des acteurs
	-- =====================================
	get_acteurs : ARRAY[STRING] is
	do
		Result := acteurs
	end
	
	-- =====================================
	-- Modifie le type du DVD courant
	-- =====================================
	set_type(new_type : STRING) is
	do
		type := new_type
	end
	
	-- =====================================
	-- Renvoie le type du DVD courant
	-- =====================================
	get_type :STRING is
	do
		Result := type
	end
end
