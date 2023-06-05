% hier kommt der ganze logik bums hin

% Der aktuelle Spieler wird hiermit gesetzt damit das später
% nicht bei jedem Aufruf angegeben werden muss
:- assert( current_player(1) ). % das muss so weil sonst err

% Damit vorherige action points (=0) auch in der ersten Runde exisiteren, sonst err
:- 
	assert( turn_action_points(1, 0) ),
	assert( turn_action_points(2, 0) ).

% Aktualisieren des aktuellen Spielers geht hiermit
change_player_to(Player) :-
	retract( current_player(_X) ),
	assert( current_player(Player) ).

% Verändern der Player Tokens hierüber
change_player_tokens(TokensNew) :-
	TokensNew >= 0,
	current_player(Player),
	player_tokens(Player, Tokens)
	retract( player_tokens(Player, Tokens) ),
	assert( player_tokens(Player, TokensNew) ).

change_player_tokens_decrement :-
	current_player(Player),
	player_tokens(Player, Tokens),
	TokensDecrement is Tokens - 1,
	change_player_tokens(TokensDecrement).


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


% globalen Turncounter
player_turn(Player) :-

    % calculate action points
    calc_action_points(Player),


    % further logic



    % end of turn
    % save remaining ap
    save_action_points(Player).


% Gibt den Betrag der Zahl zurück
betrag(Num1, Num2) :-
	(
		Num1 >= 0,
		Num2 is Num1
	), !
	;
	(
		Num2 is -Num1
	).


% Bewegt die Einheit des aktuellen Spielers an position Xold, Yold 
% auf position Xnew, Ynew
einheit_move(Xold, Yold, Xnew, Ynew) :-
	% Den aktuellen Spieler abfragen
	current_player(Player),

	% Die Einheitv on der alten Position nehmen
	retract( einheit_active(Player, Type, Xold, Yold, Defense) ),

	% Die Einheit an die neue Position setzen
	assert( einheit_active(Player, Type, Xnew, Ynew, Defense) ),

	% Errechnen der verbleibenden Tokens
	betrag(Xold - Xnew, Xmove),
	betrag(Yold - Ynew, Ymove),

	TokensNew is Tokens - Xmove - Ymove,
	TokensNew >= 0,

	change_player_tokens(TokensNew).


% Lässt zwei Einheiten gegeneinander Kämpfen
% Die Einheit des aktuellen Spielers auf Xattack, Yattack
% greift die Einheit des anderen auf Xdefend, Ydefend an
einheit_attack(Xattack, Yattack, Xdefend, Ydefend) :-
	% Player token abziehen für den angriff-move
	% Falls nix übrig wird der angriff abgebrochen da false
	change_player_tokens_decrement,

	% Info für kämpfende Einheiten abrufen
	current_player(Player),
	einheit_active(Player, TypeAttack, Xattack, Yattack, _),
	einheit_active(PlayerDefend, TypeDefend, Xdefend, Ydefend, HP),

	% Info für Einheiten-Typen abrufen
	einheit(TypeAttack, AP, _, _, _),
	einheit(TypeDefend, _, _, MultDef, _),

	% Den Kampf durchführen
	(
		(% Entweder die Einheit überlebt
			einheit_alive(AP, HP, HPnew, MultDef),
			retract( einheit_active(PlayerDefend, TypeDefend, 
										Xdefend, Ydefend, HP) ),
			assert( einheit_active(PlayerDefend, TypeDefend, 
										Xdefend, Ydefend, HPnew) )
		)
		;
		(% Oder halt nicht
			einheit_delete(Xdefend, Ydefend)
		)
	),
	!.


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


save_action_points(Player) :-
	turn_action_points(Player, Ap),
	retract( turn_action_points(Player, _) ),
	assert( turn_action_points(Player, Ap) ).


calc_action_points(Player) :-
	% get initial AP at start of game
	player_tokens(Player, FirstRound),

	% get leftover action points from turn before
	turn_action_points(Player, RoundBefore),

	% calculate for new turn
	AP is RoundBefore + FirstRound,

	retract( turn_action_points(Player, _) ),
	assert( turn_action_points(Player, AP)).
	