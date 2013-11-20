-- Classe abstraite représentant un média.
-- La classe qui implémentera devra à priori utiliser le mot clé effective, Cf tutoriel eiffel sur madoc
indexing
	description:"Simple media representation"

deferred class IMEDIA
	
creation {ANY}
	init

feature {}
	titre: STRING
	annee: INTEGER
	nombre_disponible: INTEGER
	
feature {ANY}

	-- =====================================
	-- Initialisation d'un media depuis les paramètres fournis
	-- =====================================
	init (ititre : STRING; iannee, inombre_disponible : INTEGER) is
	do
		titre := ititre
		annee := iannee
		nombre_disponible := inombre_disponible
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
	
	set_annee(iannee : INTEGER) is
	require
		annee_correcte: iannee > 2013
end

invariant
	nb_exemplaires: nombre_disponible >= 0
