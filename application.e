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
		io.put_string("Initialisation::Début.%N")
		create media_manager.init_media_manager
		create user_manager.init_user_manager

		media_manager.afficher_livres
	end

end -- class HELLO_WORLD
