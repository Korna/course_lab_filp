domains
  id=integer
  number, date, comment=string
  record=n(id, number, date, comment)
  record_list=record*
  
  transport=t(id, number)
  transport_list=transport*
  
  file=r_b
database
  db_record(record)
  db_transport(transport)
predicates
  init
  main_menu
  search_record_menu
  action(char, symbol)
  get_max_id(id)
  ismax(id)
  print_record(record)
  print_transport(transport)
  search_record_by_id(id, record)
  search_record_by_number(number)
  search_record_by_date(date)
  search_transport_by_id(id, transport)
  search_transport_by_number(number)
clauses
  init:- existfile("r_b.dat"), consult("r_b.dat"), !.
  init:- write("Error while loading r_b.dat."), nl.
main_menu:-
    clearwindow,
    write("**** Datebook ****"), nl,
    write("1. View datebook"), nl,
    write("2. View transport"), nl,
    write("3. Add record"), nl,
    write("4. Add transport"), nl,
    write("5. Edit record"), nl,
    write("6. Edit transport"), nl,
    write("7. Delete record"), nl,
    write("8. Delete transport"), nl,
    write("9. Search record"), nl,
    write("0. Exit"), nl,
    write(">>"), readchar(C), nl, action(C, mm), !, 
	write("Press any key..."), nl,
	readchar(_), main_menu.
search_record_menu:-
    clearwindow,
    write("**** Search record ****"), nl,
    write("1. Search record by ID"), nl,
    write("2. Search transport by ID"), nl,
    write("3. Search record by number"), nl,
    write("4. Search transport by number"), nl,
    write("5. Search record by date"), nl,
    write(">>"), nl, readchar(C), nl, action(C, sm), !, 
	write("Press any key..."), nl, readchar(_), main_menu.
	
action('0', mm):- deletefile("r_b.dat"),
	save("r_b.dat"), exit.
action('1', mm):-
	clearwindow,
	write("**** View datebook ****"), nl,
   	db_record(Record),
	print_record(Record), 
	fail.
action('1', mm).
action('2', mm):-
	clearwindow,
	write("**** View transport ****"), nl,
	db_transport(Transport),
	print_transport(Transport),
	fail.
action('2', mm).
action('3', mm):-
    clearwindow,
    write("**** Add record ****"), nl,
    write("Input number: "), readln(Number),
    write("Input date number: "), readln(Date),
    write("Input comment: "), readln(Comment),
    get_max_id(Id), NewId=Id+1,
    assertz(db_record(n(NewId, Number, Date, Comment))),
    write("The record has been added."), nl.
action('4', mm):-
	clearwindow,
	write("**** Add transport ****"), nl,
	write("Input number"), readln(Number),
	get_max_id(Id), NewId=Id + 1,
	assertz(db_transport(t(NewId, Number))),
	write("The transport has been added."), nl.
action('5', mm):-
    	clearwindow,
    	write("**** Edit record ****"), nl,
    	write("Input ID: "), readint(Id),
    	search_record_by_id(Id, Record),
	write("Input number: "), readln(Number),
    	write("Input date number: "), readln(Date),
    	write("Input commentary: "), readln(Comment),
	retract(db_record(Record)),
    	assertz(db_record(n(Id, Number, Date, Comment))),
    	write("The record has been modified."), nl.
action('5', mm):-
    	write("The record not found."), nl.
action('6', mm):-
	clearwindow,
	write("**** Edit transport ****"), nl,
	write("Input ID: "), readint(Id),
	search_transport_by_id(Id, Transport),
	write("Input number: "), readln(Number),
	retract(db_transport(Transport)),
	assertz(db_transport(t(Id, Number))),
	write("The transport has been modified."), nl.
action('6', mm):-
	write("The transport not found"), nl.
action('7', mm):-
    	clearwindow,
    	write("**** Delete record ****"), nl,
    	write("Input ID: "), readint(Id),
    	search_record_by_id(Id, Record),
	retract(db_record(Record)),
    write("The record has been deleted."), nl.
    
action('7', mm):-
    write("The record not found."), nl.
action('8', mm):-
	clearwindow,
	write("**** Delete transport ****"), nl,
	write("Input ID: "), readint(Id),
	search_transport_by_id(Id, Transport),
	retract(db_transport(Transport)),
	write("The transport has been deleted."), nl.
action('8', mm):-
	write("The transport not found."), nl.
action('9', mm):- search_record_menu.
action('1', sm):-
    clearwindow,
	write("**** Search record by ID ****"), nl,
    write("Input ID: "), readint(Id_),
	search_record_by_id(Id_, Record),
	print_record(Record).
action('1', sm):- write("The record not found."), nl.
action('2', sm):-
	clearwindow,
	write("**** Search transport by ID ****"), nl,
	write("Input ID: "), readint(Id_),
	search_transport_by_id(Id_, Transport),
	print_transport(Transport).
action('2', sm):- write("The transport not found."), nl.
action('3', sm):-
    clearwindow,
	write("**** Search record by number ****"), nl,
    write("Input record number: "), readln(Number_),
	search_record_by_number(Number_).
action('4', sm):-
	clearwindow,
	write("**** Search transport by number ****"), nl,
	write("Input transport number: "), readln(Number_),
	search_transport_by_number(Number_).
action('5', sm):-
    clearwindow,
	write("**** Search by date number ****"), nl,
    write("Input date number: "), readln(Date),
	search_record_by_date(Date).
action(_, _).
get_max_id(MaxId):- db_record(n(MaxId, _, _, _)), ismax(MaxId), !.
get_max_id(0).
ismax(Id):- db_record(n(CurrId, _, _, _)), CurrId > Id, !, fail.
  ismax(_).
print_record(n(Id, Number, Date, Comment)):-
    write("*** RECORD #", Id, " ***"), nl,
	write("Number: ", Number), nl,
	write("Date: ", Date), nl,
	write("Commentary: ", Comment), nl,
	nl.
print_transport(t(Id, Number)):-
	write("*** TRANSPORT #", Id, " ***"), nl,
	write("Number: ", Number), nl,
	nl.
search_record_by_id(Id, Record):- 
	db_record(n(Id, Number, Date, Comment)),
  	Record=n(Id, Number, Date, Comment).
search_transport_by_id(Id, Transport):-
	db_transport(t(Id, Number)),
	Transport=t(Id, Number).
search_record_by_number(Number):- 
  	db_record(n(Id, Number, Date, Comment)),
  	print_record(n(Id, Number, Date, Comment)),
  	fail.
search_record_by_number(_).
search_transport_by_number(Number):-
	db_transport(t(Id, Number)),
	print_transport(t(Id, Number)),
	fail.
search_transport_by_number(_).
search_record_by_date(Date):-
    db_record(n(Id, Number, Date, Comment)),
	print_record(n(Id, Number, Date, Comment)),
	fail.
search_record_by_date(_).
goal
  init,
  main_menu.
