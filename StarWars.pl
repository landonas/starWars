% Name: Landon Soriano



Try these:

?- top([is, it, true, that, mark, hamill, acts, in, star, wars, iv]).

?- top([who, acts, in, star, wars, iv]).

*/

% sources:
% http://www.imdb.com/title/tt0120915/?ref_=nv_sr_3
% http://www.imdb.com/title/tt2488496/?ref_=nv_sr_1
% http://www.imdb.com/title/tt0076759/?ref_=fn_al_tt_1

/* TOP/1

ARG1 is a sentence represented as a list of atoms (e.g. [is, it, true, that, mark, hamill, acts, in, star, wars, iv]).

TOP/1 will succeed or fail. Either way, it should write out a sensible answer.



*/

top(Sentence) :-
  yesno(Query, Sentence, []), % This is a call to the DCG.
  Query, % evaluates the query. Succeeds if true, fails if false.
  write("Yes, that's true").

top(Sentence) :-
  yesno(Query, Sentence, []), % This is a call to the DCG.
  not(Query), % evaluates the query. Succeeds if true, fails if false.
  write("NO, that is wrong").

top(Sentence) :-
 not( yesno (Query, Sentence, []) ) , % This is a call to the DCG.
  write("i dont get it").

top(Sentence) :-
  who(Who, Sentence, []), % This is a call to the DCG.
  write("The person you're looking for is "),
  write(Who). % Can you make this better? It really should write out the text of the answer, not just the symbol.

/* DCG: Here's the grammar. Right now it's very simple. */


who(X) --> [who], verb_phrase(X^_^[Query], [parts_of_speech = _]), {Query}.

yesno(Sem) --> [is, it, true, that], statement(_^_^[Sem]).

yesno(Sem) --> [did], statement(_^_^[Sem]).

yesno(Sem) -->  statement(_^_^[Sem]), [right].

yesno(Sem) -->  statement(_^_^[Sem]), [actor].


% verb list
verb(X^Y^[character(X,Y)],[parts_of_speech = verb]) --> [play].
verb(X^Y^[character(X,Y)],[parts_of_speech = verb]) --> [plays].
verb(X^Y^[actor(X)],[parts_of_speech = verb]) --> [is, an, actor].
verb(X^Y^[director(X)],[parts_of_speech = verb]) --> [is, a, director].
verb(X^Y^[character(X,Y)],[parts_of_speech = verb]) --> [write].


% noun list
  noun_phrase(Sem).
  noun_phrase(Subj ,[parts_of_speech = _] )--> proper_noun(Subj).


%added features

 statement(Subj^Obj^Sem) -->
 noun_phrase(Subj ,[parts_of_speech = _]),
 verb_phrase(Subj^Obj^Sem,[parts_of_speech = _]).


verb_phrase(Subj^Obj^Sem, [parts_of_speech =_]) -->
verb(Subj^Obj^Sem,[ parts_of_speech =verb]),
noun_phrase(Obj, [parts_of_speech = _]).

verb_phrase(Subj^_^Sem, [parts_of_speech =_]) -->
verb(Subj^_^Sem,[parts_of_speech =verb]).


 statement(Subj^Obj^Sem) -->
 noun_phrase(Subj ,[parts_of_speech = _]),
 verb_phrase(Subj^Obj^Sem,[parts_of_speech = _]).


verb_phrase(Subj^Obj^Sem, [parts_of_speech =_]) -->
verb(Subj^Obj^Sem,[ parts_of_speech =verb]),
noun_phrase(Obj, [parts_of_speech = _]).

myappend([], L, L).

myappend([H|T], A, [H|A1]):-
  myappend(T, A, A1).




% edit
statement(Subj^Obj^Sem) --> subquery(Sem2, 0), [and], noun_phrase(Subj ,[parts_of_speech = _] ), verb_phrase(Subj^Obj^Sem1, [parts_of_speech = _]), {myappend(Sem1, Sem2, Sem)}. % recursive call to subquery

subquery(Sem, Depth) --> {Depth < 10}, noun_phrase(Subj ,[parts_of_speech = _]), verb_phrase(Subj^Obj^Sem1 ,[parts_of_speech = _]).           % base case
subquery(Sem, Depth) --> {Depth < 10} , subquery(Sem2, Depth + 1), noun_phrase(Subj ,[parts_of_speech = _]), verb_phrase(Subj^Obj^Sem1, [parts_of_speech = _]) , {myappend(Sem1, Sem2, Sem)}. % recursive case

% custom parts change order

% pairing for movie
proper_noun(star_trek) --> [star, trek].

proper_noun(star_wars1) --> [star, wars, i].
proper_noun(star_wars2) --> [star, wars, ii].
proper_noun(star_wars3) --> [star, wars, iii].
proper_noun(star_wars4) --> [star, wars, iv].
proper_noun(star_wars5) --> [star, wars, v].
proper_noun(star_wars6) --> [star, wars, vi].
proper_noun(star_wars7) --> [star, wars, vii].



verb(X^Y^[acts_in(X,Y)],[parts_of_speech = verb]) --> [acts, in].
verb(X^Y^[character(X,Y)],[parts_of_speech = verb]) --> [play].


/* DATABASE */

% features

proper_noun(actor) --> [actor].
% actor name
proper_noun(mark_hamill) --> [mark, hamill].
proper_noun(harrison_ford) --> [harrison, ford].
proper_noun(carrie_fisher) --> [carrie, fisher].
proper_noun(peter_cushing) --> [peter, cushing].
proper_noun(alec_guinness) --> [alec, guinness].
proper_noun(anthony_daniels) --> [anthony, daniels].
proper_noun(kenny_baker) --> [kenny, baker].
proper_noun(peter_mayhew) --> [peter, mayhew].
proper_noun(david_prowse) --> [david, prowse].
proper_noun(phil_brown) --> [phil, brown].
proper_noun(shelagh_fraser) --> [shelagh, fraser].

proper_noun(liam_nesson) --> [liam, neeson].
proper_noun(ewan_mgregor) --> [ewan, mcgregor].
proper_noun(natalie_portman) --> [natalie, portman].
proper_noun(jake_lloyd) --> [jake, lloyd].
proper_noun(ian_mcdiarmid) --> [ian, mcdiarmid].
proper_noun(pernilla_august) --> [pernilla, august].
proper_noun(oliver_davies) --> [oliver, davies].
proper_noun(hugh_quarshie) --> [hugh, quarshie].
proper_noun(ahmed_best) --> [ahemd, best].
proper_noun(anthony_daniels) --> [anthony, daniels].
proper_noun(kenny_baker) --> [kenny, baker].

% character name
proper_noun(luke_skywalker) --> [luke, skywalker].
proper_noun(han_solo) --> [han, solo].
proper_noun(princess_leia) --> [princess, leia].
proper_noun(grand_moff_tarkin) --> [grand, moff, tarkin].
proper_noun(obi_wan_kenobi) --> [obi, wan, kenobi].
proper_noun(c3p0) --> [c3p0].
proper_noun(r2d2) --> [r2d2].
proper_noun(chewbacca) --> [chewbacca].
proper_noun(darth_vader) --> [darth, vader].
proper_noun(uncle_owen) --> [uncle, owen].
proper_noun(aunt_breu) --> [aunt, breu].
% do for each character

proper_noun(qui_gon_jinn) --> [qui, gon, jinn].
proper_noun(obi_wan_kenobi) --> [obi, wan, kenobi].
proper_noun(queen_amidala) --> [queen, amaidala].
proper_noun(anakin_skywalker) --> [anakin, skywalker].
proper_noun(senator_palpatine) --> [senator, palpatine].
proper_noun(shmi_skywalker) --> [shmi, skywalker].
proper_noun(sio_bibble) --> [sio, bibble].
proper_noun(captain_panaka) --> [captan, panaka].
proper_noun(jar_jar_binks) --> [jar, jar, binks].
proper_noun(c3p0) --> [c3p0].
proper_noun(r2d2) --> [r2d2].




% star wars actor list
actor(mark_hamill).
actor(harrison_ford).
actor(carrie_fisher).
actor(peter_cushing).
actor(alec_guinness).
actor(anthony_daniels).
actor(kenny_baker).
actor(peter_mayhew).
actor(david_prowse).
actor(phil_brown).
actor(shelagh_fraser).

actor(liam_nesson).
actor(ewan_mgregor).
actor(natalie_portman).
actor(jake_lloyd).
actor(ian_mcdiarmid).
actor(pernilla_august).
actor(oliver_davies).
actor(hugh_quarshie).
actor(ahmed_best).
actor(anthony_daniels).
actor(kenny_baker).

character(mark_hamill, luke_skywalker).
character(harrison_ford, han_solo).
character(carrie_fisher, princess_leia).
character(peter_cushing, grand_moff_tarkin).
character(alec_guinness, obi_wan_kenobi).
character(anthony_daniels, c3p0).
character(kenny_baker, r2d2).
character(peter_mayhew, chewbacca).
character(david_prowse, darth_vader).
character(phil_brown, uncle_owen).
character(shelagh_fraser, aunt_breu).

character(liam_nesson, qui_gon_jinn).
character(ewan_mgregor, obi_wan_kenobi).
character(natalie_portman, queen_amidala).
character(jake_lloyd, anakin_skywalker).
character(ian_mcdiarmid, grand_moff_tarkin).
character(pernilla_august, shmi_skywalker).
character(oliver_davies, sio_bibble).
character(hugh_quarshie, captain_panaka).
character(ahmed_best, jar_jar_binks).
character(anthony_daniels, c3p0).
character(kenny_baker, r2d2).

% star wars acts in list
acts_in(mark_hamill, star_wars4).
acts_in(harrison_ford, star_wars4).
acts_in(carrie_fisher, star_wars4).
acts_in(peter_cushing, star_wars4).
acts_in(alec_guinness, star_wars4).
acts_in(anthony_daniels, star_wars4).
acts_in(kenny_baker, star_wars4).
acts_in(peter_mayhew, star_wars4).
acts_in(david_prowse, star_wars4).
acts_in(phil_brown, star_wars4).
acts_in(shelagh_fraser, star_wars4).

acts_in(liam_nesson, star_wars1).
acts_in(ewan_mgregor, star_wars1).
acts_in(natalie_portman, star_wars1).
acts_in(jake_lloyd, star_wars1).
acts_in(ian_mcdiarmid, star_wars1).

% star wars 7
actor(daisy_ridley).
actor(maisie_richarson_sellers).
actor(lupita_nyongo).
actor(adam_driver).
actor(andy_serkis).
actor(billie_lourd).
actor(domhnall_gleeson).
actor(gwendoline_christie).
actor(oscar_issac).
actor(simon_pegg).
actor(john_boyega).

%star wars 7
character(daisy_ridley, rey).
character(maisie_richarson_sellers, korr_sella).
character(lupita_nyongo, maz_kanata).
character(adam_driver, kylo_ren).
character(andy_serkis, supreme_leader_snoke).
character(billie_lourd, unknown).
character(domhnall_gleeson, general_hux).
character(gwendoline_christie, captain_phasma).
character(oscar_issac, poe_dameron).
character(simon_pegg, unknown).
character(john_boyega, finn).

acts_in(daisy_ridley, star_wars7).
acts_in(maisie_richarson_sellers, star_wars7).
acts_in(lupita_nyongo, star_wars7).
acts_in(adam_driver, star_wars7).
acts_in(andy_serkis, star_wars7).
acts_in(billie_lourd, star_wars7).
acts_in(domhnall_gleeson, star_wars7).
acts_in(gwendoline_christie, star_wars7).
acts_in(oscar_issac, star_wars7).
acts_in(simon_pegg, star_wars7).
acts_in(john_boyega, star_wars7).


% star_wars7
proper_noun(rey) --> [rey].
proper_noun(korr_sella) --> [korr, sella].
proper_noun(maz_kanata) --> [maz, kanata].
proper_noun(kylo_ren) --> [kylo, ren].
proper_noun(supreme_leader_snoke) --> [supreme_leader_snoke].
proper_noun(unknown) --> [unknown].
proper_noun(general_hux) --> [general, hux].
proper_noun(captain_phasma) --> [captain, phasma].
proper_noun(poe_dameron) --> [poe, dameron].
proper_noun(unknown) --> [unknown].
proper_noun(finn) --> [finn].

% star wars 7
proper_noun(daisy_ridley) --> [daisy, ridley].
proper_noun(maisie_richarson_sellers) --> [maisie, richarson, sellers].
proper_noun(lupita_nyongo) --> [lupita, nyongo].
proper_noun(adam_driver) --> [adam, driver].
proper_noun(andy_serkis) --> [andy, serkis].
proper_noun(billie_lourd) --> [billie, lourd].
proper_noun(domhnall_gleeson) --> [domhall, gleeson].
proper_noun(gwendoline_christie) --> [gwendoline, christie].
proper_noun(oscar_issac) --> [oscar, issac].
proper_noun(simon_pegg) --> [simon, simon, pegg].
proper_noun(john_boyega) --> [john, boyega].

% actor list
actor(leonard_nimoy).
actor(william_shatner).
actor(deforest_kelley).
actor(nichelle_nichols).
actor(james_doohan).
actor(eddie_paskey).
actor(george_takei).
actor(walter_koeing).
actor(majel_barrett).
actor(john_winston).
actor(paul_baxley).

% character name point
proper_noun(spock) --> [spock].
proper_noun(captain_kirk) -->[captain, kirk].
proper_noun(dr_kelley) -->[dr, kelley].
proper_noun(uhura) --> [uhura].
proper_noun(scott) --> [scott].
proper_noun(lt_leslie) --> [lt, eslie].
proper_noun(sulu) -->[sulu].
proper_noun(chekov)--> [chekov].
proper_noun(nurse_christine_chapel) --> [nurse, christine, chapel].

proper_noun(one_cowboy) --> [one, cowboy].


% character pairing
character(leonard_nimoy, spock).
character(william_shatner, captain_kirk).
character(deforest_kelley, dr_kelley).
character(nichelle_nichols, uhura).
character(james_doohan, scott).
character(eddie_paskey, lt_leslie).
character(george_takei, sulu).
character(walter_koeing, chekov).
character(majel_barrett, nurse, christine, chapel).
character(john_winston, lt_kyle).

character(paul_baxley, one_cowboy).


% acts in pair with movie
acts_in(leonard_nimoy, star_trek).
acts_in(william_shatner, star_trek).
acts_in(deforest_kelley, star_trek).
acts_in(nichelle_nichols, star_trek).
acts_in(james_doohan, star_trek).
acts_in(eddie_paskey, star_trek).
acts_in(george_takei, star_trek).
acts_in(walter_koeing, star_trek).
acts_in(majel_barrett, star_trek).
acts_in(john_winston, star_trek).
acts_in(paul_baxley, star_trek).

% cast list point
proper_noun(leonard_nimoy) --> [leonard, nimoy].
proper_noun(william_shatner) --> [william, shatner].
proper_noun(deforest_kelley) --> [deforest, kelley].
proper_noun(nichelle_nichols) --> [nichelle, nichols].
proper_noun(james_doohan) --> [james, doohan].
proper_noun(eddie_paskey) --> [eddie, paskey].
proper_noun(george_takei) --> [george, takei].
proper_noun(walter_koeing) --> [walter, koeing].
proper_noun(majel_barrett) --> [majel, barrett].
proper_noun(john_winston) --> [john, winston].
proper_noun(paul_baxley) --> [paul, baxley].

%director names
director(george_lucas).

proper_noun(george_lucas) --> [george, lucas].

%director of movie (get real data format is correct)
director_in(george_lucas, star_wars4).
director_in(george_lucas, star_wars5).
director_in(george_lucas, star_wars3).
director_in(george_lucas, star_wars4).
director_in(irvin_kershner, star_wars5).


% movie title
title(a_new_hope).
title(the_phatom_menace).
title(the_empire_strikes_back).
title(return_of_the_jedi).

%movie title pairing
title_of(the_phatom_menace, star_wars1).
title_of(a_new_hope, star_wars4).
