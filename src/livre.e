-- ImplÃ©mentation de la classe IMedia reprÃ©sentant un Livre
indexing
	description:"ImplÃ©mentation de IMedia pour un Livre"

class LIVRE
inherit IMEDIA

creation {ANY}
	livre

feature {}
	auteur : STRING
	editeur : STRING
	type : STRING

feature{ANY}
	livre(iauteur : STRING; iediteur, itype, ititre : STRING; iannee, inombre_disponible, inombre_possede : INTEGER) is
	do
		auteur := iauteur
		editeur := iediteur
		type := itype
		init(ititre, iannee, inombre_disponible, inombre_possede)
	end

	-- =====================================
	-- Affiche les infos du livre
	-- =====================================
	afficher is
	local
	do
		io.put_string("%N************** LIVRE ******************%N")
		io.put_string("Titre : "+titre + "%N")
		io.put_string("Type : "+type+"%N")
		io.put_string("Auteur : "+auteur+"%N")
		io.put_string("Année : "+annee.to_string+"%N")
		io.put_string("Nombre possédé : "+nombre_possedes.to_string+"%N")
		io.put_string("Nombre disponible : "+nombre_disponible.to_string+"%N")
	end

	-- =====================================
	-- Sauvegarde les infos du livre (crée la ligne
	-- =====================================
	save : STRING is
	local
		stringsave : STRING
	do
		stringsave := "Livre ; "
      	if(not titre.is_equal(""))
      	then
      		stringsave.append_string("Titre<")
      		stringsave.append_string(titre)
      		stringsave.append_string(">")
      	end
		stringsave.append_string(" ; Auteur<")
  		stringsave.append_string(auteur)
  		stringsave.append_string(">")
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
	set_auteur(iauteur : STRING) is
	do
		auteur := iauteur
	end

	-- =====================================
	-- Renvoie la liste des auteurs
	-- =====================================
	get_auteur : STRING is
	do
		Result := auteur
	end


	-- =====================================
	-- Modifie l'Ã©diteur du livre courant
	-- =====================================
	set_editeur(iediteur : STRING) is
	do
		editeur := iediteur
	end

	-- =====================================
	-- Retourne l'Ã©diteur du livre courant
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
