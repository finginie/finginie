module NumberHelper
 def number_to_indian_currency(number, precision = 2)
    precision_number = number_with_precision(number, :precision => precision)
   "#{precision_number.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/, "\\1,")}"
 end
end
