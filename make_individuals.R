
### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Make individulas in AISM ontology                                       ####
#
# This R script is a wrapper for python Owlready2 function to create individuals 
# in AISM ontology. These individuals describe cercus across different insect orders.
#
#---------------------------------------------------------------------------------

#------------------------ Usefule Terms
# obo.AISM_0004097 # tergite 8
# obo.AISM_0004117 # tergite 9
# obo.AISM_0004118 # tergite 10
# obo.RO_0002170 # connected to
# obo.AISM_0000062 # ring sclerite
# obo.AISM_0000029 # appendage
# obo.RO_0002150 # continuos with
# obo.OBI_0100026 # organism
# obo.BFO_0000051 # has_part
# BFO_0000050 # part of
# obo.BFO_0000030 # object
# BSPO_0000106 # contralateral to
# obo.AISM_0004165 # cercus
# obo.AISM_0004056 # postabdomen
# AISM_0000008 # protrusion
# AISM_0000519 #encicles via conjunctiva
# AISM_0000538 #encicleD via conjunctiva
# AISM:0000523 # dorsal postabdomen
# AISM_0000522 # paired
# AISM_0000008 # cuticular protrusion
# AISM_0000003 #sclerite
#---------------------------------------

# !!! change to your directory here
setwd("~/Documents/My_papers/AISM/Cercus_reasoning/AISM_Reasoning")


library(reticulate)
library(dplyr)
source("make_individuals_Functions.R")

# read in ontology
py_run_file(file="read_ontology.py", local = FALSE, convert = FALSE)


# CREATE INDIVIDUALS

#   ____________________________________________________________________________
#   Zygentoma                                                               ####

SPECIES='Zygentoma'
# tergite9: "AISM_0004117" 
BASE="AISM_0004118" # tergite10 but should be 11

# make Organism
#py_run_string('dwc.Organism("sp1")', local = FALSE, convert = F)
spec <- paste0('dwc.Organism("', SPECIES, '")')
py_run_string(spec, local = FALSE, convert = F)

# make sequence of 4 sclerites that is an appendage
make_instance_seq(n=4, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000003", functional.class="AISM_0000029",
                  instance.name="_sclerite_",  namespace="obo", link="AISM_0000519")

# make_instance_seq(n=4, prefix="sp1", instance.name="_sclerite_", instance.class="AISM_0000062", namespace="obo", link="AISM_0000519", organism.id='sp1',
#                   functional.class="AISM_0000029")

# Make base: tergite to species and the sequence
make_base(organism.id=SPECIES, tergite=BASE)
  
# save file
#py_run_string('aism.save(file = "data/aism_instances.owl", format = "rdfxml")', local = FALSE, convert = F)


#   ____________________________________________________________________________
#   Carabidae (larva)                                                      ####

SPECIES='Carabidae'
# tergite9: "AISM_0004117" 
BASE="AISM_0004118" # tergite10 

# make Organism
spec <- paste0('dwc.Organism("', SPECIES, '")')
py_run_string(spec, local = FALSE, convert = F)

# make sequence 
make_instance_seq(n=1, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000008", functional.class=NA,
                  instance.name="_sclerite_",  namespace="obo", link="obo.BFO_0000051")


# add 'paired' to Carabidae_sclerite_1
py_run_string('obo.Carabidae_sclerite_1.is_a.append(obo.AISM_0000522)', local = FALSE, convert = F )

# Make base: tergite to species and the sequence
make_base(organism.id=SPECIES, tergite=BASE, tergite_scl_link="BFO_0000051")



#   ____________________________________________________________________________
#   Psocidae (Psocodea)                                                     ####

SPECIES='Psocidae'
BASE="AISM_0004118" # tergite10 

# make Organism
spec <- paste0('dwc.Organism("', SPECIES, '")')
py_run_string(spec, local = FALSE, convert = F)

# AISM_0000530 setose
# make sequence of 4 sclerites that is an appendage
make_instance_seq(n=1, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000530", functional.class=NA,
                  instance.name="_sclerite_",  namespace="obo", link="obo.BFO_0000051")


# add 'paired' 
py_run_string('obo.Psocidae_sclerite_1.is_a.append(obo.AISM_0000522)', local = FALSE, convert = F )

# Make base: tergite to species and the sequence
make_base(organism.id=SPECIES, tergite=BASE, tergite_scl_link="AISM_0000519")


#   ____________________________________________________________________________
#   Dermaptera                                                            ####

SPECIES='Dermaptera'
BASE="AISM_0004118" # tergite10 should be 11

# make Organism
spec <- paste0('dwc.Organism("', SPECIES, '")')
py_run_string(spec, local = FALSE, convert = F)

# AISM_0000530 setose
# make sequence of 4 sclerites that is an appendage
make_instance_seq(n=1, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000029", functional.class=NA,
                  instance.name="_sclerite_",  namespace="obo", link=NA)


# add 'paired' 
py_run_string('obo.Dermaptera_sclerite_1.is_a.append(obo.AISM_0000522)', local = FALSE, convert = F )

# Make base: tergite to species and the sequence
make_base(organism.id=SPECIES, tergite=BASE, tergite_scl_link="AISM_0000519")


#   ____________________________________________________________________________
#   Archaeognatha                                                           ####

SPECIES='Archaeognatha'
BASE="AISM_0004118" # tergite10 should be 11

# make Organism
spec <- paste0('dwc.Organism("', SPECIES, '")')
py_run_string(spec, local = FALSE, convert = F)

# AISM_0000530 setose
# make sequence of 4 sclerites that is an appendage
make_instance_seq(n=3, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000003", functional.class="AISM_0000008",
                  instance.name="_sclerite_",  namespace="obo", link="AISM_0000519")


# add 'paired' 
#py_run_string('obo.Dermaptera_sclerite_1.is_a.append(obo.AISM_0000522)', local = FALSE, convert = F )

# Make base: tergite to species and the sequence
make_base(organism.id=SPECIES, tergite=BASE, tergite_scl_link="AISM_0000519")

# save file
#py_run_string('aism.save(file = "aism_instances.owl", format = "rdfxml")', local = FALSE, convert = F)

#   ____________________________________________________________________________
#   Aphididae   (Not cercus)                                                ####

SPECIES='Aphididae'
BASE="AISM_0004093" # tergite6

# make Organism
spec <- paste0('dwc.Organism("', SPECIES, '")')
py_run_string(spec, local = FALSE, convert = F)

# AISM_0000530 setose
# make sequence of 4 sclerites that is an appendage
make_instance_seq(n=1, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000029", functional.class=NA,
                  instance.name="_sclerite_",  namespace="obo", link=NA)


# add 'paired' 
py_run_string('obo.Aphididae_sclerite_1.is_a.append(obo.AISM_0000522)', local = FALSE, convert = F )

# Make base: tergite to species and the sequence
make_base(organism.id=SPECIES, tergite=BASE, tergite_scl_link="AISM_0000519")




# save file
py_run_string('aism.save(file = "data/aism_instances.owl", format = "rdfxml")', local = FALSE, convert = F)


#------ Now Run Reasoner see README
# Konclude realization -i data/aism_instances.owl -o results/aism_instances-Konclude.owl
#








