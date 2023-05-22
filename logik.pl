% hier kommt der ganze logik bums hin

% globalen Turncounter

player_turn(Player) :-

    % calculate action points
    calc_action_points(Player, Turncounter),


    % further logic




    % save remaining ap
    save_action_points(Player).


% Bewegt die Einheit des Spielers an position Xold, Yold 
% um Xmove, Ymove in die jeweilige Richtung
einheit_move(Player, Xold, Yold, Xmove, Ymove) :-
	% Die Einheit entfernen
	retract( einheit_active(Player, Type, Xold, Yold) ),

	% Neue position berechnen
	Xnew is Xold + Xmove,
	Ynew is Yold + Ymove,

	% Die Einheit an die neue Position setzen
	assert( einheit_active(Player, Type, Xnew, Ynew) ),

	% Errechnen der verbleibenden Tokens
	retract( player_tokens(Player, Tokens) ),
	TokensNew is Tokens - Xmove - Ymove,
	assert( player_tokens(Player, TokensNew) ).