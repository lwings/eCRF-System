class Patient < ActiveRecord::Base
  extend Enumerize

  enumerize :status,
            in: {
                established:  0,
                researching:  1,
                followup:  2,
                end:3,
                quit:4
            },
            predicates: true,
            scope: true

  belongs_to :project
  belongs_to :research
  belongs_to :research_group
  belongs_to :user
  has_one :basement_assessment, dependent: :destroy
  has_one :clinical_pathology, dependent: :destroy
  has_one :reserach_completion, dependent: :destroy
  has_one :medication_completion, dependent: :destroy
  has_one :group_information, dependent: :destroy
  has_many :adverse_events, dependent: :destroy
  has_many :courses, dependent: :destroy
  has_many :radiation_therapies, dependent: :destroy
  has_many :concomitant_drugs, dependent: :destroy
  has_many :biological_sample_collections, dependent: :destroy
  has_many :followups, dependent: :destroy
  has_many :death_records, dependent: :destroy




end
