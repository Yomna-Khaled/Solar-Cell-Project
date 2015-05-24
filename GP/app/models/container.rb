class Container < ActiveRecord::Base
	has_many :vendors,:through=> :vendor_containers
end
