% Initialisiert die Einheiten für die jeweiligen Spieler
init_player(Player, Type1, Type2, Type3) :-
	playerStart(Player, X, Y),
	% unit(Player, Type, feldX, feldY)
	Xp1 is X + 1,
	Yp1 is Y + 1,
	assert( einheit(Player,Type1,Xp1,Yp1) ),
	assert( einheit(Player,Type2,Xp1,Y  ) ),
	assert( einheit(Player,Type3,X  ,Yp1) ).