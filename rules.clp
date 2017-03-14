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
			(no-exclusions $?no-exclusions))
			
	?a <- (conversation (name answers) (values $?answers))
	?q <- (conversation (name questions) (values $?questions))
	?s <- (conversation (name symptoms) (values $?symptoms))
	=>
		(modify ?f (already-asked TRUE))
		(bind ?r (ask-question ?the-question ?the-symptom ?valid-answers))
		(if (eq ?r si) then (exclude-question ?exclusions))
		(if (eq ?r no) then (exclude-question ?no-exclusions))
		(assert (symptom (name ?the-symptom) (value ?r)))
		(retract ?a ?q ?s)
		(assert (conversation (name questions) (values ?questions ?the-question)))
		(assert (conversation (name answers) (values ?answers ?r)))
		(assert (conversation (name symptoms) (values ?symptoms ?the-symptom)))
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
			(no-exclusions $?no-exclusions))
			
	?a <- (conversation (name answers) (values $?answers))
	?q <- (conversation (name questions) (values $?questions))
	?s <- (conversation (name symptoms) (values $?symptoms))
	=>
		(modify ?f (already-asked TRUE))
		(bind ?r (ask-question ?the-question ?the-symptom ?valid-answers))
		(if (eq ?r si) then (exclude-question ?exclusions))
		(if (eq ?r no) then (exclude-question ?no-exclusions))
		(assert (symptom (name ?the-symptom) (value ?r)))
		(retract ?a ?q ?s)
		(assert (conversation (name questions) (values ?questions ?the-question)))
		(assert (conversation (name answers) (values ?answers ?r)))
		(assert (conversation (name symptoms) (values ?symptoms ?the-symptom)))
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

(defrule explain-diagnosis 
	(declare (salience -100))
	(diagnosis (name ?rel) (value ?) (certainty ?per1))
	=>
	(printout t "Diagnosi: ")
	(read-file (str-cat "diagnosis/" ?rel))
	(printout t (str-cat (str-cat "con certezza: " ?per1 )"%") crlf)
	(if (= 0 (length$ (get-all-facts-by-names retraction))) then (assert (retraction)))
)	


(defrule retraction
	(declare (salience -101))
	?r <- (retraction)
	=>
	(retract ?r)
	(ask-retract)
)