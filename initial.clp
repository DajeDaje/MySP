
(deffacts conversation
	(conversation (name questions ))
	(conversation (name answers ))
	(conversation (name symptoms ))
)

(deffacts battery-rules 
	(rule (if battery is si and battery-drain is si)
		  (then damaged-battery is true with certainty 70)
	)
	
	(rule (if battery is si and deformed-cover is si)
		  (then damaged-battery is true with certainty 20)
	)
	
	(rule (if battery is si and infalted-battery is si)
		  (then damaged-battery is true with certainty 30)
	)
	
	(rule (if battery is si and overheat-smartphone is si)
		  (then damaged-battery is true with certainty 40)
	)
	
	(rule (if battery is si and inactivity-three-months is si)
		  (then damaged-battery is true with certainty 5)
	)
	
	(rule (if battery is si and not-charge is si and power-supply is si)
		  (then damaged-charger is true with certainty 10)
	)
	
	(rule (if battery is si and not-charge is si and cable is si)
		  (then damaged-cable is true with certainty 60)
	)
	
	(rule (if battery is si and not-charge is si and power-supply is no and cable is no)
		  (then damaged-connector is true with certainty 55)
	)
	
	(rule (if battery is si and job-oxidation is si and green-pin is si)
		  (then damaged-battery-pin is true with certainty 10)
	)
)


(deffacts battery-question
	(question 
		(symptom battery)
		(the-question "Hai problemi relativi alla batteria?")
		(valid-answers si no nonso perche aiuto)
		(exclusions calls slowness microsd display)
	)
	
	(question 
		(symptom battery-drain)
		(the-question "Lo smartphone si scarica velocemente?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom deformed-cover)
		(the-question "La cover è deformata?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom infalted-battery)
		(the-question "La batteria è gonfia?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom overheat-smartphone)
		(the-question "Lo smartphone si surriscalda?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom inactivity-three-months)
		(the-question "Lo smartphone e' inutilizzato da piu' di tre mesi?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom not-charge)
		(the-question "Hai problemi nel caricare lo smartphone?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
		(exclusions battery-drain deformed-cover infalted-battery overheat-smartphone inactivity-three-months job-oxidation)
	)
	
	(question 
		(symptom power-supply)
		(the-question "Cambiando alimentatore, lo smartphone carica correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si and not-charge is si)
		(exclusions cable)
	)
	
	(question 
		(symptom cable)
		(the-question "Cambiando il cavo del caricatore, lo smartphone carica correttamente?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si and not-charge is si)
		(exclusions power-supply)
	)
	
	(question 
		(symptom job-oxidation)
		(the-question "Lavori o vivi in ambienti umidi?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si)
	)
	
	(question 
		(symptom green-pin)
		(the-question "I pin della batteria hanno un colore verdognolo?")
		(valid-answers si no nonso perche aiuto)
		(precursors battery is si and job-oxidation is si)
	)
)




(deffacts call-rules 
	(rule (if calls is si and sim is si and reload-more-years is si)
		  (then deactive-sim is true with certainty 30)
	)
	
	(rule (if calls is si and sim is si and aereo-mode-on is si)
		  (then aereo-mode is true with certainty 90)
	)
	
	(rule (if calls is si and sim is si and aereo-mode-on is no and reload-more-years is no and other-sim-active is no)
		  (then damaged-slot-sim is true with certainty 90)
	)
	
	(rule (if calls is si and sim is si and aereo-mode-on is no and reload-more-years is no and other-sim-active is si)
		  (then damaged-sim is true with certainty 85)
	)
	
	(rule (if calls is si and microphone is si and earphone-active is si)
		  (then damaged-jack is true with certainty 45)
	)
	
	(rule (if calls is si and microphone is si and low-signal is si)
		  (then provider-problem is true with certainty 70)
	)
	
	(rule (if calls is si and microphone is si and low-signal is no and earphone-active is no and interlocutor-cant-hear is si)
		  (then damaged-microphone is true with certainty 80)
	)
	
	(rule (if calls is si and speakerphone is si and earphone-active is si)
		  (then damaged-jack is true with certainty 80)
	)
	
	(rule (if calls is si and speakerphone is si and volume-off is si)
		  (then sound-off is true with certainty 90)
	)
	
	(rule (if calls is si and speakerphone is si and volume-off is no and earphone-active is no and speaker is no)
		  (then damaged-speaker is true with certainty 70)
	)
	
	(rule (if calls is si and speakerphone is si and volume-off is no and earphone-active is no and speaker is si)
		  (then damaged-callspeaker is true with certainty 55)
	)
)

(deffacts call-question
	(question 
		(symptom calls)
		(the-question "Riscontri problemi durante le chiamate?")
		(valid-answers si no nonso perche aiuto)
		(exclusions battery slowness microsd display)
	)
	
	;;SIM
	(question 
		(symptom sim)
		(the-question "Hai problemi relativi alla sim?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si)
		(exclusions microphone speakerphone)
	)
	
	(question 
		(symptom reload-more-years)
		(the-question "La tua ultima ricarica telefonica risale a più di un anno fa?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and sim is si)
		(exclusions aereo-mode-on other-sim-active)
	)
	
	(question 
		(symptom aereo-mode-on)
		(the-question "E' presente l'icona della modalità aereo(icona aereoplano)?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and sim is si)
		(exclusions reload-more-years other-sim-active)
	)
	
	(question 
		(symptom other-sim-active)
		(the-question "Lo smartphone legge altre sim?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and sim is si and reload-more-years is no and aereo-mode-on is no)
	)
	
	;;MICROFONO E ALTOPARLANTE
	(question 
		(symptom microphone)
		(the-question "Hai problemi relativi al microfono?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si)
		(exclusions sim speakerphone)
	)
	
	(question 
		(symptom speakerphone)
		(the-question "Durante le chiamate ha dificolta' nel sentire la voce del tuo interlocutore?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si)
		(exclusions microphone sim)
	)
	
	
	;;ENTRAMBE
	(question 
		(symptom earphone-active)
		(the-question "E' presente l'icona delle cuffie, pur non avendole collegate?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and microphone is si)
		(exclusions low-signal interlocutor-cant-hear)
	)
	
	(question 
		(symptom earphone-active)
		(the-question "E' presente l'icona delle cuffie, pur non avendole collegate?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and speakerphone is si)
		(exclusions low-signal interlocutor-cant-hear)
	)
	
	
	;SOLO M
	(question 
		(symptom low-signal)
		(the-question "Risocontri frequentemente problemi di linea?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and microphone is si)
		(exclusions earphone-active interlocutor-cant-hear)
	)
	
	;SOLO M
	(question 
		(symptom interlocutor-cant-hear)
		(the-question "Durante le chiamate il tuo interlocutore riesce a sentire la tua voce col vivavoce attivo?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and microphone is si and earphone-active is no and low-signal is no)
	)
	

	;SOLO A
	(question 
		(symptom volume-off)
		(the-question "Hai il volume relativo all'audio disattivato?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and speakerphone is si)
		(exclusions earphone-active)
	)	
	
	;SOLO A
	(question 
		(symptom speaker)
		(the-question "Se attivi il vivavoce riesci a sentire il tuo interlocutore?")
		(valid-answers si no nonso perche aiuto)
		(precursors calls is si and speakerphone is si and earphone-active is no and volume-off is no)
		(exclusions )
	)	
)



(deffacts memory-rules
	(rule (if slowness is si and slow-application is si)
		  (then busy-cache is true with certainty 30)
	)
	
	(rule (if slowness is si and slow-application is no and less-ram-1GB is si)
		  (then busy-ram is true with certainty 30)
	)
	
	(rule (if slowness is si and slow-application is no and less-memory-200MB is si)
		  (then busy-memory is true with certainty 30)
	)

)

(deffacts memory-questions
	(question 
		(symptom slowness)
		(the-question "Il tuo smartphone e' lento?")
		(valid-answers si no nonso perche aiuto)
		(exclusions calls battery microsd display)
	)
	
	(question 
		(symptom slow-application)
		(the-question "Per caso e' lenta un'applicazione?")
		(valid-answers si no nonso perche aiuto)
		(precursors slowness is si)
	)
	
	(question 
		(symptom less-ram-1GB)
		(the-question "Il dispositivo ha una RAM inferiore ad 1GB ?")
		(valid-answers si no nonso perche aiuto)
		(precursors slowness is si and slow-application is no)
		(exclusions less-memory-200MB)
	)
	
	(question 
		(symptom less-memory-200MB)
		(the-question "La memoria interna disponibile e' inferiore a 200MB?")
		(valid-answers si no nonso perche aiuto)
		(precursors slowness is si and slow-application is no)
		(exclusions less-ram-1GB)
	)
)


(deffacts microsd-rules
	(rule (if microsd is si and microsd-recognized is si)
		  (then unmountable-sd is true with certainty 30)
	)
	
	(rule (if microsd is si and microsd-recognized is no and other-sd-recognized is si)
		  (then damaged-sd is true with certainty 30)
	)
	
	(rule (if microsd is si and microsd-recognized is no and other-sd-recognized is no)
		  (then damaged-slot-sd is true with certainty 30)
	)
)

(deffacts microsd-questions
	(question 
		(symptom microsd)
		(the-question "Hai problemi con la memoria esterna?")
		(valid-answers si no nonso perche aiuto)
		(exclusions slowness battery calls display)
	)
	
	(question 
		(symptom microsd-recognized)
		(the-question "La MicroSD e' riconosciuta dallo smartphone?")
		(valid-answers si no nonso perche aiuto)
		(exclusions other-sd-recognized)
		(precursors microsd is si)
	)
	
	(question 
		(symptom other-sd-recognized)
		(the-question "Provando ad inserire altre microsd vengono riconosciute?")
		(valid-answers si no nonso perche aiuto)
		(precursors microsd is si and microsd-recognized is no)
		(exclusions microsd-recognized)
	)
)



(deffacts display-rules
	(rule (if display is si and phisic-button is si)
		  (then buttons is true with certainty 100)
	)
	
	(rule (if display is si and touch is si and total-touch is si)
		  (then broken-display is true with certainty 70 and disconnected-plug is true with certainty 30)
	)
	
	(rule (if display is si and touch is si and partial-touch is si)
		  (then broken-display is true with certainty 80 and launcher is true with certainty 10)
	)
)

(deffacts display-questions
	(question 
		(symptom display)
		(the-question "Hai problemi con il display o con alcuni tasti?")
		(valid-answers si no nonso perche aiuto)
		(exclusions slowness battery calls microsd)
	)
	
	(question 
		(symptom phisic-button)
		(the-question "Hai qualche tasto danneggiato o malfunzionante?")
		(valid-answers si no nonso perche aiuto)
		(exclusions touch)
		(precursors display is si)
	)
	
	(question 
		(symptom touch)
		(the-question "Il telefono non risponde ai comandi dallo schermo?")
		(valid-answers si no nonso perche aiuto)
		(exclusions phisic-button)
		(precursors display is si)
	)
	
	(question 
		(symptom total-touch)
		(the-question "Non riesci a sbloccare il telefono?")
		(valid-answers si no nonso perche aiuto)
		(exclusions partial-touch)
		(precursors display is si and touch is si)
	)
	
	
	(question 
		(symptom partial-touch)
		(the-question "Aprendo l'applicazione telefono non riesci a comporre il numero senza problemi?")
		(valid-answers si no nonso perche aiuto)
		(exclusions partial-touch total-touch)
		(precursors display is si and touch is si)
	)
	
	(question 
		(symptom partial-touch)
		(the-question "Non riesci ad aprire completamente il menu' a tendina?")
		(valid-answers si no nonso perche aiuto)
		(exclusions partial-touch total-touch)
		(precursors display is si and touch is si)
	)
)

