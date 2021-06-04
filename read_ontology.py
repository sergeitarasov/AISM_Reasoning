#---- VARIABLE
#ONTO_PATH="/Users/taravser/Documents/My_papers/AISM/Cercus_reasoning/AISM_Reasoning"

#----------


import os
ONTO_PATH=os.getcwd()
#os.chdir(ONTO_PATH)
print(ONTO_PATH)

from owlready2 import *
onto_path.append(ONTO_PATH+"/data")

aism = get_ontology("aism-merged.owx")
aism.load()
obo = aism.get_namespace("http://purl.obolibrary.org/obo/")
dwc=aism.get_namespace("http://rs.tdwg.org/dwc/terms/") # Organism

exit
