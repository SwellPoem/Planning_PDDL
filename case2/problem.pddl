(define (problem drone-battery)

    (:domain 
        drone-domain    
    )
    
    (:objects
        loc1 loc2 loc3 loc4 loc5 loc6 
        loc7 loc8 loc9 loc10 loc11 loc12
        
        sample1 sample2 sample3 sample4 sample5 sample6 sample7 sample8 
        sample9 
        
        drone1
    )
    
    (:init
        (= (battery-capacity) 100)
        
        (loc loc1) (loc loc2) (loc loc3) 
        (loc loc4) (loc loc5) (loc loc6) 
        (loc loc7) (loc loc8) (loc loc9)
        
        (sample sample1) (sample sample2) (sample sample3) (sample sample4)
        (sample sample5) (sample sample6)
        
        
        (adj loc1 loc5) (adj loc1 loc9)
        (adj loc2 loc5) (adj loc3 loc4) 
        (adj loc3 loc6) (adj loc4 loc3) 
        (adj loc4 loc8) (adj loc4 loc9)
        (adj loc5 loc1) (adj loc5 loc2)
        (adj loc6 loc3) (adj loc6 loc7)
        (adj loc6 loc8) (adj loc7 loc6)
        (adj loc8 loc4) (adj loc8 loc6)
        (adj loc9 loc1) (adj loc9 loc4)
        
        
        (is-in sample1 loc2) (is-in sample2 loc3) 
        (is-in sample3 loc9) (is-in sample4 loc8)
        (is-in sample5 loc3) (is-in sample6 loc3)   
        
        (is-recharging-dock loc1)
        (is-dropping-dock loc7)
        
        (drone drone1)
        (at-loc drone1 loc6)
        (= (battery-amount drone1) 40)
    )
    
    (:goal
        (and 
            (stored-sample sample1)
            (stored-sample sample2)
            (stored-sample sample3)
            (stored-sample sample4)
            (stored-sample sample5)
            (stored-sample sample6)    
            
            (at-loc drone1 loc1))
    )
    
    (:metric 
        minimize (battery-amount))
)
