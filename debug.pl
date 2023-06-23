% hier kommt so debug mäßiges zeugs hin

debug_init :-
	init_player1(infantry,infantry,infantry),
	init_player2(infantry,infantry,infantry),
	init_feld1.

debug_calc(Type, Loops) :-
	debug_init,
	debug_run(Type, Loops-1),!.

debug_run(1, Loops) :-
	Loops > 0,
	player_tokens(Player, Tokens),
	write(Tokens), nl,
	end_turn, end_turn,
	debug_run(1, Loops-1).

% default case
debug_run(1, Loops) :-
	player_tokens(Player, Tokens),
	write(Tokens).

debug_run(2, Loops) :-
	einheit_action(0,0,1,1),
	debug_run(1, Loops).

print_info(Type,X,Y,HP) :-
	write("-------"),nl,
	write("Type: "),
	write(Type), nl,

	print_unit(X,Y), nl,

	write("HP: "),
	write(HP),nl.

print_unit(X,Y) :-
	write("X/Y: "),
	write(X),
	write(":"),
	write(Y).

player_info :-
	write("## Player 1 ##"), nl,
	forall(einheit_active(1,Type,X,Y,HP), 
		print_info(Type,X,Y,HP)),

	write("-------"), nl,

	write("Tokens: "),
	player_tokens(1,T1),
	write(T1), nl, nl,

	write("=========="), nl, nl,

	write("## Player 2 ##"), nl,
	forall(einheit_active(2,Type,X,Y,HP), 
		print_info(Type,X,Y,HP)),

	write("-------"), nl,

	write("Tokens: "),
	player_tokens(1,T1),
	write(T1).


quick_game :-
	% Ausgangszustand herstellen
	reset_game,
	init_feld1,
	init_player1(infantry,motorized,sniper),
	init_player2(tank,infantry,infantry),
	player_info, nl, nl,

	write("==============="), nl,
	write("==============="), nl, nl, nl,

	write("Player 1"), nl,
	einheit_move(0,0,1,1),
	write("0:0->1:1"), nl, nl,

	change_player,

	write("Player 2"), nl,
	einheit_move(3,4,3,1),
	write("3:4->3:1"), nl, nl,

	change_player,

	write("Player 1"), nl,
	einheit_attack(1,1,3,1),
	write("1:1-!->3:1"), nl, nl,

	change_player,

	write("Player 2"), nl,
	einheit_attack(3,1,1,1),
	write("3:1-!->1:1"), nl, nl,

	change_player,

	write("Player 1"), nl,
	einheit_attack(1,1,3,1),
	write("1:1-!->3:1"), nl, nl,

	write("==============="), nl,
	write("==============="), nl, nl, nl,

	player_info.