module NumberHelper
  def number_to_indian_format(number, precision = 2)
    number = (number.nil? || number.to_s == "NaN") ? 0 : number
    precision_number = number_with_precision(number, :precision => precision)
    "#{precision_number.gsub(/(\d+?)(?=(\d\d)+(\d)(?!\d))(\.\d+)?/, "\\1,")}"
  end
end
