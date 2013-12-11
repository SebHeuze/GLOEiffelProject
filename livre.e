-- Implémentation de la classe IMedia représentant un Livre
indexing
	description:"Implémentation de IMedia pour un Livre"
	
class LIVRE inherit IMEDIA

creation {ANY}
	livre

feature {}
	auteur : STRING
	editeur : STRING
	type : STRING

feature{ANY}
	livre(iauteur, iediteur, itype, ititre : STRING; iannee, inombre_disponible : INTEGER) is
	do
		auteur := iauteur
		editeur := iediteur
		type := itype
		init(ititre, iannee, inombre_disponible)
	end
	
	-- =====================================
	-- Renvoie l'auteur du livre courant
	-- =====================================
	get_auteur : STRING is
	do
		Result := auteur
	end
	
	-- =====================================
	-- Modifie l'auteur du livre courant
	-- =====================================
	set_auteur(iauteur : STRING) is
	do
		auteur := iauteur
	end
end
