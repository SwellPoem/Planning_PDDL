(define (domain drone-domain)

    (:requirements :durative-actions :fluents :duration-inequalities)

    (:functions
        (battery-amount ?drone)
        (recharge-rate ?drone)
        (battery-capacity)
    )

    (:predicates
	    (adj ?from-loc ?to-loc)                      
        (is-in ?sample ?loc)
        (been-at ?drone ?loc)
        (carry ?drone ?sample)  
        (at ?drone ?loc)
        (is-recharging-dock ?loc)
        (is-dropping-dock ?loc)
        (stored-sample ?sample)
        (loc ?loc)    
        (sample ?sample) 
        (drone ?drone)              
	)
	     
    (:durative-action move
        :parameters 
            (?drone
             ?from-loc 
             ?to-loc)
        
        :duration 
            (= ?duration 5)
        
        :condition
	        (and 
	            (at start (drone ?drone)) 
	            (at start (loc ?from-loc)) 
	            (at start (loc ?to-loc)) 
	            (over all (adj ?from-loc ?to-loc)) 
	            (at start (at ?drone ?from-loc)) 
	            (at start (> (battery-amount ?drone) 8)))
	            
        :effect
	        (and 
	            (at end (at ?drone ?to-loc))
	            (at end (been-at ?drone ?to-loc))
	            (at start (not (at ?drone ?from-loc))) 
	            (at start (decrease (battery-amount ?drone) 8)))
	)

    (:durative-action take-sample
        :parameters 
            (?drone 
             ?sample 
             ?loc)
        
        :duration 
            (= ?duration 8)
        
        :condition
	        (and 
	            (at start (drone ?drone)) 
	            (at start (loc ?loc)) 
	            (over all (at ?drone ?loc)) 
	            (at start (at ?drone ?loc)) 
	            (at start (>= (battery-amount ?drone) 5)) 
	            (at start (is-in ?sample ?loc))
            )
            
        :effect
	        (and 
	            (at end (not (is-in ?sample ?loc))) 
	            (at start (decrease (battery-amount ?drone) 5)) 
	            (at end (carry ?drone ?sample))
            )    
	)

    (:durative-action drop-sample
        :parameters 
            (?drone
             ?sample
             ?loc)
        
        :duration 
            (= ?duration 1)
        
        :condition
            (and
                (at start (drone ?drone))
                (at start (sample ?sample))
                (at start (loc ?loc))
                (at start (is-dropping-dock ?loc))
                (over all (at ?drone ?loc))
                (at start (at ?drone ?loc))
                (at start (carry ?drone ?sample))
                (at start (> (battery-amount ?drone) 2)))
        
        :effect 
        	(and 
                (at end (is-in ?sample ?loc))
                (at end (not (carry ?drone ?sample)))
                (at end (stored-sample ?sample))
                (at start (decrease (battery-amount ?drone) 2))
            )	    
    )
    
    (:durative-action recharge
        :parameters 
            (?drone
             ?loc)
        
        :duration 
            (= ?duration 
                (/ (- (battery-capacity) (battery-amount ?drone)) (recharge-rate ?drone)))
                ; (/ (- 80 (battery-amount ?drone)) (recharge-rate ?drone)))

        :condition
	        (and 
	            (at start (drone ?drone)) 
	            (at start (loc ?loc)) 
	            (at start (at ?drone ?loc)) 
	            (over all (at ?drone ?loc)) 
	            (at start (is-recharging-dock ?loc)) 
	            (at start (< (battery-amount ?drone) 80)))
     
        :effect
	        (at end 
	            (increase (battery-amount ?drone) 
	                (* ?duration (recharge-rate ?drone))))
	)
)
