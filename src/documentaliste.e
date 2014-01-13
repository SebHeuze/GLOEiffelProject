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
