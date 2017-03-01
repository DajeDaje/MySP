(deffacts conversation
	(conversation (name questions ))
	(conversation (name answers ))
	(conversation (name symptoms ))
)

(deffacts battery-rules 
	(rule (if battery is yes and battery-drain is yes)
		  (then damaged-battery is true with certainty 70)
	)
	
	(rule (if battery is yes and deformed-cover is yes)
		  (then damaged-battery is true with certainty 20)
	)
	
	(rule (if battery is yes and infalted-battery is yes)
		  (then damaged-battery is true with certainty 30)
	)
	
	(rule (if battery is yes and overheat-smartphone is yes)
		  (then damaged-battery is true with certainty 40)
	)
	
	(rule (if battery is yes and inactivity-three-months is yes)
		  (then damaged-battery is true with certainty 5)
	)
	
	(rule (if battery is yes and not-charge is yes and power-supply is yes)
		  (then damaged-charger is true with certainty 10)
	)
	
	(rule (if battery is yes and not-charge is yes and cable is yes)
		  (then damaged-cable is true with certainty 60)
	)
	
	(rule (if battery is yes and not-charge is yes and power-supply is no and cable is no)
		  (then damaged-connector is true with certainty 55)
	)
	
	(rule (if battery is yes and job-oxidation is yes and green-pin is yes)
		  (then damaged-battery-pin is true with certainty 10)
	)
)


(deffacts battery-question
	(question 
		(symptom battery)
		(the-question "Hai problemi relativi alla batteria?")
		(valid-answers yes no unknow why help)
		(exclusions calls slowness microsd display)
	)
	
	(question 
		(symptom battery-drain)
		(the-question "Lo smartphone si scarica velocemente?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom deformed-cover)
		(the-question "La cover è deformata?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom infalted-battery)
		(the-question "La batteria è gonfia?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom overheat-smartphone)
		(the-question "Lo smartphone si surriscalda?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom inactivity-three-months)
		(the-question "Non usi lo smartphone da piu' di tre mesi?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes)
		(exclusions not-charge job-oxidation)
	)
	
	(question 
		(symptom not-charge)
		(the-question "Hai problemi nel caricare lo smartphone?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes)
		(exclusions battery-drain deformed-cover infalted-battery overheat-smartphone inactivity-three-months job-oxidation)
	)
	
	(question 
		(symptom power-supply)
		(the-question "Cambiando alimentatore, lo smartphone carica correttamente?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes and not-charge is yes)
		(exclusions cable)
	)
	
	(question 
		(symptom cable)
		(the-question "Cambiando il cavo del caricatore, lo smartphone carica correttamente?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes and not-charge is yes)
		(exclusions cable)
	)
	
	(question 
		(symptom job-oxidation)
		(the-question "Lavori o vivi in ambienti umidi?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes)
	)
	
	(question 
		(symptom green-pin)
		(the-question "I pin della batteria hanno un colore verdognolo?")
		(valid-answers yes no unknow why help)
		(precursors battery is yes and job-oxidation is yes)
	)
)




(deffacts call-rules 
	(rule (if calls is yes and sim is yes and reload-more-years is yes)
		  (then deactive-sim is true with certainty 30)
	)
	
	(rule (if calls is yes and sim is yes and aereo-mode-on is yes)
		  (then aereo-mode is true with certainty 90)
	)
	
	(rule (if calls is yes and sim is yes and aereo-mode-on is no and reload-more-years is no and other-sim-active is no)
		  (then damaged-slot-sim is true with certainty 90)
	)
	
	(rule (if calls is yes and sim is yes and aereo-mode-on is no and reload-more-years is no and other-sim-active is yes)
		  (then damaged-sim is true with certainty 85)
	)
	
	(rule (if calls is yes and microphone is yes and earphone-active is yes)
		  (then damaged-jack is true with certainty 45)
	)
	
	(rule (if calls is yes and microphone is yes and low-signal is yes)
		  (then provider-problem is true with certainty 70)
	)
	
	(rule (if calls is yes and microphone is yes and low-signal is no and earphone-active is no and interlocutor-cant-hear is yes)
		  (then damaged-microphone is true with certainty 80)
	)
	
	(rule (if calls is yes and speakerphone is yes and earphone-active is yes)
		  (then damaged-jack is true with certainty 80)
	)
	
	(rule (if calls is yes and speakerphone is yes and volume-off is yes)
		  (then sound-off is true with certainty 90)
	)
	
	(rule (if calls is yes and speakerphone is yes and volume-off is no and earphone-active is no and speaker is no)
		  (then damaged-speaker is true with certainty 70)
	)
	
	(rule (if calls is yes and speakerphone is yes and volume-off is no and earphone-active is no and speaker is yes)
		  (then damaged-callspeaker is true with certainty 55)
	)
)

(deffacts call-question
	(question 
		(symptom calls)
		(the-question "Riscontri problemi durante le chiamate?")
		(valid-answers yes no unknow why help)
		(exclusions battery slowness microsd display)
	)
	
	;;SIM
	(question 
		(symptom sim)
		(the-question "Hai problemi relativi alla sim?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes)
		(exclusions microphone speakerphone)
	)
	
	(question 
		(symptom reload-more-years)
		(the-question "La tua ultima ricarica telefonica risale a più di un anno fa?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and sim is yes)
		(exclusions aereo-mode-on other-sim-active)
	)
	
	(question 
		(symptom aereo-mode-on)
		(the-question "E' presente l'icona della modalità aereo(icona aereoplano)?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and sim is yes)
		(exclusions reload-more-years other-sim-active)
	)
	
	(question 
		(symptom other-sim-active)
		(the-question "Lo smartphone legge altre sim?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and sim is yes and reload-more-years is no and aereo-mode-on is no)
	)
	
	;;MICROFONO E ALTOPARLANTE
	(question 
		(symptom microphone)
		(the-question "Hai problemi relativi al microfono?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes)
		(exclusions sim speakerphone)
	)
	
	(question 
		(symptom speakerphone)
		(the-question "Durante le chiamate ha dificolta' nel sentire la voce del tuo interlocutore?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes)
		(exclusions microphone sim)
	)
	
	
	;;ENTRAMBE
	(question 
		(symptom earphone-active)
		(the-question "E' presente l'icona delle cuffie, pur non avendole collegate?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and microphone is yes)
		(exclusions low-signal interlocutor-cant-hear)
	)
	
	(question 
		(symptom earphone-active)
		(the-question "E' presente l'icona delle cuffie, pur non avendole collegate?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and speakerphone is yes)
		(exclusions low-signal interlocutor-cant-hear)
	)
	
	
	;SOLO M
	(question 
		(symptom low-signal)
		(the-question "Risocontri frequentemente problemi di linea?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and microphone is yes)
		(exclusions earphone-active interlocutor-cant-hear)
	)
	
	;SOLO M
	(question 
		(symptom interlocutor-cant-hear)
		(the-question "Durante le chiamate il tuo interlocutore riesce a sentire la tua voce col vivavoce attivo?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and microphone is yes and earphone-active is no and low-signal is no)
	)
	

	;SOLO A
	(question 
		(symptom volume-off)
		(the-question "Hai il volume relativo all'audio disattivato?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and speakerphone is yes)
		(exclusions earphone-active)
	)	
	
	;SOLO A
	(question 
		(symptom speaker)
		(the-question "Se attivi il vivavoce riesci a sentire il tuo interlocutore?")
		(valid-answers yes no unknow why help)
		(precursors calls is yes and speakerphone is yes and earphone-active is no and volume-off is no)
		(exclusions )
	)	
)



(deffacts memory-rules
	(rule (if slowness is yes and slow-application is yes)
		  (then busy-cache is true with certainty 30)
	)
	
	(rule (if slowness is yes and slow-application is no and less-ram-1GB is yes)
		  (then busy-ram is true with certainty 30)
	)
	
	(rule (if slowness is yes and slow-application is no and less-memory-200MB is yes)
		  (then busy-memory is true with certainty 30)
	)

)

(deffacts memory-questions
	(question 
		(symptom slowness)
		(the-question "Il tuo smartphone e' lento?")
		(valid-answers yes no unknow why help)
		(exclusions calls battery microsd display)
	)
	
	(question 
		(symptom slow-application)
		(the-question "Per caso e' lenta un'applicazione?")
		(valid-answers yes no unknow why help)
		(precursors slowness is yes)
	)
	
	(question 
		(symptom less-ram-1GB)
		(the-question "Il dispositivo ha una RAM inferiore ad 1GB ?")
		(valid-answers yes no unknow why help)
		(precursors slowness is yes and slow-application is no)
		(exclusions less-memory-200MB)
	)
	
	(question 
		(symptom less-memory-200MB)
		(the-question "La memoria interna disponibile e' inferiore a 200MB?")
		(valid-answers yes no unknow why help)
		(precursors slowness is yes and slow-application is no)
		(exclusions less-ram-1GB)
	)
)


(deffacts microsd-rules
	(rule (if microsd is yes and microsd-recognized is yes)
		  (then unmountable-sd is true with certainty 30)
	)
	
	(rule (if microsd is yes and microsd-recognized is no and other-sd-recognized is yes)
		  (then damaged-sd is true with certainty 30)
	)
	
	(rule (if microsd is yes and microsd-recognized is no and other-sd-recognized is no)
		  (then damaged-slot-sd is true with certainty 30)
	)
)

(deffacts microsd-questions
	(question 
		(symptom microsd)
		(the-question "Hai problemi con la memoria esterna?")
		(valid-answers yes no unknow why help)
		(exclusions slowness battery calls display)
	)
	
	(question 
		(symptom microsd-recognized)
		(the-question "La MicroSD e' riconosciuta dallo smartphone?")
		(valid-answers yes no unknow why help)
		(exclusions other-sd-recognized)
		(precursors microsd is yes)
	)
	
	(question 
		(symptom other-sd-recognized)
		(the-question "Provando ad inserire altre microsd vengono riconosciute?")
		(valid-answers yes no unknow why help)
		(precursors microsd is yes and microsd-recognized is no)
		(exclusions microsd-recognized)
	)
)



(deffacts display-rules
	(rule (if display is yes and phisic-button is yes)
		  (then buttons is true with certainty 100)
	)
	
	(rule (if display is yes and touch is yes and total-touch is yes)
		  (then broken-display is true with certainty 70 and disconnected-plug is true with certainty 30)
	)
	
	(rule (if display is yes and touch is yes and partial-touch is yes)
		  (then broken-display is true with certainty 80 and launcher is true with certainty 10)
	)
)

(deffacts display-questions
	(question 
		(symptom display)
		(the-question "Hai problemi con il display o con alcuni tasti?")
		(valid-answers yes no unknow why help)
		(exclusions slowness battery calls microsd)
	)
	
	(question 
		(symptom phisic-button)
		(the-question "Hai qualche tasto danneggiato o malfunzionante?")
		(valid-answers yes no unknow why help)
		(exclusions touch)
		(precursors display is yes)
	)
	
	(question 
		(symptom touch)
		(the-question "Il telefono non risponde ai comandi dallo schermo?")
		(valid-answers yes no unknow why help)
		(exclusions phisic-button)
		(precursors display is yes)
	)
	
	(question 
		(symptom total-touch)
		(the-question "Non riesci a sbloccare il telefono?")
		(valid-answers yes no unknow why help)
		(exclusions partial-touch)
		(precursors display is yes and touch is yes)
	)
	
	
	(question 
		(symptom partial-touch)
		(the-question "Aprendo l'applicazione telefono non riesci a comporre il numero senza problemi?")
		(valid-answers yes no unknow why help)
		(exclusions partial-touch total-touch)
		(precursors display is yes and touch is yes)
	)
	
	(question 
		(symptom partial-touch)
		(the-question "Non riesci ad aprire completamente il menu' a tendina?")
		(valid-answers yes no unknow why help)
		(exclusions partial-touch total-touch)
		(precursors display is yes and touch is yes)
	)
)
