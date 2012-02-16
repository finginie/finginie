module NumberHelper
 def number_to_indian_currency(number)
   "#{number.to_s.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/, "\\1,")}"
 end
end
