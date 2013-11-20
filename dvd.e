-- Implémentation de la classe IMedia représentant un DVD
indexing
	description:"Simple DVD representation"

class DVD inherit IMEDIA
	
creation {ANY}
	init

feature {}
	realisateur : STRING
	acteurs : ARRAY[STRING]
	type : STRING
	
feature {ANY}

end
