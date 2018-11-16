class Ability
  include CanCan::Ability

  def initialize(user,project)
    #must login before any action
    if !project.present?
      project=Project.find(6)
    end
    if user.present?
      #super_intendent:
      # if user.role.pri==0
      #   can :manage,:all
      # end

      # system relevant
      if user.role.pri==1
        can :manage,User,:role=>{pri:2..5}
        can :read,Role
        can :manage,Center

      end

      if user.role.pri==0
        can :manage,User
        can :manage,Role
        can :manage,Center

      end

      if user.role.pri<=1
        can :manage,MonitorCheckersController
      end
      # project relevant
      if user.role.pri==1
        can [:create,:read,:update],Project,initiator_id:user.id
        can [:read,:update],ResearchGroup,:project=>{initiator_id:user.id}
        can :create,ResearchGroup
        can :manage,Relationship
      end

      if user.role.pri==0
        can :manage,Project
        can :manage,ResearchGroup
        can :manage,Relationship
      end

      # patient relevant
      patient_model_list=[AdverseEvent,BasementAssessment,GroupInformation,ClinicalPathology,
                          Course,RadiationTherapy,ConcomitantDrug,BiologicalSampleCollection,
                          MedicationCompletion,ReserachCompletion,Followup,DeathRecord,
                          FollowupMonitor,CourseMonitor]
      user.relationships.where(project_id:project.id).each{|re|
        center_id=re.center_id
        privelege={:center_id => center_id,:project_id=>project.id}
        can :manage,Patient,privelege
        can :manage,patient_model_list,:patient=>privelege
      }

    end
  end
end
