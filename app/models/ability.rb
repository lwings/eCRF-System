class Ability
  include CanCan::Ability

  def initialize(user,project)
    #must login before any action
    if user.present? and project.present?
      #super_intendent:
      if user.role.pri==0
        can :manage,:all
      end

      # system relevant
      if user.role.pri==1
        can :manage,User
        can :read,Role
        can :manage,Center
      end

      # project relevant
      if user.role.pri==1
        can [:create,:read,:update],Project
        can [:create,:read,:update],ResearchGroup
      end

      patient_model_list=[AdverseEvent,BasementAssessment,GroupInformation,ClinicalPathology,
                          Course,RadiationTherapy,ConcomitantDrug,BiologicalSampleCollection,
                          MedicationCompletion,ReserachCompletion,Followup,DeathRecord,
                          FollowupMonitor,CourseMonitor]
      #patient relevant
      user.relationships.where(project_id:project.id).each{|re|
        center_id=re.center_id
        privelege={:user_id => user.id, :center_id => center_id,:project_id=>project.id}
        can :manage,Patient,privelege
        can :manage,patient_model_list,:patient=>privelege
      }







    end
  end
end
