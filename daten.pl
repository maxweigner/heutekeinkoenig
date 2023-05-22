:- use_module(library(pce)).

% Später für die Ausgabe des Types vom Terrain an den Nutzer
feldType(grass, 1).
feldType(mountain, 2).
feldType(water, 3).


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
