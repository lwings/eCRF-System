module Constant
  TWOTUPLE_OPT={normal:0,abnormal:1}
  TRIPLET_OPT_I={yes:0,no:1,unknown:2}
  TRIPLET_OPT_II={neg:0,pos:1,unknown:2}
  DIAGNOSE_OPT={normal:0,abnormal_withsigni:1,abnormal_outsigni:2,unevaluable:3}
  PRILESION_OPT={"1a":0,"1b":1,"1c":2,"2":3,"3":4,"4":5,"is":6,"x":7,"1":8}
  LYMNODE_OPT={"0":0,"1":1,"2":2,"3":3,unknown:4,"x":5}
  HISTYPE_OPT={invasive_ductal_carcinoma:0,invasive_lobular_carcinoma:1,
               mucinous_carcinoma:2,DCIS:3,IDC_DCIS:4,MBC:5,others:6}
  HISGRAD_OPT={"I":0,"I~II":1,"II":2,"II~III":3,"III":4,unknown:5}
  HER2IHC_OPT={"0":0,"+":1,"+~++":2,"++":3,"++~+++":4,"+++":5,unknown:6}
  DIEASESTAT_OPT={cured:0,drug_control:1,no_drug_control:2}
  DIEASEPROCESSION_OPT={alive:0,die_of_breast_cancer:1,die_of_other_cancers:2,unknown:3}
  EVENTS_OPT={leukopenia:0,neutropenia:1,anemia:2,thrombocytopenia:3,febrile_neutropenia:4,
  infection:5,nausea:6,vomiting:7,anorexia:8,diarrhea:9,weak:10,
      hair_loss:11,hand_foot_syndrome:12,skin_subtissue_disease:13,allery:14,
              weight_gain:15,weight_loss:16,muscle_ache:17,joint_pain:18,bone_pain:19,
  peripheral_neuropathy:20,fibrinase_elevation:21,fracture:22,death:23,
  hypertension:24,other:25}
  TURNOVER_OPT={not_recover:0,recovering:1,recovered:2,unknown:3}
  RELAITHDRUGS_OPT={relevant:0,possibly_relevant:1,possibly_irrelevant:2,irrelevant:3}
  RADIOSITE_OPT={ chest_wall: 0, axilla: 1, collarbone: 2, internal_breast: 3,
                  whole_breast: 4, tumor_bed_boost: 5, others: 6 , unkown:7}
  THERAPYTYPE_OPT={adjuvant_therapy:0,new_adjucant_therapy:1,therapeutic:2}
  INTERVIEW_OPT={arbitrary:0,C5D1:1,research_complete:2,disease_process:3}
  BIOSAMPLE_OPT={serum:0,plasma:1,blood:2,paraffin_primary:3,
                 fresh_primary:4,paraffin_meta:5,fresh_mata:6}
  DELAY_OPT={adverse_event:0,others:1}
  DOSECHANGE_OPT={adverse_event:0,err_dose:1,others:2}
  QUITREASON_OPT={adverse_event:0,abnormal_val:1,abnormal_res:2,relapse_meta:3,aginst_plan:4,
  withdraw:5,loss_connection:6,researcher_request:7,death:8}
  DEATH_OPT={die_of_breast_cancer:0,die_of_other_cancers:1,unknown:2}
  BLOODRNAME_OPT={leukocyte:0,neutrophil_abs:1,red_blood_cell:2,platelet:3,hematocrit:4,hemoglobin:5}
  BLOODCNAME_OPT={alanine_aminotransferase:0,aspartate_aminotransferase:1,
                 alkaline_phosphatase:2,total_bilirubin:3,direct_bilirubin:4,creatinine:5,
                  urea:6,transpeptidase:7,blood_glucose:8,albumin:9}
  BLOODRUNIT_OPT={"X10^9/L":0,"g/L":1,"X10^12/L":2}
  BLOODCUNIT_OPT={"IU/L":0,"umol/L":1,"mmol/L":2,"g/L":2}
  TUMORNAME_OPT={carcinoembryonic_antigen:0,carbohydrate_antigen_125:1,carbohydrate_antigen_153:2}
  TUMORUNIT_OPT={"U/mL":0,others:1}
  OP_BREAST_MODE_OPT={conserve:0, mastectomy:1, NSM:2}
  OP_ARMPIT_MODE_OPT={axilla:0, sentinel:1}

  BIOPSY_POSITION_OPT={left:0, right:1, liver:2, lung:3, bone:4, brain:5, chest_wall_soft_tissue:6, skin:7, lymph:8}
  BIOPSY_MODE_OPT={thick_needle:0, fine_needle:1, Mammotome:2, cut:3, resection:4}
  STRENGTH_OPT={neg:0, weak:1, weak_mid:2, mid:3, strength_mid:4, strength:5}
  OP_POSITION_OPT={left:0, right:1}
  MATASTASIS_OPT={"0":0, "1":1}


end
