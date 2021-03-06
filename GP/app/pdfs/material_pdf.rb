class MaterialPdf < Prawn::Document
  def initialize(material , material_vendor , material_properties)
    super()
    @material = material
    @material_vendor = material_vendor
    @material_properties = material_properties
    
    logo
    header
    material_basic_info
    stock_info
    material_date
    material_vendors
    material_property

  end


  def logo
    logopath =  "#{Rails.root}/app/assets/images/header.jpg"
    image logopath, :width => 550, :height => 60
    stroke do
      horizontal_line 0 , 550
    end
    move_down 12
  end

  def header
  
    text"Material Report", :align => :center, :size => 20 , :style => :bold
     stroke do
      horizontal_line 190 , 350
    end
    move_down 12
  end


  def material_basic_info
      formatted_text [
         {:text => "Material Basic Information :" , :styles => [:bold]} ,    
      ]

      bounding_box([0,cursor],:width=>500,:height=>45) do
        transparent(0.5){stroke_bounds}
        indent(20) do
              move_down 10

              formatted_text [
                   {:text => "Serial Number :" , :styles => [:bold] } ,
                   {:text => "#{@material.serial_number}" }
                ]

              formatted_text [
                   {:text => "Price :" , :styles => [:bold] } ,
                   {:text => "#{@material.price} LE" }
                ] 
        end
      end

  end


  def stock_info
      move_down 10
      formatted_text [
         {:text => "Stock Information :" , :styles => [:bold]} ,    
      ]

      bounding_box([0,cursor],:width=>500,:height=>70) do
        transparent(0.5){stroke_bounds}
        indent(20) do
              move_down 10

              formatted_text [
                   {:text => "Quantity :" , :styles => [:bold] } ,
                   {:text => "#{@material.quantity_value}" }
                ]

              formatted_text [
                   {:text => "Stock Number :" , :styles => [:bold] } ,
                   {:text => "#{@material.serial_number}" }
                ] 

           formatted_text [
               {:text => "Shelf Number :" , :styles => [:bold] } ,
               {:text => "#{@material.shelfNo}" }
            ]   

        formatted_text [
               {:text => "Minmum Number :" , :styles => [:bold] } ,
               {:text => "#{@material.Min_Number}" }
            ]            
        end
      end
    end


      def material_date
      move_down 10
      formatted_text [
         {:text => "Material Date :" , :styles => [:bold]} ,    
      ]

      bounding_box([0,cursor],:width=>500,:height=>45) do
        transparent(0.5){stroke_bounds}
        indent(20) do
              move_down 10

              formatted_text [
                   {:text => "Production Date :" , :styles => [:bold] } ,
                   {:text => "#{@material.production_date}" }
                ]

              formatted_text [
                   {:text => "Expiration Date :" , :styles => [:bold] } ,
                   {:text => "#{@material.expiration_date}" }
                ] 

        end
      end

  end


  def material_vendors
      move_down 10
      formatted_text [
         {:text => "Material Vendor :" , :styles => [:bold]} ,    
      ]

 @vendor_name = @material_vendor.where("material_id=? AND date IS NULL",@material.id).order(updated_at: :desc)[0].vendor.name
 @allvendors =  @material_vendor.where("material_id=?",@material.id).order(updated_at: :desc)

    i = @allvendors.count * 55 
      bounding_box([0,cursor],:width=>500,:height=>40+ i.to_i) do
        transparent(0.5){stroke_bounds}
        indent(20) do
              move_down 10

              formatted_text [
                   {:text => "Vendor Name :" , :styles => [:bold] } ,
                   {:text => "#{@vendor_name}" }
                ]


              formatted_text [
                   {:text => "Material Vendors History :" , :styles => [:bold] }
                ] 

             table vendor_rows do
              row(0).font_style = :bold
              self.header = true
              self.row_colors = ['DDDDDD', 'FFFFFF']
            end



        end
      end



  end

  def vendor_rows
    [['Vendor Name', 'Start Date', 'End Date' ]] +
      @allvendors.map do |vendor|
            if vendor.date == nil
                [vendor.vendor.name, vendor.created_at.strftime('%Y-%m-%d'), "current" ]     
            else
                [vendor.vendor.name, vendor.created_at.strftime('%Y-%m-%d'), vendor.date ]
            end
          
    end
  end


def material_property
     move_down 10
      formatted_text [
         {:text => "Material properties :" , :styles => [:bold]} ,    
      ]

      x = @material_properties.count * 30
      bounding_box([0,cursor],:width=>500,:height=> x.to_i) do
        transparent(0.5){stroke_bounds}
        indent(20) do
              move_down 10

     @material_properties.map do |materialproperty|

      formatted_text [
           {:text => materialproperty.property.name+": ", :styles => [:bold] } ,
           {:text => materialproperty.value }
        ]
        
     end

 end
 end

end






end
