
(deftemplate question
	(slot user-question (default FALSE))
	(slot symptom (default ?NONE))
	(slot the-question (default ?NONE))
	(multislot valid-answers (default ?NONE))
	(slot already-asked (default FALSE))
	(multislot precursors (default ?DERIVE))
	(multislot exclusions)
	(multislot no-exclusions)
	)

(deftemplate symptom
	(slot name (type SYMBOL))
	(slot value (type SYMBOL))
	(slot certainty (default 100.0))
	)
	
(deftemplate diagnosis
	(slot name (type SYMBOL))
	(slot value (type SYMBOL))
	(slot certainty (default 100.0))
	)
	
(deftemplate conversation 
	(slot name)
	(multislot values)
)
	
(deftemplate rule
	(slot certainty (default 100.0))
	(slot assertion)
	(multislot if)
	(multislot then)
)



