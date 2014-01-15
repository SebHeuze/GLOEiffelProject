-- Implémentation de la classe IMedia représentant un DVD
indexing
	description:"Implémentation de IMedia pour un DVD"

class DVD

inherit IMEDIA

creation {ANY}
	dvd


feature {}
	realisateur : STRING
	acteurs : ARRAY[STRING]
	type : STRING

feature {ANY}

	dvd(new_realisateur : STRING; new_acteurs : ARRAY[STRING]; new_type : STRING; new_titre : STRING; new_annee, new_nombre_disponible, new_nombre_possede : INTEGER) is
	do
		realisateur := new_realisateur
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
		io.put_string("Réalisateur : "+realisateur+"%N")
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
	-- Retourne la string de sauvegarde d'un DVD
	-- =====================================
	save : STRING is
	local
		stringsave : STRING
		i : INTEGER
	do
		stringsave := "DVD ; "
		if(not titre.is_equal(""))
      	then
      		stringsave.append_string("Titre<")
      		stringsave.append_string(titre)
      		stringsave.append_string(">")
      	end
      	if(not annee.is_equal(0))
      	then
      		stringsave.append_string(" ; Annee<")
      		stringsave.append_string(annee.to_string)
      		stringsave.append_string(">")
      	end
		stringsave.append_string(" ; Realisateur<")
  		stringsave.append_string(realisateur)
  		stringsave.append_string(">")
      	if(not acteurs.count.is_equal(0))
      	then
     		from
				i := acteurs.lower
			until
				i > acteurs.upper
			loop
				stringsave.append_string(" ; Acteur<")
	      		stringsave.append_string(acteurs.item(i))
	      		stringsave.append_string(">")
				i := i + 1
			end
      	end
      	if(not type.is_equal(""))
      	then
	      	stringsave.append_string(" ; Type<")
	      	stringsave.append_string(type)
	      	stringsave.append_string(">")
      	end
      	stringsave.append_string(" ; Nombre<")
      	stringsave.append_string(get_nombre_possedes.to_string)
      	stringsave.append_string(">")
      	stringsave.append_string(" ; Disponible<")
      	stringsave.append_string(get_nombre_disponible.to_string)
      	stringsave.append_string(">")
		Result := stringsave
	end

	-- =====================================
	-- Ajoute un realisateur dans la liste des realisateurs
	-- =====================================
	add_realisateur(irealisateur : STRING) is
	do
		realisateur := irealisateur
	end

	-- =====================================
	-- RÃ©cupÃšre un realisateur dans la liste des realisateurs
	-- =====================================
	get_realisateur : STRING is
	do
		Result := realisateur
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
