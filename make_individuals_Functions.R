# make_instance_seq(n=1, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000029", functional.class=NA,
#                   instance.name="_sclerite_",  namespace="obo", link="obo.BFO_0000051")

# make_instance_seq(n=4, prefix=SPECIES, organism.id=SPECIES, instance.class="AISM_0000003", functional.class="AISM_0000029",
#                   instance.name="_sclerite_",  namespace="obo", link="AISM_0000519")

make_instance_seq <- function(n=3, prefix="sp1", instance.name="_sclerite_", instance.class="AISM_0000062", namespace="obo", link="AISM_0000519", organism.id=NA,
                              functional.class="AISM_0000029"){
  
  fcla <- NA
  #-- make sclerites -- members of the sequence
  scl <- paste0(prefix, instance.name)
  nmsp.instance.class=paste0(namespace, ".", instance.class)
  
  scl.ids <- paste0(scl, c(1:n))
  scl.str <-sapply(scl.ids, function(x) paste0(nmsp.instance.class, "(\"", x, "\")") )
  sapply(scl.str, function(x) py_run_string(x, local = FALSE, convert = F))
  #--
  
  #----- link the sclerites
  # obo.ring_sclerite_1.RO_0002150=[obo.ring_sclerite_2]
  # AISM_0000519 #links to
  
  nmsp.scl.ids=paste0(namespace, ".", scl.ids)
  if (n>2){
    link.str <- c()
    for (i in 1:(n-1)){
      link.str <- c(link.str, paste0(nmsp.scl.ids[i], '.', link, '=[', nmsp.scl.ids[i+1], ']' ) )
    }
    # if not rev(link.str) then owlready overwrites the relationships: have no idea why!
    sapply(rev(link.str), function(x) py_run_string(x, local = FALSE, convert = F))
  }

  
  # assign all sclerites in sequence  in a functional class e.g., 'appendage'
  if (!is.na(functional.class)){
    # create class
    fcla <- paste0(prefix, '_descriptor')
    FCLA <- paste0("obo.", functional.class, "(\"", fcla, "\")")
    py_run_string(FCLA, local = FALSE, convert = F)
    
    # add bilateral class
    #bilat <- paste0('obo.', fcla, '.is_a.append(obo.AISM_0000522)' )
    bilat <- paste0('obo.', fcla, '.is_a.append(obo.PATO_0040024)' )
    py_run_string(bilat, local = FALSE, convert = F)
    
    #nmsp.scl.ids=paste0(namespace, ".", scl.ids)
    #obo.appendage_1.BFO_0000051=[obo.ring_sclerite_1, obo.ring_sclerite_2]
    str1 <- paste0('obo.', fcla, '.BFO_0000051=[', paste0(nmsp.scl.ids, collapse=', '), ']' )
    py_run_string(str1, local = FALSE, convert = F)
    
    
  }
  
  # assign all created instances to an organism
  if (!is.na(organism.id)){
    x1 <- paste0(nmsp.scl.ids, collapse=', ')
    if (!is.na(functional.class)){
      x1 <-c(x1, paste0('obo.', fcla))
    }
    
    x1 <- paste0(x1, collapse = ', ')
    #str3 <- paste0('dwc.', prefix, '.BFO_0000051=[', x1, ']' )
    str3 <- paste0('obo.', prefix, '.BFO_0000051=[', x1, ']' )
    py_run_string(str3, local = FALSE, convert = F)
    
  }
  
}



make_base <- function(organism.id='sp1', tergite="AISM_0004117", tergite_scl_link="AISM_0000519"){
  
  tergite.id <- paste0( organism.id, "_tergite" )
  cmd1 <- paste0("obo.", tergite, "('",  tergite.id, "')" ) # set which tergite id
  #cmd2 <- paste0("dwc.", organism.id, ".BFO_0000051.append(obo.", tergite.id, ")") # species has tergite
  cmd2 <- paste0("obo.", organism.id, ".BFO_0000051.append(obo.", tergite.id, ")") # species has tergite
  
  cmd3 <-paste0("obo.", tergite.id, ".", tergite_scl_link, "=[obo.", organism.id, "_sclerite_1]") # tergite encircles sclerite
  
  # # Create base: tergites etc
  # tergite1<-"obo.AISM_0004117('sp1_tergite')"
  # tergite2 <- "dwc.sp1.BFO_0000051.append(obo.sp1_tergite)" # APPEnding!!!!
  # tergite3 <- "obo.sp1_tergite.AISM_0000519=[obo.sp1_sclerite_1]"
  
  # execute
  py_run_string(cmd1, local = FALSE, convert = F)
  py_run_string(cmd2, local = FALSE, convert = F)
  py_run_string(cmd3, local = FALSE, convert = F)
}
