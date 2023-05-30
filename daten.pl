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
% playerStart(Player, X, Y)
player(1).
player(2).

% Die Anzahl an tokens die pro Runde an die Spieler verteilt wird
player_tokens(10).


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


% Setzt das Spielfeld sowie die zugewiesenen einheiten zurück
reset_game :-
	retractall( feld(_,_,_) ),
	retractall( einheit_active(_,_,_,_) ),
	retractall( player_tokens(_,_) ).


% Initialisiert die Einheiten für die jeweiligen Spieler
init_player1(Player, Type1, Type2, Type3) :-
	% Berechnet die zustehenden Tokens pro Runde für den Spieler
	einheit(Type1, _, Defense_Points1, _, Cost1),
	einheit(Type2, _, Defense_Points2, _, Cost2),
	einheit(Type3, _, Defense_Points3, _, Cost3),
	
	player_tokens(Tokens),
	Cost is Tokens - (Cost1 + Cost2 + Cost3),
	assert( player_tokens(Player, Cost) ),

	% Definiert die aktiven einheiten der Spieler
	% einheit_active(Player, Einheit Type, feldX, feldY)
	assert( einheit_active(Player,Type1,0,0,Defense_Points1) ),
	assert( einheit_active(Player,Type2,0,1,Defense_Points2) ),
	assert( einheit_active(Player,Type3,1,0,Defense_Points3) ).

init_player2(Player, Type1, Type2, Type3) :-
	% Berechnet die zustehenden Tokens pro Runde für den Spieler
	einheit(Type1, _, Defense_Points1, _, Cost1),
	einheit(Type2, _, Defense_Points2, _, Cost2),
	einheit(Type3, _, Defense_Points3, _, Cost3),
	
	player_tokens(Tokens),
	Cost is Tokens - (Cost1 + Cost2 + Cost3),
	assert( player_tokens(Player, Cost) ),

	% Definiert die aktiven einheiten der Spieler
	% einheit_active(Player, Einheit Type, feldX, feldY)
	assert( einheit_active(Player,Type1,4,4,Defense_Points1) ),
	assert( einheit_active(Player,Type2,4,3,Defense_Points2) ),
	assert( einheit_active(Player,Type3,3,4,Defense_Points3) ).