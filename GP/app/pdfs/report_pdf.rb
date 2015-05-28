class ReportPdf < Prawn::Document
  def initialize(shift , manager ,crew_member_numbers ,shift_produced_rate ,total_power , materials_used)
    super()
    @shifts = shift
    @managers = manager
    @crew_member_number = crew_member_numbers
    @shift_produced_rate = shift_produced_rate
    @total_power = total_power
    @materials_used = materials_used
    
    header
    shift_Info
    table_content
    
  end
 
  def header
    text "Shift Report", :align => :center, :size => 20
    move_down 12
  end

  def shift_Info
        @shifts[0].start_shift_time.to_s.sub("2000-01-01", "") 
        start_Time = @shifts[0].start_shift_time.to_s.sub("UTC", "") 

        @shifts[0].end_shift_time.to_s.sub("2000-01-01", "") 
        end_Time = @shifts[0].end_shift_time.to_s.sub("UTC", "") 

      
        font "Helvetica", :style => :bold
        text "Shift start Date : #{@shifts[0].start_shift_date.to_s} @   #{start_Time} "
        text "Shift End Date : #{@shifts[0].end_shift_date.to_s}  @  #{end_Time}"
        text "Manager Name : #{@managers}"
        text "Number of workers/Crew : #{@crew_member_number}"
        text "Production Rate : #{@shift_produced_rate} pannels"
      
        text "Total Power : #{@total_power} watte"

        font "Helvetica", :style => :normal
        text "Total Number of produced pannels : #{@shifts[0].production_rate.to_s}"
        
        text "Total produced Power : #{@shifts[0].production_rate.to_s}"
        
       
  end




 def table_content
  table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
      # self.column_widths = [7400220.0, 7400022.0, 74000.0 , 74000.0]
 end
end



  def product_rows
    [['Material Name', 'Quantity Used ', 'Theoritical Value' , 'Percentage %']] +
      @materials_used.map do |material|
        
      [material.quant, material.quant, "4" , "20"]
    end
  end



end