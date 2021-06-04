# Reasoning using AISM ontology
Infeering cercus structure in insects using [Ontology for the Anatomy of the Insect SkeletoMuscular system (AISM)](https://github.com/insect-morphology/aism).
 
1. Go to the main directory `AISM_Reasoning` (e.g., `cd /Users/taravser/Documents/My_papers/AISM/Cercus_reasoning/AISM_Reasoning`).

2. Copy the AISM ontology file to `/data` (`scp /Users/taravser/Documents/My_papers/AISM/GitHub/aism/src/ontology/aism-edit.owl  ./data`)

3. Convert AISM file to owl/xml using [ROBOT](http://robot.obolibrary.org).

```{bash}
robot convert --input data/aism-edit.owl --output data/aism-edit.owx
```

4. Merge all imported ontologies into one aims file.

```{bash}
robot merge --input data/aism-edit.owx \
 --output data/aism-merged.owx
```

5. A dd individuals describing "cercus structure" using `make_individuals.R`.

```{bash}
Rscript make_individuals.R
```

6. Run [Konclude](https://github.com/konclude/Konclude) reasoner.

```{bash}
Konclude realization -i data/aism_instances.owl -o results/aism_instances-Konclude.owl
```


7. The realized ontology is `results/aism_instances-Konclude.owl`. This file contains only inferred assertion. Ypu may import it to main ASIM file to see labels.
