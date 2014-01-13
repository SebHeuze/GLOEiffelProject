-- Classe représentant une documentaliste
class DOCUMENTALISTE inherit IUTILISATEUR
creation{ANY}
	documentaliste
feature {}

feature{ANY}
	documentaliste(input_nom, input_prenom, input_adresse, input_identifiant, input_pass : STRING; input_age : INTEGER) is
	do
		init(input_nom, input_prenom, input_adresse, input_identifiant, input_pass, input_age)
	end

	-- =====================================
	-- compare deux utilisateurs
	-- =====================================
	--is_equal(utilisateur2 : DOCUMENTALISTE):BOOLEAN is
	--do
	--	Result := (identifiant.is_equal(utilisateur2.identifiant) and password.is_equal(utilisateur2.password))
	--end

end

