-- Classe représentant le gestionnaire des emprunts

indexing
	description:"Classe de gestion des emprunts"

class EMPRUNTMANAGER

creation {ANY}
	init_emprunt_manager,
	init_emprunt_manager_empty

feature {}
	liste_emprunts : ARRAY[EMPRUNT]

feature{ANY}

	-- =====================================
	-- Constructeur
	-- =====================================
	init_emprunt_manager(input_liste_emprunts : ARRAY[EMPRUNT]) is
	require
		liste_non_vide : input_liste_emprunts.count > 0
	do
		liste_emprunts := input_liste_emprunts
	end
	
	-- =====================================
	-- Constructeur par défaut
	-- =====================================
	init_emprunt_manager_empty is
	do
		--Initialisation des listes de médias
		create liste_emprunts.with_capacity(60,1)
	end
	
	-- =====================================
	-- Création d'un emprunt
	-- =====================================
	ajouter_emprunt(input_adherent : ADHERENT; input_media : IMEDIA; input_date_emprunt, input_duree : TIME; input_nombre_exemplaires : INTEGER) is
	require
		adherent_ok : input_adherent /= Void and input_adherent.get_nom.count > 0 and input_adherent.get_identifiant.count > 0
		media_ok : input_media /= Void and input_media.get_titre.count > 0 and input_media.get_nombre_disponible > 0
		nbre_emprunts_ok : input_media.get_nombre_disponible >= input_nombre_exemplaires
	local
		emprunt : EMPRUNT
	do
		create emprunt.emprunt(input_adherent, input_media, input_date_emprunt, input_duree, input_nombre_exemplaires)
		liste_emprunts.add_last(emprunt)
		input_adherent.ajouter_emprunt(emprunt)
	end
	
	-- =====================================
	-- Récupération des emprunts d'un adhérent
	-- =====================================
	get_emprunts_adherent(identifiant : STRING) : ARRAY[EMPRUNT] is
	require
		identifiant_non_null : identifiant /= Void
		identifiant_non_vide : identifiant.count > 0
	local
		retour : ARRAY[EMPRUNT]
	do
		
	end
end
