class Patient < ActiveRecord::Base
  extend Enumerize

  enumerize :status,
            in: {
                a:  0,
                b:  1,
                c:  2,
            },
            predicates: true,
            scope: true
end
