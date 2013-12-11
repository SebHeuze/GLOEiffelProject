-- Classe représentant un utilisateur
class UTILISATEUR inherit IPERSONNE

creation {ANY}
	utilisateur

feature{}
	liste_emprunts : ARRAY_DICTIONARY[STRING, STRING]
feature{ANY}
	utilisateur
end

