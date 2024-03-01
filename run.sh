#!/bin/bash

# Percorsi ai file domain.pddl e problem.pddl
DOMAIN_FILE="./Planning_PDDL/test/domain.pddl"
PROBLEM_FILE="./Planning_PDDL/test/problem.pddl"

# Percorso all'eseguibile di Fast Downward
FAST_DOWNWARD="./downward/fast-downward.py"

# PLANNER="seq-sat-lama-2011"
PLANNER="seq-sat-lama-2011"

# Esegui Fast Downward
# python3 "$FAST_DOWNWARD" --alias "$PLANNER" --plan "$DOMAIN_FILE" "$PROBLEM_FILE"
python3 "$FAST_DOWNWARD" --search "astar(blind())" --plan "$DOMAIN_FILE" "$PROBLEM_FILE"