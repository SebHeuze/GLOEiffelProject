-- Implémentation de la classe IMedia représentant un DVD
indexing
	description:"Implémentation de IMedia pour un DVD"

class DVD

inherit IMEDIA
	redefine
		afficher
    end
creation {ANY}
	dvd


feature {}
	realisateurs : ARRAY[STRING]
	acteurs : ARRAY[STRING]
	type : STRING

feature {ANY}

	dvd(new_realisateurs : ARRAY[STRING]; new_acteurs : ARRAY[STRING]; new_type : STRING; new_titre : STRING; new_annee, new_nombre_disponible, new_nombre_possede : INTEGER) is
	do
		realisateurs := new_realisateurs
		acteurs := new_acteurs
		type := new_type
		init(new_titre, new_annee, new_nombre_disponible, new_nombre_possede)
	end

	-- =====================================
	-- Affiche les infos du dvd
	-- =====================================
	afficher is
	local
		i : INTEGER
	do
		io.put_string("%N************** DVD ******************%N")
		io.put_string("Titre : "+titre + "%N")
		io.put_string("Type : "+type+"%N")
		io.put_string("Acteurs : ")
		from
			i := acteurs.lower
		until
			i > acteurs.upper
		loop
			if(i = acteurs.upper)
			then
				io.put_string(acteurs.item(i) + "%N")
			else
				io.put_string(acteurs.item(i) + ", ")
			end
			i := i + 1
		end
	end

	-- =====================================
	-- Ajoute un realisateur dans la liste des realisateurs
	-- =====================================
	add_realisateur(realisateur : STRING) is
	do
		realisateurs.put(realisateur, realisateurs.count)
	end

	-- =====================================
	-- RÃ©cupÃšre un realisateur dans la liste des realisateurs
	-- =====================================
	get_realisateur(rang : INTEGER) : STRING is
	require
		rang >= 0
	do
		Result := realisateurs @ rang
	end

	-- =====================================
	-- Renvoie la liste des réalisateurs
	-- =====================================
	get_realisateurs : ARRAY[STRING] is
	do
		Result := realisateurs
	end


	-- =====================================
	-- Ajoute un acteur dans la liste des acteurs
	-- =====================================
	add_acteur(acteur : STRING) is
	do
		acteurs.put(acteur, acteurs.count)
	end

	-- =====================================
	-- RÃ©cupÃšre un acteur dans la liste des acteurs
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
