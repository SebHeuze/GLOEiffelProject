-- Classe représentant une documentaliste
class DOCUMENTALISTE inherit IUTILISATEUR

creation{ANY}
	documentaliste
feature {}

feature{ANY}
	documentaliste(input_nom, input_prenom, input_adresse, input_identifiant : STRING; input_age : INTEGER) is
	do
		init(input_nom, input_prenom, input_adresse, input_identifiant, input_age)
	end

end

