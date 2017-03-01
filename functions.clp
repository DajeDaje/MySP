(deffunction seed-time ()
	(open "time.txt" mytime "r")
	(bind ?a (string-to-field (sub-string 11 11 (read mytime))))
	(seed ?a)
	(printout t ?a crlf)
	(close mytime)
)

(deffunction read-file (?diagn)
	(open (str-cat ?diagn ".txt") File "r")
	(bind ?readed (readline File))
	(while (neq ?readed  EOF)
	(printout t ?readed crlf)
	(bind ?readed (readline File))
	) 
	(close File)
	)

(deffunction ctrl-question (?question $?allowed-values)
	(printout t (str-cat ?question " "))
	(printout t ?allowed-values crlf)
	(bind ?answer (read))
	(if (lexemep ?answer) ;; TRUE is ?answer is a STRING or SYMBOL
		then (bind ?answer (lowcase ?answer)))
	(while (not (member ?answer ?allowed-values)) do
		(printout t ?question)
		(bind ?answer (read))
		(if (lexemep ?answer)
			then (bind ?answer (lowcase ?answer))))
	?answer)

(deffunction ask-question (?question ?symptom $?allowed-values)
	(bind ?response (ctrl-question ?question $?allowed-values))
	
	(while (or (eq ?response help) (eq ?response why))
		(if (eq ?response help)
		then
			(read-file (str-cat "help/" ?symptom))
		else 
			(read-file (str-cat "why/" ?symptom))
		)
		(bind ?response (ctrl-question ?question $?allowed-values))
	)
	(return ?response)
)

(deffunction ask-it (?question ?why ?help)
	(bind ?question (sym-cat ?question " (yes/no/why/help/unknow): "))
	(bind ?response (ask-question ?question yes no why help unknow))
	
	(while (or (eq ?response help) (eq ?response why))
		(if (eq ?response help)
		then
			(read-file (str-cat "help/" ?help))
		else 
			(read-file (str-cat "why/" ?why))
		)
		(bind ?response (ask-question ?question yes no why help unknow))
	)
	(if (eq ?response yes)
		then YES
	else (if (eq ?response no) then NO else UNKNOW)
	)
)
	
(deffunction get-all-facts-by-names ($?names)
	(bind ?facts (create$))
	(progn$ (?f (get-fact-list))
		(if (member$ (fact-relation ?f) $?names)
			then (bind ?facts (create$ ?facts ?f))))
	(return ?facts))

	

(deffunction print-all-facts ()
	(bind ?i 1)
	(bind ?est NULL)
	(progn$ (?f (get-all-facts-by-names diagnosis symptom))
		
		(if (and (eq (fact-relation ?f) symptom) (neq (fact-slot-value ?f established) NOYET))
		then 
			(bind ?est (fact-slot-value ?f established)) 
			(printout t (str-cat (str-cat ?i "- ")  "Alla domanda: ") )
			(read-file (str-cat "questions/" (fact-slot-value ?f name)))
			(printout t (str-cat "hai risposto:" ?est) crlf)	
		)
		(bind ?i (+ ?i 1))
	)
	(return )
)

(deffunction gen-int-list (?n)
	(bind ?list (create$))
	(bind ?count 0)
	(while (neq ?n ?count)
		(bind ?list (create$ ?list (+ ?count 1)))
		(bind ?count (+ ?count 1))
	)
	(return ?list)
)


(deffunction exclude-question ($?names)
	(progn$ (?f (get-all-facts-by-names question))
		(if (and (member$ (fact-slot-value ?f symptom) $?names) (eq (fact-slot-value ?f already-asked) FALSE))
			then (modify ?f (already-asked EXCLUDED))))
	(return )
)

(deffunction exclude-diagnosis ($?names)
	(progn$ (?f (get-all-facts-by-names diagnosis))
		(if (and (member$ (fact-slot-value ?f name) $?names) (eq (fact-slot-value ?f state) FALSE))
			then (modify ?f (state DONE))))
	(return )
)


(deffunction get-answer-by-question (?name)
	(progn$ (?f (get-all-facts-by-names question))
		(if (eq (fact-slot-value ?f name) ?name) then
			(return (fact-slot-value ?f answer))
		)
	)
)

(deffunction print-all-question (?q ?a ?s)
	(bind ?cont 1)
	(progn$ (?question ?q)
		(printout t (str-cat ?cont ") Alla domanda: "))
		(printout t ?question crlf)
		(printout t "hai risposto: ")
		(printout t (nth ?cont ?a) crlf)
		(printout t "ed ha portato al sintomo: ")
		(printout t (nth ?cont ?s) crlf)
		(bind ?cont (+ ?cont 1))
	)
	(return )	
)



(deffunction ask-retract ()
	(printout t "Vuoi cambiare qualcosa dei fatti osservati? yes no" crlf)
	(bind ?answer (read))
	(if (eq ?answer no) then (return))
	(if (neq ?answer yes) then (return))
	(bind ?list (get-all-facts-by-names conversation))
	(bind ?fq (nth 1 ?list)) ;prelevo i fatti questions, answers, symptoms dalla lista dei fatti di tipo conversation
	(bind ?fa (nth 2 ?list))
	(bind ?fs (nth 3 ?list))
	(bind ?q (fact-slot-value ?fq values)) ;prelevo le liste di domande risposte e sintomi dai fatti
	(bind ?a (fact-slot-value ?fa values))
	(bind ?s (fact-slot-value ?fs values))
	(print-all-question ?q ?a ?s)
	(bind ?count 1)
	(printout t "quale fatto vuoi cambiare? ")
	(bind ?from (read))
	(reset)
	
	
	;risponde in automatico alle domande fino a quella precedente alla modifica
	(bind ?all-fact (get-all-facts-by-names question))
	(bind ?lq (create$))
	(bind ?la (create$))
	(bind ?ls (create$))
	
	(while (< ?count ?from) 
		(progn$ (?fact ?all-fact)
			(if (eq (nth ?count ?s) (fact-slot-value ?fact symptom)) then
				(printout t (fact-slot-value ?fact symptom) crlf)
				(if (eq (nth ?count ?a) yes) then (exclude-question (fact-slot-value ?fact exclusions)))
				(printout t (fact-slot-value ?fact exclusions) crlf)
				(modify ?fact (already-asked TRUE))
				(assert (symptom (name (nth ?count ?s)) (value (nth ?count ?a))))
				(bind ?lq (create$ ?lq (nth ?count ?q)))
				(bind ?la (create$ ?la (nth ?count ?a)))
				(bind ?ls (create$ ?ls (nth ?count ?s)))
			)
		)
		(bind ?count (+ ?count 1))
	)
	(bind ?list (get-all-facts-by-names conversation))
	(bind ?fq (nth 1 ?list))
	(bind ?fa (nth 2 ?list))
	(bind ?fs (nth 3 ?list))
	(modify ?fq (values ?lq))
	(modify ?fa (values ?la))
	(modify ?fs (values ?ls))
)
