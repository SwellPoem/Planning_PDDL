(define (domain drone-domain)
    (:requirements :fluents)
    
    (:predicates
        (adj ?from-loc ?to-loc)                     
        (is-in ?sample ?loc)
        (obstacle ?loc)
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

    (:functions
        (battery-amount ?drone)
        (sample-amount ?drone)
        (drill-amount ?drone)

        (battery-capacity)
        (sample-capacity)
        (drill-capacity)

    )
    
    (:action move
        :parameters 
            (?drone
             ?from-loc 
             ?to-loc)

        :precondition 
            (and 
                (drone ?drone)
                (loc ?from-loc)
                (loc ?to-loc) 
                (at ?drone ?from-loc)
                (adj ?from-loc ?to-loc)
                (not (obstacle ?to-loc))
                (> (battery-amount ?drone) 8))

        :effect 
            (and 
                (at ?drone ?to-loc)
                (been-at ?drone ?to-loc)
                (not (at ?drone ?from-loc))
                (decrease (battery-amount ?drone) 8))
    )

    (:action take-sample
        :parameters 
            (?drone 
             ?sample 
             ?loc)

        :precondition 
            (and 
                (drone ?drone)
                (sample ?sample)
                (loc ?loc) 
                (is-in ?sample ?loc)
                (at ?drone ?loc)
                (not (stored-sample ?sample))
                (> (battery-amount ?drone) 3)
                (< (sample-amount ?drone) (sample-capacity))
                (> (drill-amount ?drone) 0)
            )

        :effect 
            (and 
                (not (is-in ?sample ?loc))
                (carry ?drone ?sample)
                (obstacle ?loc)
                (decrease (battery-amount ?drone) 3)
                (increase (sample-amount ?drone) 1)
                (decrease (drill-amount ?drone) 1)
            )
    )
    
    (:action drop-sample
        :parameters 
            (?drone
             ?sample 
             ?loc)

        :precondition 
            (and 
                (drone ?drone)
                (sample ?sample)
                (loc ?loc)
                (is-dropping-dock ?loc)
                (at ?drone ?loc)
                (carry ?drone ?sample)
                (> (battery-amount ?drone) 2))                     
                           
        :effect 
            (and 
                (is-in ?sample ?loc) 
                (not (carry ?drone ?sample))
                (stored-sample ?sample)
                (decrease (battery-amount ?drone) 2)
                (decrease (sample-amount ?drone) 1))
    )
    
    (:action recharge
        :parameters 
            (?drone
             ?loc)
        
        :precondition
	        (and
	            (drone ?drone)
	            (loc ?loc)  
	            (at ?drone ?loc)
	            (is-recharging-dock ?loc) 
	            (< (battery-amount ?drone) 20))
	            
        :effect
            (increase (battery-amount ?drone) 
                (- (battery-capacity) (battery-amount ?drone)))
    )

    (:action changeDrill
        :parameters 
            (?drone)
        
        :precondition
	        (and
	            (drone ?drone)  
	            (< (drill-amount ?drone) 1)
                (> (battery-amount ?drone) 4)
            )
	            
        :effect
            (and
                (increase (drill-amount ?drone) 
                    (- (drill-capacity) (drill-amount ?drone)))
                (decrease (battery-amount ?drone) 4)
            )
    )
)
