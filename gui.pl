% erstmal nur experimentell, der bums kommt zum schluss
% falls noch zeit sein sollte jedenfalls

% new(@specifier, dialog('windowname'))
% send(@specifiert, append(text_item(name)))
window(Name) :-
	new(D, dialog(Name)),
	send(D, append, button(init, message(@prolog, init_feld1))),
	send(D, append, button(show, message(@prolog, window3, 'Spielfeld'))),
	send(D, append, button(newbutton, message(@prolog, new_butt, D))),
	send(D, open).

window2(Name) :-
	new(D, dialog(Name)),

	feld(0,0,X0),
	send(D, append(new(T1,text(X0)))),
	feld(0,1,X1),
	send(new(_T2,text(X1)), right(T1)),

	send(D, open).


new_butt(D) :-
	send(D, append, button(penis, message(@prolog, init_feld1))).

% Specific für window3/1
:- use_module(library(tabular)).
:- use_module(library(autowin)).

window3(Name) :-
	new(P, auto_sized_picture(Name)),
	send(P, display, new(T, tabular)),
	send(T, border, 1),
	send(T, cell_spacing, -1),
	send(T, rules, all),
	
	feld(0, 0, A),
	feld(0, 1, B),
	feld(0, 2, C),
	feld(0, 3, D),
	feld(0, 4, E),
	feld(1, 0, F),
	feld(1, 1, G),
	feld(1, 2, H),
	feld(1, 3, I),
	feld(1, 4, J),
	feld(2, 0, K),
	feld(2, 1, L),
	feld(2, 2, M),
	feld(2, 3, N),
	feld(2, 4, O),
	feld(3, 0, Px),
	feld(3, 1, Q),
	feld(3, 2, R),
	feld(3, 3, S),
	feld(3, 4, Tx),
	feld(4, 0, U),
	feld(4, 1, V),
	feld(4, 2, W),
	feld(4, 3, X),
	feld(4, 4, Y),

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
			append(A),
			append(B),
			append(C),
			append(D),
			append(E),

			next_row,

			append(1, bold, center),
			append(F),
			append(G),
			append(H),
			append(I),
			append(J),

			next_row,

			append(2, bold, center),
			append(K),
			append(L),
			append(M),
			append(N),
			append(O),

			next_row,

			append(3, bold, center),
			append(Px),
			append(Q),
			append(R),
			append(S),
			append(Tx),

			next_row,

			append(4, bold, center),
			append(U),
			append(V),
			append(W),
			append(X),
			append(Y)


		]),
	send(P, open).