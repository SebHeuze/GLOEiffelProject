-- Classe abstraite représentant un mÃ©dia.
-- La classe qui implémentera devra à priori utiliser le mot clé effective, Cf tutoriel eiffel sur madoc
indexing
	description:"Classe abstraite représentant un média"

deferred class IMEDIA

feature {}
	titre: STRING
	annee: INTEGER
	nombre_disponible: INTEGER -- Represente le nombre d'exemplaires encore disponibles a l'emprunt
	nombre_possedes: INTEGER -- Represente le nombre d'exemplaires total (nbreDispos + nbreEmpruntes)

feature {ANY}

	-- =====================================
	-- Initialisation d'un media depuis les paramÃštres fournis
	-- =====================================
	init (ititre : STRING; iannee, inombre_disponible, inombre_possedes : INTEGER) is
	do
		titre := ititre
		annee := iannee
		nombre_disponible := inombre_disponible
		nombre_possedes := inombre_possedes
	end

	-- =====================================
	-- MatÃ©rialise l'emprunt d'un mÃ©dia, ie diminution du nombre d'exemplaires disponibles
	-- =====================================
	emprunter(nb_exemplaires : INTEGER) is
	require
		nb_exemplaires_suffisant: nb_exemplaires <= nombre_disponible
		nb_emprunts_positif : nb_exemplaires > 0
	do
		nombre_disponible := nombre_disponible - 1
	end

	-- =====================================
	-- Renvoie le titre du mÃ©dia courant
	-- =====================================
	get_titre : STRING is
	do
		Result := titre
	end

	-- =====================================
	-- Modifie le titre du mÃ©dia courant
	-- =====================================
	set_titre(new_titre : STRING) is
	require
		titre_ok : new_titre.count > 0
	do
		titre := new_titre
	end

	-- =====================================
	-- Renvoie l'annÃ©e d'Ã©dition du mÃ©dia
	-- =====================================
	get_annee : INTEGER is
	do
		Result := annee
	end

	-- =====================================
	-- Modifie l'annÃ©e d'Ã©dition du mÃ©dia
	-- =====================================
	set_annee(iannee : INTEGER) is
	require
		annee_ok : iannee > 0
	do
		annee := iannee
	end

	-- =====================================
	-- Affiche le média
	-- =====================================
	afficher is deferred end

invariant
	nb_exemplaires: nombre_disponible >= 0
end
