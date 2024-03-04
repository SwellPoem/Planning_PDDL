(define (domain drone-domain)
    
    (:predicates
        (adj ?from ?to)                     
        (is-in ?sample ?loc)
        (been-at ?drone ?loc)
        (carry ?drone ?sample)  
        (at ?drone ?loc)
        (is-dropping-dock ?loc)
        (stored-sample ?sample)
        (loc ?loc)    
        (sample ?sample) 
        (drone ?drone)
    )
    
    (:action move
        :parameters 
            (?drone
             ?from 
             ?to)

        :precondition 
            (and 
                (drone ?drone)
                (loc ?from)
                (loc ?to) 
                (at ?drone ?from)
                (adj ?from ?to))

        :effect 
            (and 
                (at ?drone ?to)
                (been-at ?drone ?to)
                (not (at ?drone ?from)))
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
                (at ?drone ?loc))

        :effect 
            (and 
                (not (is-in ?sample ?loc))
                (carry ?drone ?sample))
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
                (carry ?drone ?sample))                     
                           
        :effect 
            (and 
                (is-in ?sample ?loc) 
                (not (carry ?drone ?sample))
                (stored-sample ?sample))
    )
)
