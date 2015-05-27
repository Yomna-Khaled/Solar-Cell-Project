class ReportPdf < Prawn::Document
  def initialize(shift , manager ,crew_member_numbers ,shift_produced_rate ,total_power)
    super()
    @shifts = shift
    @managers = manager
    @crew_member_number = crew_member_numbers
    @shift_produced_rate = shift_produced_rate
    @total_power = total_power
    
    header
    shift_Info
    
  end
 
  def header
    
    text "HEADER", :align => :center, :size => 20
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




end