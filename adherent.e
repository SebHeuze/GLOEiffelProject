-- Classe représentant un adherent
class ADHERENT inherit IUTILISATEUR

creation{ANY}
	adherent
feature {}
	liste_emprunts : ARRAY[IMEDIA]

feature{ANY}
	adherent(input_nom, input_prenom, input_adresse, input_identifiant : STRING; input_age : INTEGER) is
	do
		init(input_nom, input_prenom, input_adresse, input_identifiant, input_age )
		create liste_emprunts.with_capacity(60,1)
	end


end

