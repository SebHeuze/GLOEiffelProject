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
