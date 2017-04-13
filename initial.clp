
(deffacts conversation
	(conversation (questions ) (answers ) (symptoms ) (expert ))
)

(deffacts battery-rules 
	(rule (assertion diagnosis)(if battery is si and battery-drain is si)
		  (then damaged-battery is true with certainty 70)
	)
	
	(rule (assertion diagnosis)(if battery is si and reboot-himself is si)
		  (then damaged-battery is true with certainty 50)
	)
	
	(rule (assertion diagnosis)(if battery is si and deformed-cover is si)
		  (then damaged-battery is true with certainty 20)
	)
	
	(rule (assertion diagnosis)(if battery is si and infalted-battery is si)
		  (then damaged-battery is true with certainty 30)
	)
	
	(rule (assertion diagnosis)(if battery is si and overheat-smartphone is si)
		  (then damaged-battery is true with certainty 40)
	)
	
	(rule (assertion diagnosis)(if battery is si and inactivity-three-months is si)
		  (then damaged-battery is true with certainty 5)
	)
	
	(rule (assertion diagnosis)(if battery is si and not-charge is si and power-supply is si)
		  (then damaged-charger is true with certainty 10)
	)
	
	(rule (assertion diagnosis)(if battery is si and not-charge is si and cable is si)
		  (then damaged-cable is true with certainty 60)
	)
	
	(rule (assertion diagnosis)(if battery is si and not-charge is si and power-supply is no and cable is no)
		  (then damaged-connector is true with certainty 55)
	)
	
	(rule (assertion diagnosis)(if battery is si and job-oxidation is si and green-pin is si)
		  (then damaged-battery-pin is true with certainty 10)
	)
)


(deffacts battery-question
	(question 
		(symptom battery)
		(the-question "Ha problemi che secondo lei siano relativi alla batteria del suo smartphone?")
		(valid-answers si no nonso perche aiuto)
		(exclusions calls slowness microsd display)
	)
	
	(question 
		(symptom battery-drain)
		(the-question "Lo smartphone si scarica piu' rapidamente rispetto a quando lo ha acquistato?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom battery-drain)
		(the-question "Lo smartphone subisce frequenti battery-drain ultimamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is si and battery is si)
		(exclusions not-charge job-oxidation)
		(expert TRUE)
	)
	
	(question 
		(symptom deformed-cover)
		(the-question "Capovolgendo lo smartphone, nota delle deformazioni sulla superficie?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(exclusions not-charge job-oxidation)
		
	)
		
	(question 
		(symptom infalted-battery)
		(the-question "La batteria del suo smartphone risulta essere piu' gonfia del normale?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom overheat-smartphone)
		(the-question "Lo smartphone se tenuto in mano risulta essere sempre molto caldo?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom more-one-year)
		(the-question "Il telefono lo hai da piu' di un anno?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(no-exclusions inactivity-three-months overheat-smartphone infalted-battery deformed-cover battery-drain)
	)
	
	(question 
		(symptom inactivity-three-months)
		(the-question "Lo smartphone e' inutilizzato da piu' di tre mesi?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom reboot-himself)
		(the-question "Il telefono si riavvia da solo?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom not-charge)
		(the-question "Ha l'impressione che ci siano problemi nel processo di ricarica della batteria dello smartphone?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si)
		(exclusions battery-drain deformed-cover infalted-battery overheat-smartphone inactivity-three-months job-oxidation)
	)
	
	(question 
		(symptom not-charge)
		(the-question "La batteria dello smartphone non si carica correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is si and battery is si)
		(expert TRUE)
		(exclusions battery-drain deformed-cover infalted-battery overheat-smartphone inactivity-three-months job-oxidation)
	)
	
	(question 
		(symptom power-supply)
		(the-question "Utilizzando un alimentatore della batteria differente da quello originale, la batteria dello smartphone si ricarica correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si and not-charge is si)
		(exclusions cable)	
	)
	
	(question 
		(symptom power-supply)
		(the-question "Cambiando alimentatore, la batteria dello smartphone si ricarica correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si and not-charge is si)
		(exclusions cable)
	)
	
	(question 
		(symptom cable)
		(the-question "Utilizzando un cavo di alimentazione della batteria differente da quello originale, la batteria dello smartphone si ricarica correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si and not-charge is si)
		(exclusions power-supply)
	)
	
	(question 
		(symptom cable)
		(the-question "Cambiando il cavo di alimentazione, la batteria dello smartphone si ricarica correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is si and battery is si and not-charge is si)
		(exclusions power-supply)
		(expert TRUE)
	)
	
	(question 
		(symptom job-oxidation)
		(the-question "Frequenta spesso ambienti con presenza di umidita' o adiacenti al mare?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
	)
	
	
	(question 
		(symptom green-pin)
		(the-question "I pin(contatti) presenti sulla batteria dello smartphone hanno un colore verdognolo?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is no and battery is si and job-oxidation is si)
	)
	
	(question 
		(symptom green-pin)
		(the-question "I pin della batteria hanno un colore verdognolo?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-battery is si and battery is si and job-oxidation is si)
		(expert TRUE)
	)
)



(deffacts call-rules 
	(rule (assertion diagnosis)(if calls is si and sim is si and reload-more-years is si)
		  (then deactive-sim is true with certainty 30)
	)
	
	(rule (assertion diagnosis)(if calls is si and sim is si and aereo-mode-on is si)
		  (then aereo-mode is true with certainty 90)
	)
	
	(rule (assertion diagnosis)(if calls is si and sim is si and aereo-mode-on is no and reload-more-years is no and other-sim-active is no)
		  (then damaged-slot-sim is true with certainty 90)
	)
	
	(rule (assertion diagnosis)(if calls is si and sim is si and aereo-mode-on is no and reload-more-years is no and other-sim-active is si)
		  (then damaged-sim is true with certainty 85)
	)
	
	(rule (assertion diagnosis)(if calls is si and microphone is si and earphone-active is si)
		  (then damaged-jack is true with certainty 45)
	)
	
	(rule (assertion diagnosis)(if calls is si and microphone is si and low-signal is si)
		  (then provider-problem is true with certainty 70)
	)
	
	(rule (assertion diagnosis)(if calls is si and microphone is si and low-signal is no and earphone-active is no and interlocutor-cant-hear is si)
		  (then damaged-microphone is true with certainty 80)
	)
	
	(rule (assertion diagnosis)(if calls is si and speakerphone is si and earphone-active is si)
		  (then damaged-jack is true with certainty 80)
	)
	
	(rule (assertion diagnosis)(if calls is si and speakerphone is si and volume-off is si)
		  (then sound-off is true with certainty 90)
	)
	
	(rule (assertion diagnosis)(if calls is si and speakerphone is si and volume-off is no and earphone-active is no and speaker is no)
		  (then damaged-speaker is true with certainty 70)
	)
	
	(rule (assertion diagnosis)(if calls is si and speakerphone is si and volume-off is no and earphone-active is no and speaker is si)
		  (then damaged-callspeaker is true with certainty 55)
	)
)

(deffacts call-question
	(question 
		(symptom calls)
		(the-question "Riscontra problemi di vario genere durante le chiamate?")
		(valid-answers si no nonso perche aiuto)
		(exclusions battery slowness microsd display)
	)

	(question 
		(symptom sim)
		(the-question "Ha difficolta' nell'effettuare una telefonata?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si)
		(exclusions microphone speakerphone)
	)
	
	(question 
		(symptom reload-more-years)
		(the-question "La sua ultima ricarica telefonica risale a piu' di un anno fa?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si and sim is si)
		(exclusions aereo-mode-on other-sim-active)
	)
	
	(question 
		(symptom reload-more-years)
		(the-question "La SIM e' disattiva?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is si and calls is si and sim is si)
		(expert TRUE)
		(exclusions aereo-mode-on other-sim-active)
	)
	
	(question 
		(symptom aereo-mode-on)
		(the-question "Nella barra superiore dello schermo, nota la presenza di un'icona di un aereo?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si and sim is si)
		(exclusions reload-more-years other-sim-active)
	)

	(question 
		(symptom other-sim-active)
		(the-question "Sostituendo la sua scheda telefonica con un'altra funzionante, lo smartphone presenta i precedenti problemi?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si and sim is si and reload-more-years is no and aereo-mode-on is no)
	)

	(question 
		(symptom other-sim-active)
		(the-question "Sostituendo la SIM con un'altra funzionante, lo smartphone presenta i precedenti problemi?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is si and calls is si and sim is si and reload-more-years is no and aereo-mode-on is no)
		(expert TRUE)
	)
	
	(question 
		(symptom microphone)
		(the-question "Ha problemi relativi al microfono?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si)
		(exclusions sim speakerphone)
	)
	
	(question 
		(symptom speakerphone)
		(the-question "Durante le chiamate ha difficolta' nel sentire la voce del suo interlocutore?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si)
		(exclusions microphone sim)
	)

	(question 
		(symptom earphone-active)
		(the-question "Nella barra superiore dello schermo e' presente l'icona delle cuffie, pur non avendole collegate?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si and microphone is si)
		(exclusions low-signal interlocutor-cant-hear)
	)
	
	(question 
		(symptom earphone-active)
		(the-question "Nel dislpay e' presente l'icona delle cuffie, pur non avendole collegate?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is si and calls is si and microphone is si)
		(exclusions low-signal interlocutor-cant-hear)
		(expert TRUE)
	)
	
	(question 
		(symptom low-signal)
		(the-question "Sulla barra superiore del suo smartphone, ultimamente riscontra la presenza di una sola tacca del segnale di rete o nessuna?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si and microphone is si)
		(exclusions earphone-active interlocutor-cant-hear)
	)

	(question 
		(symptom low-signal)
		(the-question "Lo smartphone ha frequentemente scarso segnale?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is si and calls is si and microphone is si)
		(exclusions earphone-active interlocutor-cant-hear)
		(expert TRUE)
	)
	
	(question 
		(symptom interlocutor-cant-hear)
		(the-question "Durante le chiamate, attivando il vivavoce, il suo interlocutore riesce a sentire la sua voce?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and microphone is si and earphone-active is no and low-signal is no)
	)

	(question 
		(symptom volume-off)
		(the-question "Durante le chiamate, il volume dello smartphone e' disattivato?") 
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si and speakerphone is si)
		(exclusions earphone-active)
	)	

	(question 
		(symptom speaker)
		(the-question "Se attiva il vivavoce riesce a sentire il suo interlocutore?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is no and calls is si and speakerphone is si and earphone-active is no and volume-off is no)
		(exclusions )
	)	
	
	(question 
		(symptom speaker)
		(the-question "Con il vivavoce attivo sente il suo interlocutore?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-call is si and calls is si and speakerphone is si and earphone-active is no and volume-off is no)
		(exclusions )
		(expert TRUE)
	)
)



(deffacts memory-rules
	(rule (assertion diagnosis)(if slowness is si and slow-application is si)
		  (then busy-cache is true with certainty 30)
	)
	
	(rule (assertion diagnosis)(if slowness is si and slow-application is no and less-ram-1GB is si)
		  (then busy-ram is true with certainty 30)
	)
	
	(rule (assertion diagnosis)(if slowness is si and slow-application is no and less-memory-200MB is si)
		  (then busy-memory is true with certainty 30)
	)

)

(deffacts memory-questions
	(question 
		(symptom slowness)
		(the-question "Il suo smartphone e' relativamente più lento rispetto al acquisto?")
		(valid-answers si no nonso perche aiuto)
		(exclusions calls battery microsd display)
	)
	
	(question 
		(symptom slow-application)
		(the-question "Sono sempre le solite applicazioni ad avere problemi di lentezza?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-memory is no and slowness is si)
	)
	
	(question 
		(symptom slow-application)
		(the-question "La lentezza riguarda una o piu' stesse applicazioni in particolare?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-memory is si and slowness is si)
		(expert TRUE)
	)
	
	(question 
		(symptom less-ram-1GB)
		(the-question "Il dispositivo ha una RAM inferiore ad 1GB?")
		(valid-answers si no nonso perche aiuto)
		(precursors slowness is si and slow-application is no)
		(exclusions less-memory-200MB)
	)

	(question 
		(symptom less-memory-200MB)
		(the-question "La memoria interna disponibile e' inferiore a 200MB?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-memory is no and slowness is si and slow-application is no)
		(exclusions less-ram-1GB)
	)
	
	(question 
		(symptom less-memory-200MB)
		(the-question "La memoria locale disponibile e' inferiore a 200MB?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-memory is si and slowness is si and slow-application is no)
		(exclusions less-ram-1GB)
		(expert TRUE)
	)
)



(deffacts microsd-rules
	(rule (assertion diagnosis)(if microsd is si and microsd-recognized is si)
		  (then unmountable-sd is true with certainty 30)
	)
	
	(rule (assertion diagnosis)(if microsd is si and microsd-recognized is no and other-sd-recognized is si)
		  (then damaged-sd is true with certainty 30)
	)
	
	(rule (assertion diagnosis)(if microsd is si and microsd-recognized is no and other-sd-recognized is no)
		  (then damaged-slot-sd is true with certainty 30)
	)
)

(deffacts microsd-questions
	(question 
		(symptom microsd)
		(the-question "Ha problemi con la memoria esterna?")
		(valid-answers si no nonso perche aiuto)
		(exclusions slowness battery calls display)
	)
	
	(question 
		(symptom microsd-recognized)
		(the-question "La memoria esterna viene segnalata dallo smartphone?")
		(valid-answers si no nonso perche aiuto)
		(exclusions other-sd-recognized)
		(precursors expert-memory is no and microsd is si)
	)
	
	(question 
		(symptom microsd-recognized)
		(the-question "La MicroSD e' stata o si puo' montare?")
		(valid-answers si no nonso perche aiuto)
		(exclusions other-sd-recognized)
		(precursors expert-memory is si and microsd is si)
		(expert TRUE)
	)
	
	(question 
		(symptom other-sd-recognized)
		(the-question "Provando ad inserire altre memorie esterne, queste vengono segnalate dal suo smartphone?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-memory is no and microsd is si and microsd-recognized is no)
		(exclusions microsd-recognized)
	)
	
	(question 
		(symptom other-sd-recognized)
		(the-question "Utilizzando altre MicroSD, queste vengono montate correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors expert-memory is no and microsd is si and microsd-recognized is no)
		(exclusions microsd-recognized)
	)
)



(deffacts display-rules
	(rule (assertion diagnosis)(if display is si and phisic-button is si)
		  (then buttons is true with certainty 100)
	)
	
	(rule (assertion diagnosis)(if display is si and touch is si and total-touch is si)
		  (then broken-display is true with certainty 70 and disconnected-plug is true with certainty 30)
	)
	
	(rule (assertion diagnosis)(if display is si and touch is si and partial-touch is si)
		  (then broken-display is true with certainty 80 and launcher is true with certainty 10)
	)
)

(deffacts display-questions
	(question 
		(symptom display)
		(the-question "Ha problemi con il display o con alcuni tasti?")
		(valid-answers si no nonso perche aiuto)
		(exclusions slowness battery calls microsd)
	)
	
	(question 
		(symptom phisic-button)
		(the-question "Ha qualche tasto danneggiato o malfunzionante?")
		(valid-answers si no nonso perche aiuto)
		(exclusions touch)
		(precursors display is si)
	)
	
	(question 
		(symptom touch)
		(the-question "Il suo smartphone non risponde correttamente ai comandi sullo schermo?")
		(valid-answers si no nonso perche aiuto)
		(exclusions phisic-button)
		(precursors expert-display is no and display is si)
		(expert TRUE)
	)
	
	(question 
		(symptom touch)
		(the-question "Il display touch non risponde correttamente ai comandi?")
		(valid-answers si no nonso perche aiuto)
		(exclusions phisic-button)
		(precursors expert-display is si and display is si)
		(expert TRUE)
	)
	
	(question 
		(symptom total-touch)
		(the-question "Dalla schermata di sblocco, ha difficolta' nello sbloccare lo smartphone?")
		(valid-answers si no nonso perche aiuto)
		(exclusions partial-touch)
		(precursors expert-display is no and display is si and touch is si)
	)
	
	(question 
		(symptom total-touch)
		(the-question "Ha difficolta' nello sbloccare lo smartphone?")
		(valid-answers si no nonso perche aiuto)
		(exclusions partial-touch)
		(precursors expert-display is si and display is si and touch is si)
		(expert TRUE)
	)
	
	(question 
		(symptom partial-touch)
		(the-question "Ha difficolta', nell'aprire l'applicazione telefono, e comporre un qualsiasi numero telefonico?")
		(valid-answers si no nonso perche aiuto)
		(exclusions partial-touch total-touch)
		(precursors expert-display is no and display is si and touch is si)
	)
	
	(question 
		(symptom partial-touch)
		(the-question "Testando il touch del display, riscontra che alcune zone dello schermo non rispondono corettamente ai comandi?")
		(valid-answers si no nonso perche aiuto)
		(exclusions partial-touch total-touch)
		(precursors expert-display is si and display is si and touch is si)
		(expert TRUE)
	)
	
)

;;DOMANDE HC

(deffacts questionHC

	(question 
		(user-question TRUE)
		(symptom brand)
		(the-question "qual'e' la marca del tuo smartphone?")
		(valid-answers samsung huawei aiuto)
		(precursors )
	)
	
	(question 
		(user-question TRUE)
		(symptom OS)
		(the-question "Indicami il sistema operativo del tuo smartphone.")
		(valid-answers lollipop5.1.1 marshmallow6.0 aiuto)
		(precursors )
	)

	(question 
		(user-question TRUE)
		(symptom expert-battery)
		(the-question "Hai provato a far scaricare tutta la batteria e ricaricarla completamente?")
		(valid-answers si no)
		(precursors )
	)
	
	(question 
		(user-question TRUE)
		(symptom expert-display)
		(the-question "Hai controllato se tutta la parte dello schermo non funziona?")
		(valid-answers si no)
		(precursors )
	)
	
	(question 
		(user-question TRUE)
		(symptom expert-call)
		(the-question "Hai provato a sostituire la scheda telefonica?")
		(valid-answers si no)
		(precursors )
	)
	
	(question
		(user-question TRUE)
		(symptom expert-memory)
		(the-question "Hai controllato che non ci siano applicazioni sospette o inutili?")
		(valid-answers si no)
		(precursors )
	)
	
	(question
		(user-question TRUE)
		(symptom expert)
		(the-question "Hai provato a riavviare lo smartphone?")
		(valid-answers si no)
		(precursors )
	)
)

;;REGOLE USER
(deffacts questionHC-rule   
	(rule 
		(assertion symptom)
		(if expert is si)
		  (then expert-battery is si with certainty 50 and expert-call is si with certainty 50 and expert-display is si with certainty 50 and expert-memory is si with certainty 70)
	)
	
	(rule 
		(assertion symptom)
		(if expert-battery is si)
		  (then infalted-battery is no with certainty 40 and deformed-cover is no with certainty 60 and overheat-smartphone is no with certainty 70)
	)
	
	(rule 
		(assertion symptom)
		(if expert-call is si)
		  (then aereo-mode-on is no with certainty 90 and deactive-sim is no with certainty 50 and volume-off is no with certainty 80 and earphone-active is no with certainty 70)
	)
)

