class TumorEvaluation < ActiveRecord::Base
  extend Enumerize
  include Constant

  enumerize :target_lesion_evaluation, in: EVALUATION_OPT
  enumerize :no_target_lesion_evaluation, in: EVALUATION_OPT2
  enumerize :lesion_evaluation, in: EVALUATION_OPT

  belongs_to :patient

  has_many :target_lesions, dependent: :destroy
  has_many :no_target_lesions, dependent: :destroy
  has_many :new_lesions, dependent: :destroy

  accepts_nested_attributes_for :target_lesions,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :no_target_lesions,
                                reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :new_lesions,
                                reject_if: :all_blank, allow_destroy: true

  validates_associated :new_lesions
  validates_associated :no_target_lesions
  validates_associated :target_lesions

  validates :patient_id, presence: true
  validates :interview, presence: true

  enumerize :interview, in: {"0":0, "1":1, "2":2, "3":3, "4":4, "5":5,
                             "6":6, "7":7, "8":8, "9":9, "10":10,
                             "11":11, "12":12, "13":13, "14":14, "15":15,
                             "16":16, "17":17, "18":18, "19":19, "20":20,
                             "21":21, "22":22, "23":23, "24":24, "25":25,
                             "26":26, "27":27, "28":28, "29":29, "30":30,
                             "31":31, "32":32, "33":33, "34":34, "35":35,
                             "36":36, "37":37, "38":38, "39":39, "40":40,
                             "41":41, "42":42, "43":43, "44":44, "45":45,
                             "46":46, "47":47, "48":48, "49":49, "50":50,
                             "extra":51}

end
