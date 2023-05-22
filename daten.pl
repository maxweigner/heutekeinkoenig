:- use_module(library(pce)).

% Später für die Ausgabe des Types vom Terrain an den Nutzer
feldType(grass, 1).
feldType(mountain, 2).
feldType(water, 3).

% einheit(type, attack, defense, action multiplier, upkeep)
% der multiplier ist der angewandte faktor für boni/mali
einheit(infantry, 2, 2, 2, 1).
einheit(sniper, 3, 1, 3, 1).
einheit(motorized, 4, 3, 2, 2).
einheit(tank, 5, 5, 3, 3).

% Startpositionen der Spieler mit jeweils -1 auf die coords
% Damit ist die init_player universell
playerStart(1, -1, -1).
playerStart(2, 3, 3).


% Erschafft ein festes Spielfeld
init_feld1 :-
	% feld(X, Y, Type)
	assert( feld(0, 0, 1) ),
	assert( feld(0, 1, 2) ),
	assert( feld(0, 2, 1) ),
	assert( feld(0, 3, 1) ),
	assert( feld(0, 4, 1) ),

	assert( feld(1, 0, 1) ),
	assert( feld(1, 1, 1) ),
	assert( feld(1, 2, 1) ),
	assert( feld(1, 3, 1) ),
	assert( feld(1, 4, 1) ),

	assert( feld(2, 0, 1) ),
	assert( feld(2, 1, 1) ),
	assert( feld(2, 2, 1) ),
	assert( feld(2, 3, 1) ),
	assert( feld(2, 4, 1) ),

	assert( feld(3, 0, 1) ),
	assert( feld(3, 1, 1) ),
	assert( feld(3, 2, 1) ),
	assert( feld(3, 3, 1) ),
	assert( feld(3, 4, 1) ),

	assert( feld(4, 0, 1) ),
	assert( feld(4, 1, 1) ),
	assert( feld(4, 2, 1) ),
	assert( feld(4, 3, 1) ),
	assert( feld(4, 4, 1) ).


% Initialisiert die Einheiten für die jeweiligen Spieler
init_player(Player, Type1, Type2, Type3) :-
	playerStart(Player, X, Y),
	% einheit(Player, Type, feldX, feldY)
	Xp1 is X + 1,
	Yp1 is Y + 1,
	assert( einheit(Player,Type1,Xp1,Yp1) ),
	assert( einheit(Player,Type2,Xp1,Y  ) ),
	assert( einheit(Player,Type3,X  ,Yp1) ).
