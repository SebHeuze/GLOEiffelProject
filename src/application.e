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
		create emprunt_manager.emprunt_manager_empty
		io.put_string("Initialisation::Emprunts chargés.%N")
		media_manager.save_to_file
		--emprunt_manager.save_to_file
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
		if(user_manager.get_connected_user.generating_type.is_equal("DOCUMENTALISTE"))
		then
			io.put_string("4 - Menu emprunts%N")
		end
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
		io.put_string("2 - Créer un utilisateur%N")
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
			display_creation_utilisateur
		elseif(io.last_string.is_equal("3"))
		then
			display_modification_utilisateur
		elseif(io.last_string.is_equal("4"))
		then
			display_suppression_utilisateur
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_principal
		end
		display_menu_utilisateurs
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
				if((resultats_recherche.item(i).get_identifiant.is_equal(user_manager.get_connected_user.get_identifiant) and user_manager.get_connected_user.generating_type.is_equal("ADHERENT")) or (user_manager.get_connected_user.generating_type.is_equal("DOCUMENTALISTE")))
				then
					io.put_string("%NResultat "+i.to_string+" :")
					resultats_recherche.item(i).afficher
				end
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
		io.put_string("%N********    Recherche d'utilisateur par identifiant    *******%N")
		io.put_string("Veuillez saisir tout ou une partie de l'identifiant :%N")
		io.read_line
		resultat_recherche := user_manager.rechercher_utilisateur_depuis_identifiant(io.last_string)
		if resultat_recherche = Void
		then
			io.put_string("Aucun utilisateur correspondant n'a été trouvé.%N")
			Result := Void
		else
			if((resultat_recherche.get_identifiant.is_equal(user_manager.get_connected_user.get_identifiant) and user_manager.get_connected_user.generating_type.is_equal("ADHERENT")) or (user_manager.get_connected_user.generating_type.is_equal("DOCUMENTALISTE")))
			then

				resultat_recherche.afficher
				Result := resultat_recherche

			else
				io.put_string("!!! Vous n'avez pas les droits suffisants !!!%N")
			end
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
		io.put_string("%N********    Recherche de média par titre / auteur    *******%N")

		io.put_string("Veuillez saisir tout ou une partie du titre :%N")
		io.read_line
		create titre.make_empty
		titre.copy(io.last_string)


		io.put_string("Veuillez saisir l'auteur / réalisateur :%N")
		io.read_line
		create auteur.make_empty
		auteur.copy(io.last_string)

		resultat_recherche := media_manager.rechercher_media_depuis_titre_et_auteur(titre, auteur)

		if resultat_recherche = Void
		then
			io.put_string("Aucun média correspondant n'a été trouvé.%N")
		else
			resultat_recherche.afficher
			Result := resultat_recherche
		end
	end

	-- =====================================
	-- Création d'un adhérent
	-- =====================================
	display_suppression_utilisateur is
	local
		user : IUTILISATEUR
	do
		user := display_recherche_utilisateur_par_identifiant

		user_manager.supprimer_utilisateur(user)
	end

	-- =====================================
	-- Création d'un adhérent
	-- =====================================
	display_creation_utilisateur is
	local
		nom, prenom, adresse, age, identifiant, temp : STRING -- Variable de débug
		adherent : ADHERENT
		documentaliste : DOCUMENTALISTE
	do
		create nom.make_empty
		create prenom.make_empty
		create adresse.make_empty
		create age.make_empty
		create identifiant.make_empty
		create temp.make_empty

		io.put_string("%N")
		io.put_string("************************************%N")
		io.put_string("****** Création d'utilisateur ******%N")
		io.put_string("************************************%N")

		-- Gestion des droits de modification
		if(user_manager.get_connected_user.generating_type.is_equal("DOCUMENTALISTE"))
		then
			io.put_string("Nouveau nom :%N")
			io.read_line
			nom.copy(io.last_string)

			io.put_string("Nouveau prénom :%N")
			io.read_line
			prenom.copy(io.last_string)

			io.put_string("Nouvel identifiant :%N")
			io.read_line
			identifiant.copy(io.last_string)

			io.put_string("Nouvel âge :%N")
			io.read_line
			age.copy(io.last_string)

			io.put_string("Nouvelle adresse :%N")
			io.read_line
			adresse.copy(io.last_string)

			io.put_string("Documentaliste ou Adhérent ? (D/A) %N")

			from
				io.read_line
			until
				io.last_string.is_equal("A") or io.last_string.is_equal("D")
			loop
				io.put_string("Documentaliste ou Adhérent ? (D/A) %N")
				io.read_line
			end

			temp.copy(io.last_string)
			if(temp.is_equal("A"))
			then
				create adherent.adherent(nom, prenom, adresse, identifiant, identifiant, age.to_integer)
				user_manager.ajouter_utilisateur(adherent)
			else
				create documentaliste.documentaliste(nom, prenom, adresse, identifiant, identifiant, age.to_integer)
				user_manager.ajouter_utilisateur(documentaliste)
			end


			io.put_string("=============== Modification prise en compte ===============%N")
		else
			io.put_string("%N!!! Vous n'avez pas les droits suffisants !!!%N")
		end
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
		if((utilisateur_recherche.get_identifiant = user_manager.get_connected_user.get_identifiant and user_manager.get_connected_user.generating_type.is_equal("ADHERENT")) or user_manager.get_connected_user.generating_type.is_equal("DOCUMENTALISTE"))
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
		else
			io.put_string("%N!!! Vous n'avez pas les droits suffisants !!!%N")
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
		io.put_string("2 - Créer un emprunt%N")
		io.put_string("3 - Clôturer un emprunt%N")
		io.put_string("0 - Retour%N")
		io.put_string("Votre choix ? ")

		from
			io.read_line
		until
			io.last_string.is_equal("1") or io.last_string.is_equal("2") or io.last_string.is_equal("3") or io.last_string.is_equal("0")
		loop
			io.put_string("Votre choix ? ")
			io.read_line
		end

		if(io.last_string.is_equal("1"))
		then
			emprunt_manager.afficher_emprunts
		elseif(io.last_string.is_equal("2"))
		then
			display_menu_creation_emprunt
		elseif(io.last_string.is_equal("3"))
		then
			display_menu_suppression_emprunt
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_principal
		end
		display_menu_emprunts
	end

	-- =====================================
	-- Création d'un emprunt
	-- =====================================
	display_menu_suppression_emprunt is
	local
		media_recherche : IMEDIA
		utilisateur_recherche : IUTILISATEUR
	do
		-- Recherche d'un utilisateur depuis son login, garantissant l'unicité
		utilisateur_recherche := display_recherche_utilisateur_par_identifiant

		-- Recherche d'un média depuis son titre et son auteur, clé unique
		media_recherche := display_recherche_par_titre_et_auteur
		
		if(utilisateur_recherche /= Void and media_recherche /= Void)
		then
			lancer_processus_suppression_emprunt(utilisateur_recherche, media_recherche)
			io.put_string("%NL'emprunt a bien été supprimé :)%N")
		elseif media_recherche = Void and utilisateur_recherche = Void
		then
			io.put_string("%N !!! Impossible de trouver l'adhérent et l'oeuvre, procédure arrêtée !!!")
		elseif media_recherche = Void
		then
			io.put_string("%N !!! Impossible de trouver l'oeuvre, procédure arrêtée !!!")
		elseif utilisateur_recherche = Void
		then
			io.put_string("%N !!! Impossible de trouver l'adhérent, procédure arrêtée !!!")
		end
	end
	
	-- =====================================
	-- Création d'un emprunt
	-- =====================================
	display_menu_creation_emprunt is
	local
		media_recherche : IMEDIA
		utilisateur_recherche : IUTILISATEUR
		adherent : ADHERENT
		documentaliste : DOCUMENTALISTE
	do
		io.put_string("%N")
		io.put_string("************************************%N")
		io.put_string("*******   Création emprunt   *******%N")
		io.put_string("************************************%N")

		-- Recherche d'un utilisateur depuis son login, garantissant l'unicité
		utilisateur_recherche := display_recherche_utilisateur_par_identifiant

		-- Recherche d'un média depuis son titre et son auteur, clé unique
		media_recherche := display_recherche_par_titre_et_auteur

		if(utilisateur_recherche /= Void and media_recherche /= Void)
		then
			if(utilisateur_recherche.generating_type.is_equal("ADHERENT"))
			then
				-- Tiens voilà du boudin, voilà du boudin !
				adherent ?= utilisateur_recherche
				lancer_processus_emprunt_adherent(adherent, media_recherche)

			elseif(utilisateur_recherche.generating_type.is_equal("DOCUMENTALISTE"))
			then

				-- Tiens voilà des riettes, voilà des riettes !
				documentaliste ?= utilisateur_recherche
				lancer_processus_emprunt_documentaliste(documentaliste, media_recherche)

			end
		elseif media_recherche = Void and utilisateur_recherche = Void
		then
			io.put_string("%N !!! Impossible de trouver l'adhérent et l'oeuvre, procédure arrêtée !!!")
		elseif media_recherche = Void
		then
			io.put_string("%N !!! Impossible de trouver l'oeuvre, procédure arrêtée !!!")
		elseif utilisateur_recherche = Void
		then
			io.put_string("%N !!! Impossible de trouver l'adhérent, procédure arrêtée !!!")
		end
	end

	-- =====================================
	-- Processus d'emprunt pour un adhérent
	-- =====================================
	lancer_processus_suppression_emprunt(adherent : IUTILISATEUR; media : IMEDIA) is
	require
		adherent /= Void
		media /= Void
	do
		emprunt_manager.supprimer_emprunt(adherent, media)
	end
	
	-- =====================================
	-- Processus d'emprunt pour un adhérent
	-- =====================================
	lancer_processus_emprunt_adherent(adherent : ADHERENT; media : IMEDIA) is
	require
		adherent /= Void
		media /= Void
	local
		duree, date_courante : TIME
		duree_entier : INTEGER
		--trash : BOOLEAN
	do
		-- Vérification que l'utilisateur donné n'a pas d'emprunt en retard, auquel cas on refuse l'emprunt
		if(not adherent.possede_emprunt_retard and media.get_nombre_disponible > 0)
		then
			-- Demande de validation par l'utilisateur en lui présentant les informations recherchées
			io.put_string("%NConfirmez-vous l'emprunt de l'oeuvre " + media.get_titre + " par " + adherent.get_prenom + " " + adherent.get_nom + " (" + adherent.get_identifiant + ") ? (O/N)%N")

			-- On boucle tant qu'on n'a pas obtenu une réponse qui va bien
			from
				io.read_line
			until
				io.last_string.is_equal("O") or io.last_string.is_equal("N")
			loop
				io.put_string("%NConfirmez-vous l'emprunt de l'oeuvre " + media.get_titre + " par " + adherent.get_prenom + " " + adherent.get_nom + " (" + adherent.get_identifiant + ") ? (O/N)%N")
				io.read_line
			end

			-- Si validé, on demande la durée d'emprunt en jours
			if(io.last_string.is_equal("O"))
			then

				-- Demande de la durée en jours
				io.put_string("Veuillez saisir la durée de l'emprunt en jours :%N")
				io.read_line
				duree_entier := io.last_string.to_integer

				create duree
				create date_courante
				--trash := duree.set(duree.year, duree.month, duree_entier, duree.hour, duree.minute, duree.second)
				duree.add_day(duree_entier - 1)
				date_courante.update

				-- Ajout dans le manager d'emprunts
				emprunt_manager.ajouter_emprunt(adherent, media, date_courante, duree, 1)
			end
		elseif adherent.possede_emprunt_retard
		then-- Cas d'un retard actuellement dans les emprunts de l'utilisateur
			io.put_string("%N" + "!!!" + adherent.get_prenom + " " + adherent.get_nom + " (" + adherent.get_identifiant + ") possède déjà un emprunt en retard !!!")
		elseif media.get_nombre_disponible = 0
		then
			io.put_string("%NAucun exemplaire disponible à l'emprunt !%N")
		end
	end

	lancer_processus_emprunt_documentaliste(adherent : DOCUMENTALISTE; media : IMEDIA) is
	do
	end
end
