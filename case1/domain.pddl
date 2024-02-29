(define (domain drone-domain)
    
    (:predicates
        (adj ?from-loc ?to-loc)                     
        (is-in ?sample ?loc)
        (been-at ?drone ?loc)
        (carry ?drone ?sample)  
        (at ?drone ?loc)
        (retrieve-loc ?loc)
        (stored-sample ?sample)
        (loc ?loc)    
        (sample ?sample) 
        (drone ?drone)
        (empty ?drone)                           
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
                (adj ?from-loc ?to-loc))

        :effect 
            (and 
                (at ?drone ?to-loc)
                (been-at ?drone ?to-loc)
                (not (at ?drone ?from-loc)))
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
                (empty ?drone)
                (not (stored-sample ?sample))
                )

        :effect 
            (and 
                (not (is-in ?sample ?loc))
                (carry ?drone ?sample)
                (not (empty ?drone)))
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
                (retrieve-loc ?loc)
                (at ?drone ?loc)
                (carry ?drone ?sample))                     
                           
        :effect 
            (and 
                (is-in ?sample ?loc) 
                (not (carry ?drone ?sample))
                (stored-sample ?sample)
                (empty ?drone))
    )
)
