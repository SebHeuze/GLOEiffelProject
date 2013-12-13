-- Classe représentant un utilisateur
class UTILISATEUR inherit IPERSONNE

creation{ANY}
	utilisateur
feature {}
	identifiant : STRING
	is_admin : BOOLEAN

feature{ANY}
	utilisateur(input_nom, input_prenom, input_identifiant : STRING, input_is_admin : BOOLEAN) is
	do
		nom := input_nom
		prenom := input_prenom
		identifiant := input_identifiant
		is_admin := input_is_admin
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
	-- Retourne si l'utilisateur est admin
	-- =====================================
	get_is_admin : BOOLEAN is
	do
		Result := is_admin
	end

	-- =====================================
	-- Set si l'utilisateur est admin
	-- =====================================
	set_is_admin(input_is_admin : BOOLEAN) is
	do
		is_admin := input_is_admin
	end
end

