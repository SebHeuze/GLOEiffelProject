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

creation {ANY}
	main

feature {}
	media_manager : MEDIAMANAGER
	user_manager : USERMANAGER

feature {ANY}
	main is
		do
			io.put_string("Main.%N")
			initialisation
		end

	initialisation is
	do
		io.put_string("Initialisation::Debut.%N")
		create media_manager.init_media_manager
		io.put_string("Initialisation::Medias chargés.%N")
		create user_manager.init_user_manager
		io.put_string("Initialisation::Utilisateurs chargés.%N")
		display_menu_principal
		io.put_string("Initialisation::Fin.%N")
	end
	
	-- =====================================
	-- Affiche le menu principal
	-- =====================================
	display_menu_principal is
	do
		io.put_string("%N***********************************%N")
		io.put_string("*******    Menu Principal     *****%N")
		io.put_string("***********************************%N")
		io.put_string("1 - Menu livres%N")
		io.put_string("2 - Menu DVD%N")
		io.put_string("0 - Quitter%N")
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
			display_menu_livres
		elseif(io.last_string.is_equal("2"))
		then
			display_menu_dvd
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
	do
		io.put_string("%N***********************************%N")
		io.put_string("**********    Menu DVD     ********%N")
		io.put_string("***********************************%N")
		io.put_string("1 - Afficher DVDs%N")
		io.put_string("2 - Rechercher un DVD depuis son titre%N")
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
			media_manager.afficher_dvd
		elseif(io.last_string.is_equal("2"))
		then
			display_recherche_par_titre
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
		io.put_string("%N***********************************%N")
		io.put_string("********    Menu livres     *******%N")
		io.put_string("***********************************%N")
		io.put_string("1 - Afficher livres%N")
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
			media_manager.afficher_livres
		elseif(io.last_string.is_equal("0"))
		then
			display_menu_principal
		end
		display_menu_livres
	end
	
	-- =====================================
	-- Recherche d'une oeuvre par titre
	-- =====================================
	display_recherche_par_titre is
	local
		index_recherche, i : INTEGER
		resultats_recherche : ARRAY[IMEDIA]
	do
		io.put_string("********    Recherche par titre     *******%N")
		io.put_string("Veuillez saisir tout ou une partie du titre :%N")
		io.read_line
		resultats_recherche := media_manager.rechercher_media_depuis_titre(io.last_string)
		
		if resultats_recherche.is_empty
		then
			io.put_string("Aucun média correspondant n'a ete trouve.%N")
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
		display_menu_dvd
	end
end -- class HELLO_WORLD
