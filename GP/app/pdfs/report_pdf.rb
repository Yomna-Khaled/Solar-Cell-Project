class ReportPdf < Prawn::Document
  def initialize(shift , manager ,crew_member_numbers ,shift_produced_rate ,total_power , materials_used_id , crew_Members , solar_panels)
    super()
    @shifts = shift
    @managers = manager
    @crew_member_number = crew_member_numbers
    @shift_produced_rate = shift_produced_rate
    @total_power = total_power
    @materials_used_id = materials_used_id
    @crew_Members = crew_Members
    @solar_panels = solar_panels

    logo
    header
    shift_Info
    solar_info
    table_content
   
    
  end
 
  def logo
    logopath =  "#{Rails.root}/app/assets/images/logo.png"
    image logopath, :width => 100, :height => 60
    stroke do
      horizontal_line 0 , 600
    end
    move_down 12
  end

  def header
  
    text"Shift Report", :align => :center, :size => 20 , :style => :bold
     stroke do
      horizontal_line 210 , 330
    end
    move_down 12
  end

  def shift_Info
    # shift info title
  formatted_text [
     {:text => "Shift Basic Information :" , :styles => [:bold]} ,    
  ]

  #SIFT BASIC INFORMATION:
  bounding_box([0,cursor],:width=>500,:height=>60) do
    transparent(0.5){stroke_bounds}
    indent(20) do
        move_down 10

        start_Time = @shifts[0].start_shift_time.to_s.sub("2000-01-01", "") 
        start_Time = start_Time.to_s.sub("+0200", "") 
        
        end_Time = @shifts[0].end_shift_time.to_s.sub("2000-01-01", "") 
        end_Time = end_Time.to_s.sub("+0200", "")
        #start date for shift
        formatted_text [
           {:text => "Start Date :" , :styles => [:bold] } ,
           {:text => "#{@shifts[0].start_shift_date.to_s} @ #{start_Time}" }
        ]
        
          #End date for shift
        formatted_text [
           {:text => "End Date :" , :styles => [:bold] } ,
           {:text => " #{@shifts[0].end_shift_date.to_s}  @ #{end_Time}" }
        ]

        #shift manager
        formatted_text [
           {:text => "Shift Manager:" , :styles => [:bold] } ,
           {:text => " #{@managers}" }
        ]

    end
  end
  move_down 10

  #CREW INFORMATIONS
  formatted_text [
     {:text => "Crew Information :" , :styles => [:bold]} ,    
  ]

 i = @crew_member_number.no_of_workers.to_i * 14;
  bounding_box([0,cursor],:width=>500,:height=>(60+ i.to_i) ) do
    transparent(0.5){stroke_bounds}
    indent(20) do
        move_down 10
        #crew Name
        formatted_text [
           {:text => "Crew Name :" , :styles => [:bold] } ,
           {:text => " #{@crew_member_number.name.to_s} " }
        ]

        #number of workers in crew 
        formatted_text [
           {:text => "Number of workers/Crew :" , :styles => [:bold] } ,
           {:text => " #{@crew_member_number.no_of_workers} workers" }
        ]  
         
        #crew members Names 
        
        formatted_text [
           {:text => "Crew Members:" , :styles => [:bold] }
        ]
        
        @crew_Members.map do |member|
          indent(30) do
            text "#{member.full_name}"
          end
        end


    end
  end
   move_down 10

  #PRODUCTION INFORMATIONS
  formatted_text [
     {:text => "Production Information :" , :styles => [:bold]} ,    
  ]

  bounding_box([0,cursor],:width=>500,:height=>40) do
    transparent(0.5){stroke_bounds}
    indent(20) do
        move_down 10

        # production rate 
        formatted_text [
           {:text => "Production Rate :" , :styles => [:bold] } ,
           {:text => " #{@shift_produced_rate} pannels" }
        ]

        # produced power 
        formatted_text [
           {:text => "Total Produced Power :" , :styles => [:bold] } ,
           {:text => " #{@total_power} watte" }
        ]        

    end
  end
  move_down 10
   formatted_text [
     {:text => "Stock State Befor and After Production :" , :styles => [:bold]} ,    
  ]
               
end


 def table_content
  table material_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
  end
end



  def material_rows
    move_down 10
    [['Material Name', 'Quantity Used in Shift', 'Theoritical Quantity ' , 'Wast Percentage %']] +
      @materials_used_id.map do |m|
        theoritical =0 ;
        #calculating waste in materials 
        #loop through all pannels/shift
         @solar_panels.map do |p|
            cat_id = p.theoreticalcategory_id
            theoritical = theoritical + MaterialTheoreticals.where("material_id = ? AND theoreticalcategory_id = ? " , m.id , cat_id)[0].value;
         end
        #check type of each pannel and calculate the theoritical value 
        #then calculate the percentatge 
        percent = (m.sum / theoritical )* 100
      [m.name, m.sum, "4" , percent ]
    end
  end

  def solar_info
    table pannel_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end
  end

   def pannel_rows
    [['Pannel Serial Number ', 'Type-SubType', 'Cell Numbers' , 'Power']] +
      @solar_panels.map do |m|
      [m.serialNo, m.celltype+" - "+m.subtype, m.cellno , m.power ]
    end
  end

end
