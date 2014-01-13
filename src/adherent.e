-- Classe représentant un adherent
class ADHERENT inherit IUTILISATEUR

creation{ANY}
	adherent
feature {}
	liste_emprunts : ARRAY[EMPRUNT]

feature{ANY}
	adherent(input_nom, input_prenom, input_adresse, input_identifiant, input_pass : STRING; input_age : INTEGER) is
	do
		init(input_nom, input_prenom, input_adresse, input_identifiant, input_pass, input_age )
		create liste_emprunts.with_capacity(60,1)
	end
	
	-- =====================================
	-- Affiche les infos de l'utilisateur
	-- =====================================
	afficher is
	do
		io.put_string("%N************** Documentaliste ******************%N")
		io.put_string("Identifiant : "+ identifiant +"%N")
		io.put_string("Nom : "+ nom + "%N")
		io.put_string("Prenom : "+ prenom +"%N")
		io.put_string("Adresse : "+ adresse +"%N")
		io.put_string("Age : "+ age.to_string +"%N")
	end
end
