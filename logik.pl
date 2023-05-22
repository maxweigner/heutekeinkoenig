% hier kommt der ganze logik bums hin

% globalen Turncounter

player_turn(Player) :-

    % calculate action points
    calc_action_points(Player, Turncounter),


    % further logic



    % end of turn
    % save remaining ap
    save_action_points(Player).


% Bewegt die Einheit des Spielers an position Xold, Yold 
% um Xmove, Ymove in die jeweilige Richtung
einheit_move(Player, Xold, Yold, Xnew, Ynew) :-
	% Die Einheit entfernen
	retract( einheit_active(Player, Type, Xold, Yold) ),

	% Die Einheit an die neue Position setzen
	assert( einheit_active(Player, Type, Xnew, Ynew) ),

	% Errechnen der verbleibenden Tokens
	retract( player_tokens(Player, Tokens) ),
	% die berechnung muss noch mal angeschaut werden
	TokensNew is Tokens - (Xold - Xnew) - (Xold - Ynew),
	assert( player_tokens(Player, TokensNew) ).