-- Classe représentant le gestionnaire des emprunts

indexing
	description:"Classe de gestion des emprunts"

class EMPRUNTMANAGER

creation {ANY}
	emprunt_manager,
	emprunt_manager_empty

feature {}
	liste_emprunts : ARRAY[EMPRUNT]

feature{ANY}

	-- =====================================
	-- Constructeur
	-- =====================================
	emprunt_manager(input_liste_emprunts : ARRAY[EMPRUNT]) is
	require
		liste_non_vide : input_liste_emprunts.count > 0
	do
		liste_emprunts := input_liste_emprunts
	end
	
	-- =====================================
	-- Constructeur par défaut
	-- =====================================
	emprunt_manager_empty is
	do
		--Initialisation des listes de emprunts
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
		input_media.set_nombre_disponible(input_media.get_nombre_disponible - input_nombre_exemplaires)
	end
	
	-- =====================================
	-- Suppression d'un emprunt
	-- =====================================
	supprimer_emprunt(input_adherent : ADHERENT; input_media : IMEDIA) is
	require
		adherent_non_null : input_adherent /= Void
		media_non_null : input_media /= Void
	do
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
		i : INTEGER
	do
		--Initialisation des listes de médias
		create retour.with_capacity(60,1)
		from
			i:= liste_emprunts.lower
		until
			i > liste_emprunts.upper
		loop
			if(liste_emprunts.item(i).get_adherent.get_identifiant = identifiant)
			then
				retour.add_last(liste_emprunts.item(i))
			end
			i := i + 1
		end
	end
end
