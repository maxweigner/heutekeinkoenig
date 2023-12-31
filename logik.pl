% hier kommt der ganze logik bums hin

% Der aktuelle Spieler wird hiermit gesetzt damit das später
% nicht bei jedem Aufruf angegeben werden muss
:- assert( current_player(1) ).

% Damit vorherige action points (=0) auch in der ersten Runde exisiteren, sonst err
:- 
	assert( turn_action_points(1, 0) ),
	assert( turn_action_points(2, 0) ).

% Verhindern von "Unknown procedure" in last_turn
:- % player_turn(Player,Turn,Tokens)
	assert( player_turn(1,  0, 0) ),
	assert( player_turn(1, -1, 0) ),
	assert( player_turn(2,  0, 0) ),
	assert( player_turn(2, -1, 0) ).

% Verändern der Player Tokens hierüber
change_player_tokens(TokensNew) :-
	TokensNew >= 0,
	current_player(Player),
	player_tokens(Player, Tokens),
	retract( player_tokens(Player, Tokens) ),
	assert( player_tokens(Player, TokensNew) ).

change_player_tokens_decrement :-
	current_player(Player),
	player_tokens(Player, Tokens),
	TokensDecrement is Tokens - 1,
	change_player_tokens(TokensDecrement).


% Gibt den Betrag der Zahl zurück
betrag(In, Out) :-
	(
		In >= 0,
		Out is In
	), !
	;
	(
		Out is -In
	).


% Prüft ob Einheiten sich in angrenzenden feldern befinden
einheit_attackable(X1, Y1, X2, Y2) :-
	betrag(X1 - X2, Xd),
	betrag(Y1 - Y2, Yd),
	Distance is Xd + Yd,
	Distance < 2.


% Bewegt die Einheit des aktuellen Spielers an position Xold, Yold 
% auf position Xnew, Ynew
einheit_move(Xold, Yold, Xnew, Ynew) :-
	% Den aktuellen Spieler abfragen
	current_player(Player),

	% Es darf keine Einheit auf dem Zielfeld bereits vorhanden sein
	\+ einheit_active(_, _, Xnew, Ynew, _),

	% Errechnen der verbleibenden Tokens
	betrag(Xold - Xnew, Xmove),
	betrag(Yold - Ynew, Ymove),
	player_tokens(Player, Tokens),

	TokensNew is Tokens - Xmove - Ymove,
	TokensNew >= 0,

	% Die vorhandenen Tokens des Spielers aktualisieren
	% Falls der Spieler nicht genug Tokens hat wird das hier false
	change_player_tokens(TokensNew),

	% Die Einheitv on der alten Position nehmen
	retract( einheit_active(Player, Type, Xold, Yold, Defense) ),

	% Die Einheit an die neue Position setzen
	assert( einheit_active(Player, Type, Xnew, Ynew, Defense) ),
	!.


% Lässt zwei Einheiten gegeneinander Kämpfen
% Die Einheit des aktuellen Spielers auf Xattack, Yattack
% greift die Einheit des anderen auf Xdefend, Ydefend an
einheit_attack(Xattack, Yattack, Xdefend, Ydefend) :-
	%Prüfen ob die Einheit angegriffen werden kann
	einheit_attackable(Xattack, Yattack, Xdefend, Ydefend),

	% Player token abziehen für den angriff-move
	% Falls nix übrig wird der angriff abgebrochen da false
	change_player_tokens_decrement,

	% Info für kämpfende Einheiten abrufen
	current_player(Player),
	einheit_active(Player, TypeAttack, Xattack, Yattack, _),
	einheit_active(PlayerDefend, TypeDefend, Xdefend, Ydefend, HP),

	% Friendly Fire verhindern
	\+ Player = PlayerDefend,

	% Info für Einheiten-Typen abrufen
	einheit(TypeAttack, AP, _, _, _, _),
	einheit(TypeDefend, _, _, MultDef, _, _),

	% Mutliplikator für Angriff ermitteln
	feld(Xattack, Yattack, Von),
	feld(Xdefend, Ydefend, Nach),
	feldMultiplier(Von, Nach, MultAP),

	% Finale AP berechnen
	APmitMult is AP * MultAP,

	% Den Kampf durchführen
	(
		(% Entweder die Einheit überlebt
			einheit_alive(APmitMult, HP, HPnew, MultDef),
			retract( einheit_active(PlayerDefend, TypeDefend, 
										Xdefend, Ydefend, HP) ),
			assert( einheit_active(PlayerDefend, TypeDefend, 
										Xdefend, Ydefend, HPnew) )
		), !
		;
		(% Oder halt nicht
			einheit_delete(Xdefend, Ydefend)
		)
	),
	!.


% Lässt eine Einheit bewegen, oder wenn der Platz schon belegt ist, angreifen
% Der Zug wird danach automatisch beendet
einheit_action(Xold, Yold, Xnew, Ynew) :-
	% Sicher gehen, dass nichts out of bounds geht
	Xnew > -1, Xnew < 5,
	Ynew > -1, Ynew < 5,
	
	( % Bewege Einheit oder greife damit an, falls möglich
		einheit_move(Yold, Xold, Ynew, Xnew),
		!;
		einheit_attack(Yold, Xold, Ynew, Xnew)
	),

	(
		current_player(Player),
		player_tokens(Player, Tokens),
		\+ Tokens > 0,
		end_turn, 
		!
		;
		true
	).

einheit_alive(AP, HP, HPnew, HPmult) :-
	% berechnen der differenz nach anwenden des multplikators
	HPwm is HP * HPmult,
	PwmDiff is HPwm - AP,

	% berechnen des Reduktionsverhältnis von HP
	Pratio is PwmDiff / HPwm,

	% berechnen der neuen HP und prüfen ob einheit alive
	HPnew is HP * Pratio,
	HPnew > 0.


% Entfernt eine Einheit vom Spielfeld an Position X, Y
einheit_delete(X, Y) :-
	retract( einheit_active(_, _, X, Y, _) ).


get_color_of_fieldType(FieldTypeInt, Color) :- 
	feldType(_, FieldTypeInt, Color).


% Aktualisieren des aktuellen Spielers geht hiermit
change_player_to(Player) :-
	retract( current_player(_X) ),
	assert( current_player(Player) ).


% Ein Spieler ist entweder current_player oder inactive_player
% je nach dem ob dieser gerade am Zug ist oder nicht
inactive_player(Player) :-
	current_player(Player1),
	player(Player1),
	player(Player),
	Player1 \= Player.

% Das hier muss an jedem Rundenende ausgeführt werden um den
% aktuellen Spieler zu wechseln
change_player :-
	inactive_player(Player),
	change_player_to(Player),
	!.


% game_over ist true wenn das game over ist - surprise surprise
% Gibt den Gewinner zurück
game_over(Winner) :-
	current_player(Active),
	inactive_player(Inactive),
	(
		\+ einheit_active(Inactive,_,_,_,_),
		Winner is Active, !
		;
		\+ einheit_active(Active,_,_,_,_),
		Winner is Inactive
	).



% Falls das Spiel vorbei ist, mach nix
end_turn :-
	game_over(Winner),
	game_over_gui(Winner),
	write("Game Over!"), nl,

	write("Player "),
	write(Winner), 
	write(" wins!"),
	reset_game.

% Beendet den Aktuellen Zug des Spielers
end_turn :-
	% Die verbleibenden Tokens als Turn Speichern
	current_player(Player),
	player_tokens(Player, Tokens),
	last_turn(LastTurn),
	NewTurn is LastTurn + 1,
	assert( player_turn(Player, NewTurn, Tokens) ),

	% Die neue Anzahl an Tokens berechnen und setzen
	calc_tokens(Tcalc),
	change_player_tokens(Tcalc),

	% Den Spieler wechseln
	change_player,!.


% Gibt aus der wie vielte Turn der höchste gespeicherte ist
% für den aktuellen Spieler
last_turn(Turn) :-
	current_player(Player),
	findall(X, player_turn(Player,X,_), Turns),
	max_member(Turn, Turns).

last_turn(Turn) :-
	Turn is 0.


% der shizz hier ist nicht getestet, sollte aber funzen
% Berechnet die Summe aus Tokens des aktuellen und vergangenen Zuges
calc_tokens(Tokens) :-
	% Aktuellen Spieler herausfinden
	current_player(Player),

	% Tokens die Pro Runde dazukommen herausfinden
	player_tokens_per_turn(Player, Tbase),

	% Tokens aus der letzten (aktuellen) und vorletzten Runde holen
	last_turn(LastTurn),
	player_turn(Player, LastTurn, Tlast),

	% Neue Anzahl der Tokens berechnen
	(
		Tlast > Tbase,
		Tokens is 2 * Tbase, !
		;
		Tokens is Tlast + Tbase
	).

