:- use_module(library(tabular)).
:- use_module(library(autowin)).

% new(@specifier, dialog('windowname'))
% send(@specifiert, append(text_item(name)))

heutekeinkoenig :-
	new(D, dialog("Game")),
	openingscreen(D),
	show_image(D),
	send(D, append, button('Start Game', message(@prolog, choose_units))),
	send(D, append, button(reset, message(@prolog, reset_game))),
	new(Label1, label(name,'')),
	new(Label2, label(name,'a game by king cat and sir swi-ear-a-prolot')),
	send(D, append, Label1),
	send(D, append, Label2),
	send(D, open).

openingscreen(D) :-
	new(Label1, label(name,'Herzlich Willkommen zu:')),
	new(Label2, label(name,'Heute kein Koenig - the Game')),
	new(Label3, label(name,'oder auch: Battle for Westnoth - only with guns.')),
	new(Label4, label(name,'Enjoy and remember: all your base are belong to us')),
	new(Label5, label(name,'')),
	send(D, append, Label1),
	send(D, append, Label2),
	send(D, append, Label3),
	send(D, append, Label4),
	send(D, append, Label5).

show_image(D) :-
	new(I, image('i-need-you-cats.gif')),
   	new(B, bitmap(I)),
	new(D2, dialog('')),
	send(D2, display, B),
	send(D2, right, D).

process_choose_units(D, P1U1, P1U2, P1U3, P2U1, P2U2, P2U3) :-
	get(P1U1, selection, Text1U1),
    get(P1U2, selection, Text1U2),
    get(P1U3, selection, Text1U3),
	get(P2U1, selection, Text2U1),
    get(P2U2, selection, Text2U2),
    get(P2U3, selection, Text2U3),
	init_player1(Text1U1, Text1U2, Text1U3),
	init_player2(Text2U1, Text2U2, Text2U3),
	send(D, destroy),
	init_spielfeld('Spielfeld').

choose_units :-
	new(D, dialog('Waehle Einheiten')),
	send(D, append, new(Label0, label(name,'Waehlen Sie Ihre Einheiten. Moegliche Optionen sind: infantry, sniper, tank, motorized'))),
    send(D, append, new(Label1, label(name,'Spieler 1'))),
	send(D, append, new(P1U1,text_item('Unit 1'))),
	send(D, append, new(P1U2,text_item('Unit 2'))),
	send(D, append, new(P1U3,text_item('Unit 3'))),

	send(D, append, new(Label2, label(name,'Spieler 2'))),
	send(D, append, new(P2U1,text_item('Unit 1'))),
	send(D, append, new(P2U2,text_item('Unit 2'))),
	send(D, append, new(P2U3,text_item('Unit 3'))),
	send(D, append, button('Auswahl bestaetigen', message(@prolog, process_choose_units,D , P1U1, P1U2, P1U3, P2U1, P2U2, P2U3))),

	send(D, open).

%TODO delete
change_cell_content(T, Row, Col, NewContent) :- 
	get(T, cell, Row, Col, Cell),
	send(Cell, free),
	send(T, append(NewContent, bold, center, center, Row, Col, blue)).

init_table :- 
	game_window(P),
	new(T, tabular),
	send(T, table_width, 200),
	send(T, border, 1),
	send(T, cell_spacing, -1),
	send(T, rules, all),
	send(P, append, T),
	assert(game_table(T)).

init_spielfeld(Name) :-
	init_feld1,
	
	new(P, dialog(Name)),
    send(P, size, size(400, 200)), % Fenstergröße festlegen
	assert(game_window(P)),
	init_table,
	game_table(T),
	show_controls(P),
	

	spielfeld,


	% Spielfeld öffnen
	send(P, open).

spielfeld :-
	game_window(P),
	game_table(T_old),
	send(T_old, free),
	retract(game_table(T_old)),
	init_table,
	game_table(T),

	%T?for_all(message(@arg1?contents, equal, '1'), message(@arg1, background, red)), % Zelle 1: Rote Hintergrundfarbe
    % T?for_all(message(@arg1?contents, equal, '2'), message(@arg1, background, green)), % Zelle 2: Grüne Hintergrundfarbe

	% Tile Farben setzen
	feld(0, 0, A),
	get_color_of_fieldType(A, Ac),
	feld(0, 1, B),
	get_color_of_fieldType(B, Bc),
	feld(0, 2, C),
	get_color_of_fieldType(C, Cc),
	feld(0, 3, D),
	get_color_of_fieldType(D, Dc),
	feld(0, 4, E),
	get_color_of_fieldType(E, Ec),
	feld(1, 0, F),
	get_color_of_fieldType(F, Fc),
	feld(1, 1, G),
	get_color_of_fieldType(G, Gc),
	feld(1, 2, H),
	get_color_of_fieldType(H, Hc),
	feld(1, 3, I),
	get_color_of_fieldType(I, Ic),
	feld(1, 4, J),
	get_color_of_fieldType(J, Jc),
	feld(2, 0, K),
	get_color_of_fieldType(K, Kc),
	feld(2, 1, L),
	get_color_of_fieldType(L, Lc),
	feld(2, 2, M),
	get_color_of_fieldType(M, Mc),
	feld(2, 3, N),
	get_color_of_fieldType(N, Nc),
	feld(2, 4, O),
	get_color_of_fieldType(O, Oc),
	feld(3, 0, Px),
	get_color_of_fieldType(Px, Pxc),
	feld(3, 1, Q),
	get_color_of_fieldType(Q, Qc),
	feld(3, 2, R),
	get_color_of_fieldType(R, Rc),
	feld(3, 3, S),
	get_color_of_fieldType(S, Sc),
	feld(3, 4, Tx),
	get_color_of_fieldType(Tx, Txc),
	feld(4, 0, U),
	get_color_of_fieldType(U, Uc),
	feld(4, 1, V),
	get_color_of_fieldType(V, Vc),
	feld(4, 2, W),
	get_color_of_fieldType(W, Wc),
	feld(4, 3, X),
	get_color_of_fieldType(X, Xc),
	feld(4, 4, Y),
	get_color_of_fieldType(Y, Yc),

	% Einheiten Symbole fetchen.
	unit_symbol_at_cell(0, 0, As,  Color1),
	unit_symbol_at_cell(0, 1, Bs,  Color2),
	unit_symbol_at_cell(0, 2, Cs,  Color3),
	unit_symbol_at_cell(0, 3, Ds,  Color4),
	unit_symbol_at_cell(0, 4, Es,  Color5),
	unit_symbol_at_cell(1, 0, Fs,  Color6),
	unit_symbol_at_cell(1, 1, Gs,  Color7),
	unit_symbol_at_cell(1, 2, Hs,  Color8),
	unit_symbol_at_cell(1, 3, Is,  Color9),
	unit_symbol_at_cell(1, 4, Js,  Color10),
	unit_symbol_at_cell(2, 0, Ks,  Color11),
	unit_symbol_at_cell(2, 1, Ls,  Color12),
	unit_symbol_at_cell(2, 2, Ms,  Color13),
	unit_symbol_at_cell(2, 3, Ns,  Color14),
	unit_symbol_at_cell(2, 4, Os,  Color15),
	unit_symbol_at_cell(3, 0, Pxs, Color16),
	unit_symbol_at_cell(3, 1, Qs,  Color17),
	unit_symbol_at_cell(3, 2, Rs,  Color18),
	unit_symbol_at_cell(3, 3, Ss,  Color19),
	unit_symbol_at_cell(3, 4, Txs, Color20),
	unit_symbol_at_cell(4, 0, Us,  Color21),
	unit_symbol_at_cell(4, 1, Vs,  Color22),
	unit_symbol_at_cell(4, 2, Ws,  Color23),
	unit_symbol_at_cell(4, 3, Xs,  Color24),
	unit_symbol_at_cell(4, 4, Ys,  Color25),

	% Zellen hinzufügen
	send_list(T, 
		[
			append('', bold, center),
			append(0, bold, center),
			append(1, bold, center),
			append(2, bold, center),
			append(3, bold, center),
			append(4, bold, center),

			next_row,

			append(0, bold, center),
			append(As, bold, center, center, 1, 1, Ac, Color1),
			append(Bs, bold, center, center, 1, 1, Bc, Color2),
			append(Cs, bold, center, center, 1, 1, Cc, Color3),
			append(Ds, bold, center, center, 1, 1, Dc, Color4),
			append(Es, bold, center, center, 1, 1, Ec, Color5),

			next_row,

			append(1, bold, center),
			append(Fs, bold, center, center, 1, 1, Fc, Color6),
			append(Gs, bold, center, center, 1, 1, Gc, Color7),
			append(Hs, bold, center, center, 1, 1, Hc, Color8),
			append(Is, bold, center, center, 1, 1, Ic, Color9),
			append(Js, bold, center, center, 1, 1, Jc, Color10),

			next_row,

			append(2, bold, center),
			append(Ks, bold, center, center, 1, 1, Kc, Color11),
			append(Ls, bold, center, center, 1, 1, Lc, Color12),
			append(Ms, bold, center, center, 1, 1, Mc, Color13),
			append(Ns, bold, center, center, 1, 1, Nc, Color14),
			append(Os, bold, center, center, 1, 1, Oc, Color15),

			next_row,

			append(3, bold, center),
			append(Pxs, bold, center, center, 1, 1,Pxc, Color16),
			append(Qs, bold, center, center, 1, 1, Qc, 	Color17),
			append(Rs, bold, center, center, 1, 1, Rc, 	Color18),
			append(Ss, bold, center, center, 1, 1, Sc, 	Color19),
			append(Txs, bold, center, center, 1, 1,Txc, Color20),

			next_row,

			append(4, bold, center),
			append(Us, bold, center, center, 1, 1, Uc, Color21),
			append(Vs, bold, center, center, 1, 1, Vc, Color22),
			append(Ws, bold, center, center, 1, 1, Wc, Color23),
			append(Xs, bold, center, center, 1, 1, Xc, Color24),
			append(Ys, bold, center, center, 1, 1, Yc, Color25)


		]).

	% Einheiten setzen
	

unit_symbol_at_cell(Row, Col, Symbol, Color) :-
	(
		\+ einheit_active(Player, Type, Row, Col,_),
		!,
		Symbol = '',
		Color = black
	;
		einheit_active(Player, Type, Row, Col,_),
		einheit(Type,_,_,_,_,Symbol),
		player_color(Player, Color),
		!
	).


show_controls(D) :-

	new(Controls, dialog('Steuerung')),
	send(Controls, size, size(400, 300)),

	current_player(Player),
	player_tokens(Player, Tokens),
	string_concat('Aktiv: Spieler ', Player, String_active_player),
	string_concat('Tokens: ', Tokens, String_tokens),

	% die Bausteine zur Steuerung
	send(Controls, append, new(Label1, label(name, String_active_player))),
	send(Controls, append, new(Label4, label(name, String_tokens))),
	send(Controls, append, new(Label2, label(name, 'Einheit waehlen:'))),
	send(Controls, append, new(FromX,text_item('X:'))),
	send(Controls, append, new(FromY,text_item('Y:'))),
	send(Controls, append, new(Label3, label(name, 'Bewegen nach:'))),
	send(Controls, append, new(ToX,text_item('X:'))),
	send(Controls, append, new(ToY,text_item('Y:'))),
	send(Controls, append, button('Bestaetigen',message(@prolog, process_move_unit, FromX, FromY, ToX, ToY, Controls))),
	send(Controls, append, button('Zug Beenden',message(@prolog, process_end_turn))),
	
	send(Controls, open),
	assert(game_control(Controls)).


update_controls :-
	game_window(D),
	game_control(Controls),
	send(Controls, free),
	abolish(game_control/1),
	show_controls(D).

process_move_unit(FromX, FromY, ToX, ToY, Controls) :-
	game_control(Controls),

	get(FromX, selection, FX),
    get(FromY, selection, FY),
    get(ToX, selection, TX),
	get(ToY, selection, TY),

	atom_number(FX, FX2),
	atom_number(FY, FY2),
	atom_number(TX, TX2),
	atom_number(TY, TY2),

	einheit_action(FX2, FY2, TX2, TY2),
	update_controls,
	spielfeld.

process_end_turn :-
	game_control(Controls),
	end_turn,
	update_controls,
	spielfeld.

game_over_gui(Winner) :-
	game_control(C),
	game_window(D),
	new(G, dialog('Winner')),
	new(I, image('win.jpg')),
	new(B, bitmap(I)),
	send(G, display, B),
	atomic_list_concat(['Player ', Winner, ' wins!'], String_result),
	send(G, append, new(Label, label(name, String_result))),
	send(G, open),
	send(C, destroy),
	send(D, destroy).


%TODO delete
test_change :-
	new(D, dialog),
	new(T, tabular),
	send(T, table_width, 200),
	send(T, border, 1),
	send(T, cell_spacing, -1),
	send(T, rules, all),
	send(T, append, new(Cell, table_cell(text('hi')))),
	send(T, append, new(Cell2, table_cell(text('hi2')))),
	send(T, append, new(Cell3, table_cell(text('hi')))),
	send(T, append, new(Cell4, table_cell(text('hi2')))),
	get(T, cell, 1,1, Cell5 ),
	send(Cell5, selection, 'haha'),
	%send(Cell5, free),
	send(D, append, T),
	send(D, open).