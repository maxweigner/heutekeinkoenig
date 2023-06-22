:- use_module(library(tabular)).
:- use_module(library(autowin)).

% new(@specifier, dialog('windowname'))
% send(@specifiert, append(text_item(name)))

window :-
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

change_cell_content(T, Row, Col, NewContent) :- 
	get(T, cell, Row, Col, Cell),
	send(Cell, free),
	send(T, append(NewContent, bold, center, center, Row, Col, blue)).

init_spielfeld(Name) :-
	init_feld1,

	new(P, dialog(Name)),
    send(P, size, size(230, 200)), % Fenstergröße festlegen
	new(T, tabular),
	send(T, table_width, 200),
	send(T, border, 1),
	send(T, cell_spacing, -1),
	send(T, rules, all),
	
	% Window und Tabelle speichern
	assert(game_window(P)),
	assert(game_table(T)),

	spielfeld(Name),

	% Table an Spielfeld andocken
	send(P, append, T),

	
	

	% Controls an Spielfeld andocken
	show_controls(P),

	% Spielfeld öffnen
	send(P, open).

spielfeld(Name) :-
	game_window(P),
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
	unit_symbol_at_cell(0, 0, As),
	unit_symbol_at_cell(0, 1, Bs),
	unit_symbol_at_cell(0, 2, Cs),
	unit_symbol_at_cell(0, 3, Ds),
	unit_symbol_at_cell(0, 4, Es),
	unit_symbol_at_cell(1, 0, Fs),
	unit_symbol_at_cell(1, 1, Gs),
	unit_symbol_at_cell(1, 2, Hs),
	unit_symbol_at_cell(1, 3, Is),
	unit_symbol_at_cell(1, 4, Js),
	unit_symbol_at_cell(2, 0, Ks),
	unit_symbol_at_cell(2, 1, Ls),
	unit_symbol_at_cell(2, 2, Ms),
	unit_symbol_at_cell(2, 3, Ns),
	unit_symbol_at_cell(2, 4, Os),
	unit_symbol_at_cell(3, 0, Pxs),
	unit_symbol_at_cell(3, 1, Qs),
	unit_symbol_at_cell(3, 2, Rs),
	unit_symbol_at_cell(3, 3, Ss),
	unit_symbol_at_cell(3, 4, Txs),
	unit_symbol_at_cell(4, 0, Us),
	unit_symbol_at_cell(4, 1, Vs),
	unit_symbol_at_cell(4, 2, Ws),
	unit_symbol_at_cell(4, 3, Xs),
	unit_symbol_at_cell(4, 4, Ys),

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
			append(As, bold, center, center, 1, 1, Ac),
			append(Bs, bold, center, center, 1, 1, Bc),
			append(Cs, bold, center, center, 1, 1, Cc),
			append(Ds, bold, center, center, 1, 1, Dc),
			append(Es, bold, center, center, 1, 1, Ec),

			next_row,

			append(1, bold, center),
			append(Fs, bold, center, center, 1, 1, Fc),
			append(Gs, bold, center, center, 1, 1, Gc),
			append(Hs, bold, center, center, 1, 1, Hc),
			append(Is, bold, center, center, 1, 1, Ic),
			append(Js, bold, center, center, 1, 1, Jc),

			next_row,

			append(2, bold, center),
			append(Ks, bold, center, center, 1, 1, Kc),
			append(Ls, bold, center, center, 1, 1, Lc),
			append(Ms, bold, center, center, 1, 1, Mc),
			append(Ns, bold, center, center, 1, 1, Nc),
			append(Os, bold, center, center, 1, 1, Oc),

			next_row,

			append(3, bold, center),
			append(Pxs, bold, center, center, 1, 1,Pxc),
			append(Qs, bold, center, center, 1, 1, Qc),
			append(Rs, bold, center, center, 1, 1, Rc),
			append(Ss, bold, center, center, 1, 1, Sc),
			append(Txs, bold, center, center, 1, 1,Txc),

			next_row,

			append(4, bold, center),
			append(Us, bold, center, center, 1, 1, Uc),
			append(Vs, bold, center, center, 1, 1, Vc),
			append(Ws, bold, center, center, 1, 1, Wc),
			append(Xs, bold, center, center, 1, 1, Xc),
			append(Ys, bold, center, center, 1, 1, Yc)


		]).

	% Einheiten setzen
	

unit_symbol_at_cell(Row, Col, Symbol) :-
	(
		\+ einheit_active(_, Type, Row, Col,_),
		!,
		Symbol = ''
	;
		einheit_active(_, Type, Row, Col,_),
		einheit(Type,_,_,_,_,Symbol)
	).


show_controls(D) :-

	new(Controls, dialog('Steuerung')),
	send(Controls, size, size(200, 200)),

	current_player(Player),
	string_concat('Aktiv: Spieler ', Player, String_active_player),

	% die Bausteine zur Steuerung
	send(Controls, append, new(Label1, label(name, String_active_player))),
	send(Controls, append, button('testbutton reset',message(@prolog, reset_game))),

	send(Controls, right, D).

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