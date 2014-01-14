-- Classe représentant un adherent
class ADHERENT inherit IUTILISATEUR

creation{ANY}
	adherent
feature {}
	liste_emprunts : ARRAY[EMPRUNT]

feature{ANY}

	-- =====================================
	-- Constructeur
	-- =====================================
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
		io.put_string("%N************** Adhérent ******************%N")
		io.put_string("Identifiant : "+ identifiant +"%N")
		io.put_string("Nom : "+ nom + "%N")
		io.put_string("Prenom : "+ prenom +"%N")
		io.put_string("Adresse : "+ adresse +"%N")
		io.put_string("Age : "+ age.to_string +"%N")
	end
	
	-- =====================================
	-- Ajoute un emprunt pour l'utilisateur
	-- =====================================
	ajouter_emprunt(emprunt : EMPRUNT) is
	require
		emprunt_non_null : emprunt /= Void
	do
		liste_emprunts.add_last(emprunt);
	end
	
	-- =====================================
	-- Supprime un emprunt pour l'utilisateur
	-- =====================================
	supprimer_emprunt(emprunt : EMPRUNT) is
	require
		emprunt_non_null : emprunt /= Void
	do
		liste_emprunts.remove(liste_emprunts.first_index_of(emprunt));
	end
end
