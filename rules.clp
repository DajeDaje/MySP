;; START

(defrule start 
	(declare (salience 10000))
	=>
	(set-fact-duplication TRUE))

;; QUESTIONS
(defrule ask-a-initial-question
	(declare (salience 1))
	?f <- (question 
			(user-question TRUE)
			(already-asked FALSE)
			(precursors)
			(the-question ?the-question)
			(symptom ?the-symptom)
			(valid-answers $?valid-answers)
			(exclusions $?exclusions)
			(no-exclusions $?no-exclusions)
			(expert ?ex))
	?a <- (conversation (questions $?questions) (answers $?answers) (symptoms $?symptoms) (expert $?experts)) 
	=>
		(modify ?f (already-asked TRUE))
		(bind ?r (ask-question ?the-question ?the-symptom ?ex ?valid-answers))
		(if (eq ?r si) then (exclude-question ?exclusions))
		(if (eq ?r no) then (exclude-question ?no-exclusions))
		(assert (symptom (name ?the-symptom) (value ?r)))
		(retract ?a)
		(assert (conversation (questions $?questions ?the-question) (answers $?answers ?r) (symptoms $?symptoms ?the-symptom) (expert $?experts ?ex)))
)

(defrule ask-a-question
	?f <- (question 
			(user-question FALSE)
			(already-asked FALSE)
			(precursors)
			(the-question ?the-question)
			(symptom ?the-symptom)
			(valid-answers $?valid-answers)
			(exclusions $?exclusions)
			(no-exclusions $?no-exclusions)
			(expert ?ex))
		?a <- (conversation (questions $?questions) (answers $?answers) (symptoms $?symptoms) (expert $?experts)) 
	=>
		(modify ?f (already-asked TRUE))
		(bind ?r (ask-question ?the-question ?the-symptom ?ex ?valid-answers))
		(if (eq ?r si) then (exclude-question ?exclusions))
		(if (eq ?r no) then (exclude-question ?no-exclusions))
		(assert (symptom (name ?the-symptom) (value ?r)))
		(retract ?a)
		(assert (conversation (questions $?questions ?the-question) (answers $?answers ?r) (symptoms $?symptoms ?the-symptom) (expert $?experts ?ex)))
)

(defrule precursor-is-satisfaied
	?f <- (question (already-asked FALSE) (precursors ?name is ?value $?rest))
	(symptom (name ?name) (value ?value | nonso))
	=>
	(if (eq (nth 1 ?rest) and) then (modify ?f (precursors (rest$ ?rest)))
		else (modify ?f (precursors ?rest)))
)

;; RULES
(defrule remove-is-condition-when-satisfied
	?f <- (rule (certainty ?c1)
		(if ?symptom is ?value $?rest))
		(symptom (name ?symptom)
					(value ?value | nonso)
					(certainty ?c2))
	=>
	(modify ?f (certainty (min ?c1 ?c2)) (if (rest$ ?rest)))
)

(defrule perform-rule-consequent-with-certainty
	?f <- (rule (certainty ?c1)
			(assertion diagnosis)
			(if)
			(then ?symptom is ?value with certainty ?c2 $?rest))
	=>
	(modify ?f (then (rest$ ?rest)))
	(assert (diagnosis (name ?symptom)
					(value ?value)
					(certainty (/ (* ?c1 ?c2) 100))))
)

(defrule perform-user-rule-consequent-with-certainty
	?f <- (rule (certainty ?c1)
			(assertion symptom)
			(if)
			(then ?symptom is ?value with certainty ?c2 $?rest))
	=>
	(modify ?f (then (rest$ ?rest)))
	(assert (symptom (name ?symptom)
					(value ?value)
					(certainty (/ (* ?c1 ?c2) 100))))
)

;; CERTAINTY
(defrule combine-certainties
	(declare (salience 100))
	?rem1 <- (diagnosis (name ?rel) (value ?val) (certainty ?per1))
	?rem2 <- (diagnosis (name ?rel) (value ?val) (certainty ?per2))
	(test (neq ?rem1 ?rem2))
	=>
	(retract ?rem1)
	(system (str-cat "CF.exe " ?per1 " " ?per2))
	(modify ?rem2 (certainty (read-file-certainty)))
)

;; DIAGNOSI & SOLUTION

(defrule explain-diagnosis 
	(declare (salience -100))
	?diagn <- (diagnosis (name ?rel) (value ?) (certainty ?per))
	(not (diagnosis (name ?) (value ?) (certainty ?per1 &:(> ?per1 ?per))))
	(symptom (name OS) (value ?os))
	(symptom (name brand) (value ?brand))
	=>
	(retract ?diagn)
	(printout t "Diagnosi: ")
	(read-file (str-cat "diagnosis/" ?rel))
	(printout t (str-cat (str-cat "con certezza: " ?per )"%") crlf)
	(printout t "la soluzione e': " )
	(read-file (str-cat "solutions/" ?brand "/" ?os "/" ?rel))
			(printout t "ti e' stata utile questa soluzione? si no " crlf)
			(bind ?response (read))
			(if (eq ?response si) then (halt) 
				else
						(ask-retract)
				)
)

;; RETRACTION
(defrule retraction
	(declare (salience -101))
	=>
	(printout t "Con queste informazioni non riesco ad aiutarti." crlf)
	(if (eq (ask-retract) FALSE) then (printout t "Spiacente non posso aiutarti, consulta il parere di un esperto." crlf))
)




