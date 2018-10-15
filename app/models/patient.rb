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
end
