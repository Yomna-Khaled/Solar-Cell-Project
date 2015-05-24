class Quantity < ActiveRecord::Base
<<<<<<< HEAD
	has_many :materials
=======
	has_many :materials, dependent: :destroy
>>>>>>> 2cd586b4c59c2be944f758d138837899cd5a1b40
end
