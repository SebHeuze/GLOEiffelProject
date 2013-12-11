-- Classe abstraite regroupant les propriétés communes à toutes les personnes
indexing
	description: "Classe abstraite regroupant les propriétés communes à toutes les personnes"

deferred class IPERSONNE

feature{}
	nom, prenom, adresse : STRING
	age : INTEGER

feature {ANY}

	-- =====================================
	-- Initialisation d'une personne
	-- =====================================
	init(inom, iprenom, iadresse : STRING; iage : INTEGER) is
	do
		nom := inom
		prenom := iprenom
		adresse := iadresse
		age := iage
	end
	
	-- =====================================
	-- Retourne l'adresse
	-- =====================================
	get_adresse : STRING is
	do
		Result := adresse
	end
	
	-- =====================================
	-- Modifie l'adresse
	-- =====================================
	set_adresse(iadresse : STRING) is
	do
		adresse := iadresse
	end
	
	-- =====================================
	-- Modifie le prénom
	-- =====================================
	set_prenom(iprenom : STRING) is
	do
		prenom := iprenom
	end
	
	-- =====================================
	-- Retourne le prénom
	-- =====================================
	get_prenom : STRING is
	do
		Result := prenom
	end
	
	-- =====================================
	-- Retourne le nom
	-- =====================================
	get_nom : STRING is
	do
		Result := nom
	end
	
	-- =====================================
	-- Modifie le nom
	-- =====================================
	set_nom(inom : STRING) is
	do
		nom := inom
	end
end
