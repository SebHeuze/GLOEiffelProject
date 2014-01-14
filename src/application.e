class APPLICATION
--
-- The "Hello World" example.
--
-- To compile type command: se c hello_world
--
-- Then, run the generated executable file named "a.out" or "hello_world.exe"
-- depending of your favorite operating system / C-compiler.
--
-- To compile an optimized version type : se c hello_world -boost -O2
--
inherit
    ARGUMENTS

creation {ANY}
	main

feature {}
	media_manager : MEDIAMANAGER
	user_manager : USERMANAGER
	emprunt_manager : EMPRUNTMANAGER

feature {ANY}
	main is
		do
			io.put_string("Main.%N")
			initialisation
		end

	initialisation is
	local
		utilisateurs_charges, medias_charges, utilisateurs_erreur, medias_erreur : BOOLEAN
	do
		io.put_string("Initialisation::Debut.%N")
		if(medias_erreur = False)
		then
			create media_manager.init_media_manager
			utilisateurs_charges := True
			io.put_string("Initialisation::Médias chargés.%N")
		end
		if(utilisateurs_erreur = False)
		then
			create user_manager.init_user_manager
			medias_charges := True
			io.put_string("Initialisation::Utilisateurs chargés.%N")
		end
		
		media_manager.save_to_file
		display_ecran_login
		io.put_string("Initialisation::Fin.%N")
	--rescue
		-- Exception sur le chargement des utilisateurs
		--if(utilisateurs_charges = False and medias_charges = False)
		--then
		--	io.put_string("Impossible de charger les médias !%N")
		--	medias_erreur := True
		--elseif(utilisateurs_charges = True and medias_charges = False)
		--then
		--	io.put_string("Impossible de charger les utilisateurs !%N")
		--	utilisateurs_erreur := True
		--end
		--retry
	end


	-- =====================================
	-- Affiche l'écran login
	-- =====================================
	display_ecran_login is
	local
		identifiant, password: STRING;
		admin : BOOLEAN;
	do
		io.put_string("%N")
		io.put_string("*************************************%N")
		io.put_string("*******       MediaTek'         *****%N")
		io.put_string("*************************************%N")
		io.put_string("L'acces a cette application est protége par un login%N")
		io.put_string("Identifiant :%N")
		identifiant :=""
		password :=""
		io.read_line
		identifiant.copy (io.last_string)
		io.put_string("Mot de passe :%N")
		io.read_line
		password.copy (io.last_string)

		if(argument_count > 0) then
			if(argument(1).is_equal("admin"))
			then
				admin := True
			else
				admin := False
			end
		end
		if(user_manager.login(identifiant, password, admin))
		then
			io.put_string("Bienvenue " + user_manager.get_connected_user.get_nom +" "+ user_manager.get_connected_user.get_prenom)
			display_menu_principal
		else
			io.put_string("Identifiant/mot de passe invalide")
			io.read_line
			display_ecran_login
		end
	end

	-- =====================================
	-- Affiche le menu principal
	-- =====================================
	display_menu_principal is
	do
		io.put_string("%N")
		io.put_string("*************************************%N")
		io.put_string("*******     Menu Principal      *****%N")
		io.put_string("*************************************%N")
		io.put_string("1 - Menu livres%N")
		io.put_string("2 - Menu DVD%N")
		io.put_string("3 - Menu Utilisateurs%N")
		io.put_string("4 - Menu emprunts%N")
		io.put_string("0 - Quitter%N")
		io.put_string("Votre choix ? ")

		from
			io.read_line
		until
			io.last_string.is_equal("1") or io.last_string.is_equal("2") or io.last_string.is_equal("3") or io.last_string.is_equal("4") or io.last_string.is_equal("0")
		loop
			io.put_string("Votre choix ? ")
			io.read_line
		end

		if(io.last_string.is_equal("1"))
		then
			display_menu_livres
		elseif(io.last_string.is_equal("2"))
		then
			display_menu_dvd
		elseif(io.last_string.is_equal("3"))
		then
			display_menu_utilisateurs
		elseif(io.last_string.is_equal("4"))
		then
			display_menu_emprunts
		elseif(io.last_string.is_equal("0"))
		then
			die_with_code(0)
		end

		display_menu_principal
	end

	-- =====================================
	-- Affiche le menu des dvd
	-- =====================================
	display_menu_dvd is
	local
		trash : IMEDIA
	do
		io.put_string("%N")
		io.put_string("*************************************%N")
		io.put_string("**********     Menu DVD      ********%N")
		io.put_string("*************************************%N")
		io.put_string("1 - Afficher DVDs%N")
		io.put_string("2 - Rechercher un DVD depuis son titre%N")
		io.put_string("3 - Modifier un DVD%N")
		io.put_string("4 - Supprimer un DVD%N")
		io.put_string("0 - Retour%N")
		io.put_string("Votre choix ? ")

		from
			io.read_line
		until
			io.last_string.is_equal("1") or io.last_string.is_equal("2") or io.last_string.is_equal("3") or io.last_string.is_equal("4") or io.last_string.is_equal("0")
		loop
			io.put_string("Votre choix ? ")
			io.read_line
		end

		if(io.last_string.is_equal("1"))
		then
			media_manager.afficher_dvd
		elseif(io.last_string.is_equal("2"))
		then
			trash := display_recherche_par_titre_et_auteur
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_principal
		end
		display_menu_dvd
	end

	-- =====================================
	-- Affiche le menu des livres
	-- =====================================
	display_menu_livres is
	do
		io.put_string("%N")
		io.put_string("*************************************%N")
		io.put_string("********     Menu livres      *******%N")
		io.put_string("*************************************%N")
		io.put_string("1 - Afficher livres%N")
		io.put_string("2 - Rechercher livres%N")
		io.put_string("3 - Modifier livre%N")
		io.put_string("4 - Supprimer livre%N")
		io.put_string("0 - Retour%N")
		io.put_string("Votre choix ? ")

		from
			io.read_line
		until
			io.last_string.is_equal("1") or io.last_string.is_equal("2") or io.last_string.is_equal("3")  or io.last_string.is_equal("4") or io.last_string.is_equal("0")
		loop
			io.put_string("Votre choix ? ")
			io.read_line
		end

		if(io.last_string.is_equal("1"))
		then
			media_manager.afficher_livres
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_principal
		end
		display_menu_livres
	end

	-- =====================================
	-- Affiche le menu des utilisateurs
	-- =====================================
	display_menu_utilisateurs is
	do
		io.put_string("%N")
		io.put_string("************************************%N")
		io.put_string("*******   Menu Utilisateurs   ******%N")
		io.put_string("************************************%N")
		io.put_string("1 - Afficher un utilisateur%N")
		io.put_string("2 - Rechercher un utilisateur%N")
		io.put_string("3 - Modifier un Utilisateur%N")
		io.put_string("4 - Supprimer un Utilisateur%N")
		io.put_string("0 - Retour%N")
		io.put_string("Votre choix ? ")

		from
			io.read_line
		until
			io.last_string.is_equal("1") or io.last_string.is_equal("2") or io.last_string.is_equal("3") or io.last_string.is_equal("4") or io.last_string.is_equal("0")
		loop
			io.put_string("Votre choix ? ")
			io.read_line
		end

		if(io.last_string.is_equal("1"))
		then
			display_menu_recherche_utilisateur
		elseif(io.last_string.is_equal("2"))
		then
			display_menu_recherche_utilisateur
		elseif(io.last_string.is_equal("3"))
		then
			display_modification_utilisateur
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_principal
		end
	end

	-- =====================================
	-- Affichage du menu des emprunts
	-- =====================================
	display_menu_emprunts is
	do
		io.put_string("%N")
		io.put_string("************************************%N")
		io.put_string("*********   Menu emprunts   ********%N")
		io.put_string("************************************%N")
		io.put_string("1 - Afficher un emprunt%N")
		io.put_string("2 - Rechercher un emprunt%N")
		io.put_string("3 - Créer un emprunt%N")
		io.put_string("4 - Clôturer un emprunt%N")
		io.put_string("0 - Retour%N")
		io.put_string("Votre choix ? ")
		
		from
			io.read_line
		until
			io.last_string.is_equal("1") or io.last_string.is_equal("2") or io.last_string.is_equal("3") or io.last_string.is_equal("4") or io.last_string.is_equal("0")
		loop
			io.put_string("Votre choix ? ")
			io.read_line
		end
		
		if(io.last_string.is_equal("1"))
		then
			
		elseif(io.last_string.is_equal("2"))
		then
			
		elseif(io.last_string.is_equal("3"))
		then
			display_menu_utilisateurs
		elseif(io.last_string.is_equal("4"))
		then
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_principal
		end
	end

	-- =====================================
	-- Affichage du menu des utilisateurs
	-- =====================================
	display_menu_recherche_utilisateur is
	local
		trash : IUTILISATEUR
	do
		io.put_string("%N")
		io.put_string("************************************%N")
		io.put_string("***** Recherche d'utilisateur ******%N")
		io.put_string("************************************%N")
		io.put_string("1- Recherche par nom%N")
		io.put_string("2- Recherche par identifiant%N")
		io.put_string("0- Retour%N")
		io.put_string("Votre choix ? ")
		from
			io.read_line
		until
			io.last_string.is_equal("1") or io.last_string.is_equal("2") or io.last_string.is_equal("0")
		loop
			io.put_string("Votre choix ? ")
			io.read_line
		end
		
		if(io.last_string.is_equal("1"))
		then
			display_recherche_utilisateur_par_nom
		elseif(io.last_string.is_equal("2"))
		then
			trash := display_recherche_utilisateur_par_identifiant
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_utilisateurs
		end
			
	end

	-- =====================================
	-- Recherche d'un utilisateur depuis son nom
	-- =====================================
	display_recherche_utilisateur_par_nom is
	local
		i : INTEGER
		resultats_recherche : ARRAY[IUTILISATEUR]
	do
		io.put_string("********    Recherche par nom     *******%N")
		io.put_string("Veuillez saisir tout ou une partie du nom :%N")
		io.read_line
		resultats_recherche := user_manager.rechercher_utilisateur_depuis_nom(io.last_string)
		if resultats_recherche.is_empty
		then
			io.put_string("Aucun utilisateur correspondant n'a ete trouve.%N")
		else
			from
				i := resultats_recherche.lower
			until
				i > resultats_recherche.upper
			loop
				io.put_string("%NResultat "+i.to_string+" :")
				resultats_recherche.item(i).afficher
				i := i + 1
			end
		end
		display_menu_utilisateurs
	end

	-- =====================================
	-- Recherche d'un utilisateur depuis son identifiant
	-- =====================================
	display_recherche_utilisateur_par_identifiant : IUTILISATEUR is
	local
		resultat_recherche : IUTILISATEUR
	do
		io.put_string("********    Recherche par identifiant    *******%N")
		io.put_string("Veuillez saisir tout ou une partie de l'identifiant :%N")
		io.read_line
		resultat_recherche := user_manager.rechercher_utilisateur_depuis_identifiant(io.last_string)
		if resultat_recherche = Void
		then
			io.put_string("Aucun utilisateur correspondant n'a ete trouve.%N")
			Result := Void
		else
			resultat_recherche.afficher
			Result := resultat_recherche
		end
	end

	-- =====================================
	-- Recherche d'une oeuvre par titre
	-- =====================================
	display_recherche_par_titre_et_auteur : IMEDIA is
	local
		resultat_recherche : IMEDIA
		titre, auteur : STRING
	do
		io.put_string("********    Recherche par titre     *******%N")
		io.put_string("Veuillez saisir tout ou une partie du titre :%N")
		io.read_line
		titre.copy(io.last_string)
		
		
		io.put_string("Veuillez saisir l'auteur / réalisateur :%N")
		io.read_line
		auteur.copy(io.last_string)
		resultat_recherche := media_manager.rechercher_media_depuis_titre_et_auteur(titre, auteur)

		if resultat_recherche = Void
		then
			io.put_string("Aucun média correspondant n'a ete trouve.%N")
		else
			resultat_recherche.afficher
		end
		display_menu_dvd
	end
	
	-- =====================================
	-- Modification d'un adhérent
	-- =====================================
	display_modification_utilisateur is
	local
		nom, prenom, adresse, age : STRING -- Variable de débug
		utilisateur_recherche : IUTILISATEUR -- Utilisateur récupéré par la recherche
	do
		create nom.make_empty
		create prenom.make_empty
		create adresse.make_empty
		create age.make_empty
		
		io.put_string("%N")
		io.put_string("************************************%N")
		io.put_string("**** Modification d'utilisateur ****%N")
		io.put_string("************************************%N")
		
		-- Recherche d'un utilisateur depuis son login, garantissant l'unicité
		utilisateur_recherche := display_recherche_utilisateur_par_identifiant
		
		-- Gestion des droits de modification
		if((utilisateur_recherche.get_identifiant = user_manager.get_connected_user.get_identifiant and user_manager.get_connected_user.generating_type = "ADHERENT") or user_manager.get_connected_user.generating_type = "DOCUMENTALISTE")
		then
			io.put_string("Nouveau nom :%N")
			io.read_line
			nom.copy(io.last_string)
			utilisateur_recherche.set_nom(nom)
		
			io.put_string("Nouveau prénom :%N")
			io.read_line
			prenom.copy(io.last_string)
			utilisateur_recherche.set_prenom(prenom)
		
			io.put_string("Nouvel âge :%N")
			io.read_line
			age.copy(io.last_string)
			utilisateur_recherche.set_age(age.to_integer)
		
			io.put_string("Nouvelle adresse :%N")
			io.read_line
			adresse.copy(io.last_string)
			utilisateur_recherche.set_adresse(adresse)
		
			io.put_string("=============== Modification prise en compte ===============%N")
		end
	end
end -- class HELLO_WORLD
