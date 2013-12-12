-- Classe abstraite représentant un média.
-- La classe qui implémentera devra à priori utiliser le mot clé effective, Cf tutoriel eiffel sur madoc
indexing
	description:"Classe abstraite représentant un média"

deferred class IMEDIA

feature {}
	titre: STRING
	annee: INTEGER
	nombre_disponible: INTEGER -- Représente le nombre d'exemplaires encore disponibles à l'emprunt
	nombre_possedes: INTEGER -- Représente le nombre d'exemplaires total (nbreDispos + nbreEmpruntés)
	
feature {ANY}

	-- =====================================
	-- Initialisation d'un media depuis les paramètres fournis
	-- =====================================
	init (ititre : STRING; iannee, inombre_disponible, inombre_possedes : INTEGER) is
	do
		titre := ititre
		annee := iannee
		nombre_disponible := inombre_disponible
		nombre_possedes := inombre_possedes
	end
	
	-- =====================================
	-- Matérialise l'emprunt d'un média, ie diminution du nombre d'exemplaires disponibles
	-- =====================================
	emprunter(nb_exemplaires : INTEGER) is
	require
		nb_exemplaires_suffisant: nb_exemplaires <= nombre_disponible
	do
		nombre_disponible := nombre_disponible - 1
	end
	
	-- =====================================
	-- Renvoie le titre du média courant
	-- =====================================
	get_titre : STRING is
	do
		Result := titre
	end
	
	-- =====================================
	-- Modifie le titre du média courant
	-- =====================================
	set_titre(new_titre : STRING) is
	do
		titre := new_titre
	end
	
	-- =====================================
	-- Renvoie l'année d'édition du média
	-- =====================================
	get_annee : INTEGER is
	do
		Result := annee
	end
	
	-- =====================================
	-- Modifie l'année d'édition du média
	-- =====================================
	set_annee(iannee : INTEGER) is
	do
		annee := iannee
	end

invariant
	nb_exemplaires: nombre_disponible >= 0
end
