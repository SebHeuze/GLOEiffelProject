-- Classe représentant le gestionnaire des emprunts

indexing
	description:"Classe de gestion des emprunts"

class EMPRUNTMANAGER

creation {ANY}
	init_emprunt_manager

feature {}
	liste_emprunts : ARRAY[EMPRUNT]

feature{ANY}

	-- =====================================
	-- Constructeur vide
	-- =====================================
	init_emprunt_manager is
	do
	end
end
