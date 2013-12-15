-- Classe abstraite regroupant les propriétés communes à tous les utilisateurs
indexing
	description: "Classe abstraite regroupant les propriétés communes à tous les utilisateurs"

deferred class IUTILISATEUR

feature{}
	nom, prenom, adresse : STRING
	age : INTEGER
	identifiant : STRING

feature {ANY}

	-- =====================================
	-- Initialisation d'un utilisateur
	-- =====================================
	init(inom, iprenom, iadresse, iidentifiant : STRING; iage : INTEGER) is
	do
		nom := inom
		prenom := iprenom
		adresse := iadresse
		age := iage
		identifiant := iidentifiant
	end

	-- =====================================
	-- Retourne l'identifiant de l'utilisateur
	-- =====================================
	get_identifiant : STRING is
	do
		Result := identifiant
	end

	-- =====================================
	-- Set l'identifiant de l'utilisateur
	-- =====================================
	set_identifiant(input_identifiant : STRING) is
	do
		identifiant := input_identifiant
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
