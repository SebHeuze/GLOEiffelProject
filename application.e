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

	display_menu_principal is
	do
		io.put_string("***********************************%N")
		io.put_string("*******    Menu Principal     *****%N")
		io.put_string("***********************************%N")
		io.put_string("1 - Afficher livres%N")
		io.put_string("2 - Afficher DVD%N")
		io.put_string("0 - Quitter%N")
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
			media_manager.afficher_livres
		end
		if(io.last_string.is_equal("2"))
		then
			media_manager.afficher_dvd
		end
		if(io.last_string.is_equal("0"))
		then
			die_with_code(0)
		end

		display_menu_principal
	end
end -- class HELLO_WORLD
