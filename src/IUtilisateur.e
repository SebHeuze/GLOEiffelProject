-- Classe abstraite regroupant les propriétés communes à tous les utilisateurs
indexing
	description: "Classe abstraite regroupant les propriétés communes à tous les utilisateurs"

deferred class IUTILISATEUR
	inherit COMPARABLE
	redefine
            is_equal
  	end
feature{IUTILISATEUR}
	nom, prenom, adresse, password : STRING
	age : INTEGER
	identifiant : STRING

feature {ANY}

	-- =====================================
	-- Initialisation d'un utilisateur
	-- =====================================
	init(inom, iprenom, iadresse, iidentifiant,ipassword : STRING; iage : INTEGER) is
	do
		nom := inom
		prenom := iprenom
		adresse := iadresse
		age := iage
		identifiant := iidentifiant
		password := ipassword
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

	-- =====================================
	-- compare deux utilisateurs
	-- =====================================
	is_equal(utilisateur2: like Current):BOOLEAN is
	do
		Result := identifiant.is_equal(utilisateur2.identifiant) and password.is_equal(utilisateur2.password)
	end

	infix "<" (utilisateur2: like Current): BOOLEAN is
    do
      Result := identifiant < utilisateur2.identifiant
    end
    
    -- =====================================
	-- Affichage du média
	-- =====================================
	afficher is deferred end
end
