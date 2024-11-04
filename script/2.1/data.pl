male(prince_phillip).
male(prince_charles).
male(prince_andrew).
male(mark_phillips).
male(prince_edward).
male(timothy_laurenc).
male(prince_william).
male(prince_harry).
male(prince_geogre).
male(prince_louis).
male(archie_harrison).
male(peter_phillips).
male(mike_tindall).
male(james_viscount_severn).

female(queen_elizabeth_ii).
female(diana_princess_of_wales).
female(camilla_duchess_of_cornwall).
female(sarah_ferguson).
female(kate_middleton).
female(meghan_markle).
female(princess_anne).
female(sophie_rhys-jones).
female(autumn_phillips).
female(zara_tindall).
female(lady_louise_windsor).
female(princess_eugenie).
female(princess_beatrice).
female(princess_charlotte).

parent(queen_elizabeth_ii, prince_charles).
parent(queen_elizabeth_ii, princess_anne).
parent(queen_elizabeth_ii, prince_andrew).
parent(queen_elizabeth_ii, prince_edward).
parent(prince_philip, prince_charles).
parent(prince_philip, princess_anne).
parent(prince_philip, prince_andrew).
parent(prince_philip, prince_edward).
parent(prince_charles, prince_william).
parent(prince_charles, prince_harry).
parent(diana_princess_of_wales, prince_william).
parent(diana_princess_of_wales, prince_harry).
parent(prince_andrew, princess_beatrice).
parent(prince_andrew, princess_eugenie).
parent(sarah_ferguson, princess_beatrice).
parent(sarah_ferguson, princess_eugenie).
parent(princess_anne, peter_phillips).
parent(princess_anne, zara_tindall).
parent(mark_phillips, peter_phillips).
parent(mark_phillips, zara_tindall).
parent(prince_edward, lady_louise_windsor).
parent(prince_edward, james_viscount_severn).
parent(sophie_rhys_jones, lady_louise_windsor).
parent(sophie_rhys_jones, james_viscount_severn).
parent(prince_william, prince_geogre).
parent(prince_william, princess_charlotte).
parent(prince_william, prince_louis).
parent(kate_middleton, prince_geogre).
parent(kate_middleton, princess_charlotte).
parent(kate_middleton, prince_louis).
parent(prince_harry, archie_harrison).
parent(meghan_markle, archie_harrison).

/* Định nghĩa các quan hệ vợ chồng */
married(prince_charles, diana_princess_of_wales).
married(prince_charles, camilla_duchess_of_cornwall).
married(prince_andrew, sarah_ferguson).
married(prince_william, kate_middleton).
married(prince_harry, meghan_markle).
married(princess_anne, mark_phillips).
married(princess_anne, timothy_laurenc).
married(prince_edward, sophie_rhys-jones).
married(peter_phillips, autumn_phillips).
married(zara_tindall, mike_tindall).


/* Định nghĩa vợ chồng ly hôn */
divorced(prince_charles, diana_princess_of_wales).
divorced(diana_princess_of_wales, prince_charles).
divorced(princess_anne, timothy_laurenc).
divorced(timothy_laurenc, princess_anne).

/* husband */
husband(Person, Wife) :-
    male(Person),
    married(Person, Wife).

/* wife */
wife(Person, Husband) :-
    female(Person),
    married(Person, Husband).

father(Parent, Child) :-
    male(Parent),
    parent(Parent, Child).

mother(Parent, Child) :-
    female(Parent),
    parent(Parent, Child).

child(Child, Parent) :-
    parent(Parent, Child).

son(Child, Parent) :-
    male(Child),
    parent(Parent, Child).

daughter(Child, Parent) :-
    female(Child),
    parent(Parent, Child).

grandparent(GP, GC) :-
    parent(GP, Parent),
    parent(Parent, GC).

grandmother(GM, GC) :-
    female(GM),
    parent(GM, Parent),
    parent(Parent, GC).

grandfather(GF, GC) :-
    male(GF),
    parent(GF, Parent),
    parent(Parent, GC).

grandchild(GC, GP) :-
    parent(GP, Parent),
    parent(Parent, GC).

grandson(GS,GP) :-
    male(GS),
    parent(GP, Parent),
    parent(Parent, GS).

granddaughter(GD, GP) :-
    female(GD),
    parent(GP, Parent),
    parent(Parent, GD).

sibling(Person1, Person2) :-
    setof(Parent, parent(Parent, Person1), Parents1),
    setof(Parent, parent(Parent, Person2), Parents2),
    intersection(Parents1, Parents2, SharedParents),
    length(SharedParents, NumShared),
    NumShared > 0,
    Person1 \= Person2.

brother(Person, Sibling) :-
    sibling(Person, Sibling),
    male(Sibling).

sister(Person, Sibling) :-
    sibling(Person, Sibling),
    female(Sibling).

aunt(Aunt, NieceNephew) :-
  female(Aunt),
  parent(Parent, NieceNephew),
  sibling(Aunt, Parent),
  Aunt \= Parent.

uncle(Uncle, NieceNephew) :-
  male(Uncle),
  parent(Parent, NieceNephew), 
  sibling(Uncle, Parent),     
  Uncle \= Parent.

niece(Niece, AuntUncle) :-
  female(Niece),
  sibling(AuntUncle, Parent),
  parent(Parent, Niece).

nephew(Nephew, AuntUncle) :-
  male(Nephew),
  sibling(AuntUncle, Parent),
  parent(Parent, Nephew).
