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
	%send(D2, append, B),
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
	spielfeld('Spielfeld').

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
	get(T, cell(Row, Col), Cell),
    send(Cell, clear),
    send(Cell, append, new(Label, text(NewContent))).

spielfeld(Name) :-

	%T?for_all(message(@arg1?contents, equal, '1'), message(@arg1, background, red)), % Zelle 1: Rote Hintergrundfarbe
   % T?for_all(message(@arg1?contents, equal, '2'), message(@arg1, background, green)), % Zelle 2: Grüne Hintergrundfarbe
	
	init_feld1,

	% Controls erstellen
	new(Controls, dialog('Steuerung')),
	send(Controls, size, size(200, 200)),
	send(Controls, append, button('testbutton reset',message(@prolog, reset_game))),

	% Spielfeld erstellen
    new(P, dialog(Name)),
    send(P, size, size(230, 200)), % Fenstergröße festlegen
	new(T, tabular),
	send(T, table_width, 200),
	send(T, border, 1),
	send(T, cell_spacing, -1),
	send(T, rules, all),
	
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
			append(A, bold, center, center, 1, 1, Ac),
			append(B, bold, center, center, 1, 1, Bc),
			append(C, bold, center, center, 1, 1, Cc),
			append(D, bold, center, center, 1, 1, Dc),
			append(E, bold, center, center, 1, 1, Ec),

			next_row,

			append(1, bold, center),
			append(F, bold, center, center, 1, 1, Fc),
			append(G, bold, center, center, 1, 1, Gc),
			append(H, bold, center, center, 1, 1, Hc),
			append(I, bold, center, center, 1, 1, Ic),
			append(J, bold, center, center, 1, 1, Jc),

			next_row,

			append(2, bold, center),
			append(K, bold, center, center, 1, 1, Kc),
			append(L, bold, center, center, 1, 1, Lc),
			append(M, bold, center, center, 1, 1, Mc),
			append(N, bold, center, center, 1, 1, Nc),
			append(O, bold, center, center, 1, 1, Oc),

			next_row,

			append(3, bold, center),
			append(Px, bold, center, center, 1, 1,Pxc),
			append(Q, bold, center, center, 1, 1, Qc),
			append(R, bold, center, center, 1, 1, Rc),
			append(S, bold, center, center, 1, 1, Sc),
			append(Tx, bold, center, center, 1, 1,Txc),

			next_row,

			append(4, bold, center),
			append(U, bold, center, center, 1, 1, Uc),
			append(V, bold, center, center, 1, 1, Vc),
			append(W, bold, center, center, 1, 1, Wc),
			append(X, bold, center, center, 1, 1, Xc),
			append(Y, bold, center, center, 1, 1, Yc)


		]),

	% Einheiten setzen


	% Table an Spielfeld andocken
	send(P, append, T),

	% Controls an Spielfeld andocken
	send(Controls, right, P),
	send(P, open).

