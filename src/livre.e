-- Implémentation de la classe IMedia représentant un Livre
indexing
	description:"Implémentation de IMedia pour un Livre"

class LIVRE
inherit IMEDIA

creation {ANY}
	livre

feature {}
	auteurs : ARRAY[STRING]
	editeur : STRING
	type : STRING

feature{ANY}
	livre(iauteurs : ARRAY[STRING]; iediteur, itype, ititre : STRING; iannee, inombre_disponible, inombre_possede : INTEGER) is
	do
		auteurs := iauteurs
		editeur := iediteur
		type := itype
		init(ititre, iannee, inombre_disponible, inombre_possede)
	end

	-- =====================================
	-- Affiche les infos du livre
	-- =====================================
	afficher is
	local
		i : INTEGER
	do
		io.put_string("%N************** LIVRE ******************%N")
			io.put_string("Titre : "+titre + "%N")
			io.put_string("Type : "+type+"%N")
			io.put_string("Auteurs : ")
			from
				i := auteurs.lower
			until
				i > auteurs.upper
			loop
				if(i = auteurs.upper)
				then
					io.put_string(auteurs.item(i) + "%N")
				else
					io.put_string(auteurs.item(i) + ", ")
				end
				i := i + 1
			end
	end

	-- =====================================
	-- Sauvegarde les infos du livre (cr�e la ligne
	-- =====================================
	save : STRING is
	local
		stringsave : STRING
		i : INTEGER
	do
		stringsave := "Livre ; "
      	if(not titre.is_equal(""))
      	then
      		stringsave.append_string("Titre<")
      		stringsave.append_string(titre)
      		stringsave.append_string(">")
      	end
		if(not auteurs.count.is_equal(0))
      	then
     		from
				i := auteurs.lower
			until
				i > auteurs.upper
			loop
				stringsave.append_string(" ; Auteur<")
	      		stringsave.append_string(auteurs.item(i))
	      		stringsave.append_string(">")
				i := i + 1
			end
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
	-- Ajoute un auteur dans la liste des auteurs
	-- =====================================
	add_auteur(auteur : STRING) is
	do
		auteurs.put(auteur, auteurs.count)
	end

	-- =====================================
	-- Récupère un auteur dans la liste des auteurs
	-- =====================================
	get_auteur(rang : INTEGER) : STRING is
	require
		rang >= 0
	do
		Result := auteurs @ rang
	end

	-- =====================================
	-- Renvoie la liste des auteurs
	-- =====================================
	get_auteurs : ARRAY[STRING] is
	do
		Result := auteurs
	end


	-- =====================================
	-- Modifie l'éditeur du livre courant
	-- =====================================
	set_editeur(iediteur : STRING) is
	do
		editeur := iediteur
	end

	-- =====================================
	-- Retourne l'éditeur du livre courant
	-- =====================================
	get_editeur : STRING is
	do
		Result := editeur
	end

	-- =====================================
	-- Retourne le type du livre courant
	-- =====================================
	get_type : STRING is
	do
		Result := type
	end

	-- =====================================
	-- Retourne le type du livre courant
	-- =====================================
	set_type(itype : STRING) is
	do
		type := itype
	end

end
